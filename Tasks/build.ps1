[CmdletBinding()]
param(
    [switch]
    $Bootstrap,

    [switch]
    $Compile,

    [switch]
    $Test,

    [switch]
    $CodeCoverage
)

# Write information
Write-Host "PS Version Information"
Write-Host "----------------------"
Write-Host ($PSVersionTable | ConvertTo-JSON -Depth 1)
Write-Host "Process Bitness"
Write-Host "---------------"
If ([IntPtr]::Size -eq 4) {
    Write-Host "32 bit"
}
Else {
    Write-Host "64 bit"
}
Write-Host ''

$RootDir = Join-Path $PSScriptRoot '..'
$OutputDir = Join-Path $RootDir 'Output'

# Bootstrap step
if ($Bootstrap.IsPresent) {
    Write-Information "Validate and install missing prerequisits for building ..."

    # For testing Pester
    if (-not (Get-Module -Name Pester -ListAvailable) -or (Get-Module -Name Pester -ListAvailable)[0].Version -eq [Version]'3.4.0') {
        Write-Warning "Module 'Pester' is missing. Installing 'Pester' ..."
        Install-Module -Name Pester -Scope CurrentUser -Force -RequiredVersion 4.10.1 -SkipPublisherCheck
    }

    if ((Get-Module -Name Pester -ListAvailable)[0].Version -ne [Version]'4.10.1') {
        Install-Module -Name Pester -Scope CurrentUser -Force -RequiredVersion 4.10.1
    }

    Import-Module -Name Pester -RequiredVersion 4.10.1

    if (-not (Get-Module -Name PSCodeCovIo -ListAvailable)) {
        Write-Warning "Module 'PSCodeCovIo' is missing. Installing 'PSCodeCovIo' ..."
        Install-Module -Name PSCodeCovIo -Scope CurrentUser -Force
    }
}

# Compile step
if ($Compile.IsPresent) {
    $CompileDir = Join-Path $OutputDir 'BurntToast'
    $OutputZip = Join-Path $RootDir 'Output/BurntToast.zip'

    if ((Test-Path $OutputDir)) {
        Remove-Item -Path $OutputDir -Recurse -Force
    }

    # Copy non-script files to output folder
    $null = New-Item -Path $CompileDir -ItemType Directory

    Write-Host "Copying support files ..."
    Copy-Item -Path "$RootDir/BurntToast/*" -Filter '*.*' -Exclude '*.ps1', '*.psm1' -Recurse -Destination $CompileDir -Force
    Remove-Item -Path "$CompileDir/Private", "$CompileDir/Public" -Recurse -Force

    # Copy Module README file
    Copy-Item -Path "$RootDir/README.md" -Destination $CompileDir -Force

    Write-Host "Adding Private Functions ..."
    Get-ChildItem -Path "$RootDir\BurntToast\Private\*.ps1" -Recurse | Get-Content | Add-Content "$CompileDir/BurntToast.psm1"

    Write-Host "Adding Public Functions ..."
    $Public = @( Get-ChildItem -Path "$RootDir/BurntToast/Public/*.ps1" -ErrorAction SilentlyContinue )

    $Public | Get-Content | Add-Content "$CompileDir/BurntToast.psm1"

    "`$PublicFunctions = '$($Public.BaseName -join "', '")'" | Add-Content "$CompileDir/BurntToast.psm1"

    Write-Host "Adding Module Template file ..."
    Get-Content -Path (Join-Path $PSScriptRoot 'BurntToast-Template.psm1') | Add-Content "$CompileDir/BurntToast.psm1"

    # Compress output, for GitHub release
    Write-Host "Creating ZIP file ..."
    Compress-Archive -Path "$CompileDir/*" -DestinationPath $OutputZip

    # Re-import module, extract release notes and version
    if (Get-Module BurntToast) {
        Remove-Module BurntToast -Force
    }

    Import-Module "$CompileDir/BurntToast.psd1" -Force
    Write-Host "Extracting Release Notes and Version ..."
    (Get-Module BurntToast)[0].ReleaseNotes | Add-Content (Join-Path $OutputDir 'release-notes.txt')
    (Get-Module BurntToast)[0].Version.ToString() | Add-Content (Join-Path $OutputDir 'release-version.txt')
    Write-Host "Finished Compiling"
}

# Test step
if ($Test.IsPresent) {
    if (-not (Get-Module -Name Pester -ListAvailable)) {
        throw "Cannot find the 'Pester' module. Please specify '-Bootstrap' to install build dependencies."
    }

    if (-not (Get-Module -Name PSCodeCovIo -ListAvailable)) {
        throw "Cannot find the 'PSCodeCovIo' module. Please specify '-Bootstrap' to install build dependencies."
    }

    if ($ENV:BURNTTOAST_MODULE_ROOT) {
        $ModuleDir = (Get-Item -Path $ENV:BURNTTOAST_MODULE_ROOT).Directory.FullName
        Write-Host "Using Module Root directory of $ModuleDir"
        $RelevantFiles = (Get-ChildItem $ModuleDir -Recurse -Include "*.psm1", "*.ps1").FullName
    } else {
        $RelevantFiles = (Get-ChildItem ./BurntToast -Recurse -Include "*.psm1", "*.ps1").FullName
    }

    if ($env:CI) {
        Write-Host "Running Pester within CI with code coverage for $($RelevantFiles.Count) file/s"
        $res = Invoke-Pester "./Tests" -OutputFormat JUnitXml -OutputFile TestResults.xml -CodeCoverage $RelevantFiles -CodeCoverageOutputFileFormat 'JaCoCo' -CodeCoverageOutputFile CoverageResults.xml -PassThru
        if ($res.FailedCount -gt 0) { throw "$($res.FailedCount) tests failed." }
    }
    else {
        $res = Invoke-Pester "./Tests" -CodeCoverage $RelevantFiles -PassThru
    }

    if ($CodeCoverage.IsPresent) {
        Export-CodeCovIoJson -CodeCoverage $res.CodeCoverage -RepoRoot $pwd -Path coverage.json

        Invoke-WebRequest -Uri 'https://codecov.io/bash' -OutFile codecov.sh
    }
}

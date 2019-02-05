[CmdletBinding()]
param(
    [switch]
    $Bootstrap,

    [switch]
    $Compile,

    [switch]
    $Test
)

# Bootstrap step
if ($Bootstrap.IsPresent) {
    Write-Information "Validate and install missing prerequisits for building ..."

    # For testing Pester
    if (-not (Get-Module -Name Pester -ListAvailable)) {
        Write-Warning "Module 'Pester' is missing. Installing 'Pester' ..."
        Install-Module -Name Pester -Scope CurrentUser -Force
    }

    if (-not (Get-Module -Name PSCodeCovIo -ListAvailable)) {
        Write-Warning "Module 'PSCodeCovIo' is missing. Installing 'PSCodeCovIo' ..."
        Install-Module -Name PSCodeCovIo -Scope CurrentUser -Force
    }
}

# Compile step
if ($Compile.IsPresent) {
    if (Get-Module BurntToast) {
        Remove-Module BurntToast -Force
    }

    if ((Test-Path ./Output)) {
        Remove-Item -Path ./Output -Recurse -Force
    }

    # Copy non-script files to output folder
    if (-not (Test-Path .\Output)) {
        $null = New-Item -Path .\Output -ItemType Directory
    }

    Copy-Item -Path '.\BurntToast\*' -Filter '*.*' -Exclude '*.ps1', '*.psm1' -Recurse -Destination .\Output -Force
    Remove-Item -Path .\Output\Private, .\Output\Public -Recurse -Force

    # Copy Module README file
    Copy-Item -Path '.\README.md' -Destination .\Output -Force

    Get-ChildItem -Path ".\BurntToast\Private\*.ps1" -Recurse | Get-Content | Add-Content .\Output\BurntToast.psm1

    $Public  = @( Get-ChildItem -Path ".\BurntToast\Public\*.ps1" -ErrorAction SilentlyContinue )

    $Public | Get-Content | Add-Content .\Output\BurntToast.psm1

    "`$PublicFunctions = '$($Public.BaseName -join "', '")'" | Add-Content .\Output\BurntToast.psm1

    Get-Content -Path .\Azure-Pipelines\BurntToast-Template.psm1 | Add-Content .\Output\BurntToast.psm1

    Remove-Item -Path .\BurntToast -Recurse -Force
    Rename-Item -Path .\Output -NewName 'BurntToast'

    # Compress output, for GitHub release
    Compress-Archive -Path .\BurntToast\* -DestinationPath .\Azure-Pipelines\BurntToast.zip

    # Re-import module, extract release notes and version
    Import-Module ./BurntToast/BurntToast.psd1 -Force
    (Get-Module BurntToast)[0].ReleaseNotes | Add-Content .\Azure-Pipelines\release-notes.txt
    (Get-Module BurntToast)[0].Version.ToString() | Add-Content .\Azure-Pipelines\release-version.txt
}

# Test step
if($Test.IsPresent) {
    if (-not (Get-Module -Name Pester -ListAvailable)) {
        throw "Cannot find the 'Pester' module. Please specify '-Bootstrap' to install build dependencies."
    }

    if (-not (Get-Module -Name PSCodeCovIo -ListAvailable)) {
        throw "Cannot find the 'PSCodeCovIo' module. Please specify '-Bootstrap' to install build dependencies."
    }

    $RelevantFiles = (Get-ChildItem ./BurntToast -Recurse -Include "*.psm1","*.ps1").FullName

    $RelevantFiles = (Get-ChildItem ./BurntToast -Recurse -Include "*.psm1","*.ps1").FullName

    if ($env:TF_BUILD) {
        $res = Invoke-Pester "./Tests" -OutputFormat NUnitXml -OutputFile TestResults.xml -CodeCoverage $RelevantFiles -PassThru
        if ($res.FailedCount -gt 0) { throw "$($res.FailedCount) tests failed." }
    } else {
        $res = Invoke-Pester "./Tests" -CodeCoverage $RelevantFiles -PassThru
    }

    Export-CodeCovIoJson -CodeCoverage $res.CodeCoverage -RepoRoot $pwd -Path coverage.json

    Invoke-WebRequest -Uri 'https://codecov.io/bash' -OutFile codecov.sh
}

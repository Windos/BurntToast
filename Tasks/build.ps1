[CmdletBinding()]
param(
    [switch]
    $Compile,

    [switch]
    $Test
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
    Copy-Item -Path "$RootDir/src/*" -Filter '*.*' -Exclude '*.ps1', '*.psm1' -Recurse -Destination $CompileDir -Force
    Remove-Item -Path "$CompileDir/Private", "$CompileDir/Public" -Recurse -Force

    # Copy Module README file
    Copy-Item -Path "$RootDir/README.md" -Destination $CompileDir -Force

    Write-Host "Adding Private Functions ..."
    Get-ChildItem -Path "$RootDir/src/Private/*.ps1" -Recurse | Get-Content | Add-Content "$CompileDir/BurntToast.psm1"

    Write-Host "Adding Public Functions ..."
    $Public = @( Get-ChildItem -Path "$RootDir/src/Public/*.ps1" -ErrorAction SilentlyContinue )

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
    Write-Host "Running Pester within CI with code coverage"

    $PesterConfig = New-PesterConfiguration

    $PesterConfig.Run.Path = './tests'
    $PesterConfig.Run.PassThru = $true

    $PesterConfig.TestResult.Enabled = $true
    $PesterConfig.TestResult.OutputFormat = 'JUnitXml'
    $PesterConfig.TestResult.OutputPath = 'TestResults.xml'

    if ($null -eq $ENV:BURNTTOAST_MODULE_ROOT) {
        $PesterConfig.CodeCoverage.Enabled = $true
        $PesterConfig.CodeCoverage.OutputFormat = 'JaCoCo'
        $PesterConfig.CodeCoverage.OutputPath = 'CoverageResults.xml'
        $PesterConfig.CodeCoverage.Path = './src'
        $PesterConfig.CodeCoverage.RecursePaths = $true
    }

    $res = Invoke-Pester -Configuration $PesterConfig
    if ($res.FailedCount -gt 0) { throw "$($res.FailedCount) tests failed." }
}

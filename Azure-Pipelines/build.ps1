[CmdletBinding()]
param(
    [switch]
    $Bootstrap,

    [switch]
    $Test
)

$VerbosePreference = Continue

# Bootstrap step
if ($Bootstrap.IsPresent) {
    Write-Verbose "Validate and install missing prerequisits for building ..."

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

# Test step
if($Test.IsPresent) {
    if (-not (Get-Module -Name Pester -ListAvailable)) {
        throw "Cannot find the 'Pester' module. Please specify '-Bootstrap' to install build dependencies."
    }

    if (-not (Get-Module -Name PSCodeCovIo -ListAvailable)) {
        throw "Cannot find the 'PSCodeCovIo' module. Please specify '-Bootstrap' to install build dependencies."
    }

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

[CmdletBinding()]
param(
    [switch]
    $Bootstrap,

    [switch]
    $Test
)

# Bootstrap step
if ($Bootstrap.IsPresent) {
    Write-Host "Validate and install missing prerequisits for building ..."

    # For testing Pester
    if (-not (Get-Module -Name Pester -ListAvailable)) {
        Write-Warning "Module 'Pester' is missing. Installing 'Pester' ..."
        Install-Module -Name Pester -Scope CurrentUser -Force
    }
}

# Test step
if($Test.IsPresent) {
    if (-not (Get-Module -Name Pester -ListAvailable)) {
        throw "Cannot find the 'Pester' module. Please specify '-Bootstrap' to install build dependencies."
    }

    if ($env:TF_BUILD) {
        $res = Invoke-Pester "$PSScriptRoot/Tests" -OutputFormat NUnitXml -OutputFile TestResults.xml -PassThru
        if ($res.FailedCount -gt 0) { throw "$($res.FailedCount) tests failed." }
    } else {
        Invoke-Pester "$PSScriptRoot/Tests"
    }
}

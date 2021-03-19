$ExcludedRules = @()

$PssaSplat = @{
    Path          = ".\src"
    Recurse       = $true
    EnableExit    = $true
    ReportSummary = $true
    ExcludeRule   = $ExcludedRules
    #Severity      = 'Error'
}

Invoke-ScriptAnalyzer @PssaSplat

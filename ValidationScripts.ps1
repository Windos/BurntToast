#requires -Version 3
function Test-ToastImage
{
    param
    (
        [Parameter()]
        [String] $Path
    )

    if (Test-Path -Path $Path) 
    {
        $true
    }
    else 
    {
        throw "The file '$Path' doesn't exist in the specified location. Please provide a valid path and try again."
    }
}

function Test-ToastAppId
{
    param
    (
        [Parameter()]
        [String] $Id
    )

    if ((Get-StartApps | Where-Object -Property AppId -EQ -Value $Id |
    Measure-Object).Count -gt 0) 
    {
        $true
    }
    else 
    {
        throw "A shortcut with the AppId '$Id' doesn't exist on the Start Screen/Menu. " +
        'Please provide a valid AppId and try again.'
    }
}

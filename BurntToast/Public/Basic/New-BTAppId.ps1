function New-BTAppId
{
    <#
        .SYNOPSIS

        .DESCRIPTION
        
        .PARAMETER AppId

        .INPUTS
        System.String

        You cannot pipe input to this cmdlet.

        .OUTPUTS
        None

        .NOTES
        The New-BTAppId function is classified as: Basic

        .EXAMPLE

        .EXAMPLE
        
        .LINK
        https://github.com/Windos/BurntToast/blob/master/Help/New-BTAppId.md
    #>

    param
    (
        [Parameter()]
        [ValidateNotNullOrEmpty()] 
        [string] $AppId = $Script:Config.AppId
    )
    
    $RegPath = 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Notifications\Settings'
    
    if (!(Test-Path -Path "$RegPath\$AppId"))
    {
        $null = New-Item -Path $RegPath -Name $AppId
        $null = New-ItemProperty -Path "$RegPath\$AppId" -Name 'ShowInActionCenter' -Value 1 -PropertyType 'DWORD'
    }
    else
    {
        Write-Warning -Message 'Specified AppId is already present in the registry.'
    }
}

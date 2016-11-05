function Set-BTFunctionLevel
{
    <#
        .SYNOPSIS
        
        .DESCRIPTION
        
        .INPUTS
        None

        You cannot pipe input to this cmdlet.

        .OUTPUTS
        
        .NOTES

        .EXAMPLE
        Set-BTFunctionLevel

        .EXAMPLE
        Set-BTFunctionLevel -FunctionLevel Advanced
        
        .LINK
        https://github.com/Windos/BurntToast
    #>
    [alias()]
    [CmdletBinding()]
    [OutputType($null)]
    param
    (
        [Parameter()]
        [ValidateSet('Basic','Advanced')] 
        [string] $FunctionLevel = 'Basic'
    )
    
    $ConfigPath = "$PSScriptRoot\..\..\config.json"
    $CurrentLevel = $Script:Config.FunctionLevel


    if ($CurrentLevel -ne $FunctionLevel)
    {
        $Script:Config.FunctionLevel = $FunctionLevel

        try
        {
        
            $Script:Config | ConvertTo-Json | Out-File -FilePath $ConfigPath -Encoding utf8
            Write-Warning -Message 'Configuration updated, please re-import the BurntToast module or start a new PowerShell session to reflect this function level change.'
        }
        catch
        {
            #TODO: Write/Link to better instructions
            Write-Error -Message "Unable to update $ConfigPath, try running PowerShell as an administrator or moving the BurntToast module to your user directory."
        }
    }
}

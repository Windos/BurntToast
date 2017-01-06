function Get-BTFunctionLevel
{
    <#
        .SYNOPSIS
        Displays the current function level of the BurntToast module.
        
        .DESCRIPTION
        The Get-BTFunctionLevel function returns the current function level of the BurntToast module as defined in config.json.

        .INPUTS
        None

        You cannot pipe input to this cmdlet.

        .OUTPUTS
        System.String

        .NOTES
        The Get-BTFunctionLevel function is classified as: Basic

        .EXAMPLE
        Get-BTFunctionLevel

        This command returns the function level of the BurntToast module as a string.
        
        .LINK
        https://github.com/Windos/BurntToast/blob/master/Help/Get-BTFunctionLevel.md

        .LINK
        Set-BTFunctionLevel
    #>

    [OutputType([string])]
    [CmdletBinding()]
    param ()
    
    $Script:Config.FunctionLevel
}

function Get-BTFunctionLevel
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
        Get-BTFunctionLevel
        
        .LINK
        https://github.com/Windos/BurntToast
    #>
    [alias()]
    [CmdletBinding()]
    [OutputType([string])]
    param ()
    
    $Script:Config.FunctionLevel
}

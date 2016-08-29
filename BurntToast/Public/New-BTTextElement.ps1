#requires -Version 2 
function New-CrumpetTextElement
{
    <#
        .SYNOPSIS
        
        .DESCRIPTION
        
        .INPUTS
        None

        You cannot pipe input to this cmdlet.

        .OUTPUTS
        None
        
        .NOTES
        
        .EXAMPLE
        
        .EXAMPLE

        .EXAMPLE

        .EXAMPLE

        .EXAMPLE
        
        .LINK
        https://github.com/Windos/BurntToast
    #>

    [CmdletBinding()]
    [OutputType([Text])]
    param
    (
        [Parameter(Mandatory = $false)]
        [alias('Text')]
        [String] $Content = ''
    )

    if ($Content)
    {
        [Text]::new($Content)
    }
    else
    {
        [Text]::new($true)
    }
}

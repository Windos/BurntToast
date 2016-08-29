#requires -Version 2 
function New-CrumpetAudioElement
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

    [CmdletBinding(DefaultParameterSetName = 'Sound')]
    [OutputType([Audio])]
    param
    (
        [Parameter(Mandatory = $false,
                   ParameterSetName = 'Sound')]
        [alias('Sound')]
        [AudioSource] $Source = 'Default',

        [Parameter(Mandatory = $false,
                   ParameterSetName = 'Sound')]
        [String] $Path,

        [Parameter(Mandatory = $true,
                   ParameterSetName = 'Silent')]
        [Switch] $Silent
    )

    if ($Silent)
    {
        [Audio]::new($true)
    }
    else
    {
        if ($Path)
        {
            [Audio]::new($Path)
        }
        else
        {
            [Audio]::new($Source)
        }
    }
}

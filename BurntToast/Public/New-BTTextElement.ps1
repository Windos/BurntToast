using module BurntToast.Class

function New-BTTextElement
{
    <#
        .SYNOPSIS
        Creates a new Text Element for Toast Notifications.

        .DESCRIPTION
        The New-BTTextElement cmdlet creates a new Text Element for Toast Notifications.
    
        You can specify the text you want displayed in a Toast Notification as a string, or run the cmdlet without a paramter for a blank line.

        Each Text Element is the equivalent of one line in on a Toast Notification, long lines will wrap.

        .INPUTS
        String

        You cannot pipe input to this cmdlet.

        .OUTPUTS
        Text
        
        .EXAMPLE
        New-BTTextElement -Content 'This is a line with text!'

        Creates a Text Element that will show the string 'This is a line with text!' on a Toast Notification.

        .EXAMPLE
        New-BTTextElement

        Creates a Text Element that will show a blank line on a Toast Notification.

        .NOTES
        TODO: Implement hint-style (https://blogs.msdn.microsoft.com/tiles_and_toasts/2015/06/30/adaptive-tile-templates-schema-and-documentation/)

        .LINK
        https://github.com/Windos/BurntToast
    #>

    [CmdletBinding()]
    [OutputType([Text])]
    param
    (
        [Parameter()]
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

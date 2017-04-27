function New-BTText {
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
    [OutputType([Microsoft.Toolkit.Uwp.Notifications.AdaptiveText])]
    param (
        [Parameter()]
        [alias('Content')]
        [string] $Text,

        [int] $MaxLines,

        [int] $MinLines,

        [switch] $Wrap,

        [Microsoft.Toolkit.Uwp.Notifications.AdaptiveTextAlign] $Align,

        [Microsoft.Toolkit.Uwp.Notifications.AdaptiveTextStyle] $Style,

        [string] $Language
    )

    $TextObj = [Microsoft.Toolkit.Uwp.Notifications.AdaptiveText]::new()

    if ($Text) {
        $TextObj.Text = $Text
    }

    if ($MaxLines) {
        $TextObj.HintMaxLines = $MaxLines
    }

    if ($MinLines) {
        $TextObj.HintMinLines = $MinLines
    }

    if ($Wrap) {
        $TextObj.HintWrap = $Wrap
    }

    if ($Align) {
        $TextObj.HintAlign = $Align
    }

    if ($Style) {
        $TextObj.HintStyle = $Style
    }

    if ($Language) {
        $TextObj.Language = $Language
    }

    $TextObj
}

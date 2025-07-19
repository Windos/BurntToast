function New-BTText {
    <#
        .SYNOPSIS
        Creates a new text element for Toast Notifications.

        .DESCRIPTION
        The New-BTText function creates an AdaptiveText object for Toast Notifications, used to display a line (or wrapped lines) of text. All formatting and layout options (wrapping, lines, alignment, style, language) are customizable.

        .PARAMETER Text
        The text to display as the content. If omitted, a blank line is produced. Aliased as 'Content'.

        .PARAMETER MaxLines
        Maximum number of lines the text may display (wraps/collapses extra lines).

        .PARAMETER MinLines
        Minimum number of lines that must be shown.

        .PARAMETER Wrap
        Switch. Enable/disable word wrapping.

        .PARAMETER Align
        Property for horizontal alignment of the text.

        .PARAMETER Style
        Controls font size, weight, opacity for the text.

        .PARAMETER Language
        BCP-47 language tag for payload, e.g. "en-US" (overrides parent).

        .PARAMETER Bind
        Switch. Indicates the text comes from a data binding expression (for advanced scenarios).

        .INPUTS
        None. You cannot pipe input to this function.

        .OUTPUTS
        Microsoft.Toolkit.Uwp.Notifications.AdaptiveText

        .EXAMPLE
        New-BTText -Content 'This is a line with text!'
        Creates a text element that will show this string in a Toast Notification.

        .EXAMPLE
        New-BTText
        Creates a blank line in the Toast.

        .LINK
        https://github.com/Windos/BurntToast/blob/main/Help/New-BTText.md
    #>

    [CmdletBinding(SupportsShouldProcess = $true,
                   HelpUri = 'https://github.com/Windos/BurntToast/blob/main/Help/New-BTText.md')]
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

        [string] $Language,

        [switch] $Bind
    )

    $TextObj = [Microsoft.Toolkit.Uwp.Notifications.AdaptiveText]::new()

    if ($Text) {
        $TextObj.Text = $Text -replace '\x01'
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

    if($PSCmdlet.ShouldProcess("returning: [$($TextObj.GetType().Name)]:Text=$($TextObj.Text.BindingName):HintMaxLines=$($TextObj.HintMaxLines):HintMinLines=$($TextObj.HintMinLines):HintWrap=$($TextObj.HintWrap):HintAlign=$($TextObj.HintAlign):HintStyle=$($TextObj.HintStyle):Language=$($TextObj.Language)")) {
        $TextObj
    }
}

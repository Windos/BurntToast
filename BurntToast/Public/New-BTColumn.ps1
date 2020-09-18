function New-BTColumn {
    <#
        .SYNOPSIS
        Creates a new Text Element for Toast Notifications.

        .DESCRIPTION
        The New-BTText function creates a new Text Element for Toast Notifications.

        You can specify the text you want displayed in a Toast Notification as a string, or run the function without a paramter for a blank line.

        Each Text Element is the equivalent of one line in on a Toast Notification, long lines will wrap.

        .INPUTS
        String

        You cannot pipe input to this function.

        .OUTPUTS
        Text

        .EXAMPLE
        New-BTText -Content 'This is a line with text!'

        Creates a Text Element that will show the string 'This is a line with text!' on a Toast Notification.

        .EXAMPLE
        New-BTText

        Creates a Text Element that will show a blank line on a Toast Notification.

        .NOTES
        TODO: Implement hint-style (https://blogs.msdn.microsoft.com/tiles_and_toasts/2015/06/30/adaptive-tile-templates-schema-and-documentation/)

        Credit for most of the help text for this function go to the authors of the UWPCommunityToolkit library that this module relies upon.

        Please see the originating repo here: https://github.com/Microsoft/UWPCommunityToolkit

        .LINK
        https://github.com/Windos/BurntToast/blob/main/Help/New-BTText.md
    #>

    # [CmdletBinding(SupportsShouldProcess = $true)]
    [OutputType([Microsoft.Toolkit.Uwp.Notifications.AdaptiveSubgroup])]
    param (
        # The text to display. Data binding support added in Creators Update, only works for toast top-level text elements (But appears to not be working via PowerShell yet.)
        [Parameter()]
        [Microsoft.Toolkit.Uwp.Notifications.IAdaptiveSubgroupChild[]] $Children,

        # The maximum number of lines the text element is allowed to display. For Toasts, top-level text elements will have varying max line amounts (and in the Anniversary Update you can change the max lines).
        #
        # Text on a Toast inside a group (not yet implemented) will behave identically to Tiles (default to infinity).
        [int] $Weight,

        # The minimum number of lines the text element must display. Note that for Toast, this property will only take effect if the text is inside a group (not yet implemented.)
        [Microsoft.Toolkit.Uwp.Notifications.AdaptiveSubgroupTextStacking] $TextStacking
    )

    $AdaptiveSubgroup = [Microsoft.Toolkit.Uwp.Notifications.AdaptiveSubgroup]::new()

    if ($Children) {
        foreach ($Child in $Children) {
            $AdaptiveSubgroup.Children.Add($Child)
        }
    }

    if ($Weight) {
        $AdaptiveSubgroup.HintWeight = $Weight
    }

    if ($TextStacking) {
        $AdaptiveSubgroup.HintTextStacking = $TextStacking
    }

    #if($PSCmdlet.ShouldProcess("returning: [$($TextObj.GetType().Name)]:Text=$($TextObj.Text.BindingName):HintMaxLines=$($TextObj.HintMaxLines):HintMinLines=$($TextObj.HintMinLines):HintWrap=$($TextObj.HintWrap):HintAlign=$($TextObj.HintAlign):HintStyle=$($TextObj.HintStyle):Language=$($TextObj.Language)")) {
    $AdaptiveSubgroup
    #}
}

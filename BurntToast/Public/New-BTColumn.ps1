function New-BTColumn {
    <#
        .SYNOPSIS
        Creates a new Column Element for Toast Notifications.

        .DESCRIPTION
        The New-BTColumn function creates a new Column Element, or Adaptive Subgroup, for Toast Notifications.

        Valid content for an Adaptive Subgroup include Adaptive Text (New-BTText) and Adaptive Images (New-BTImage).

        These columns are supplied to the Column parameter on either the New-BTBinding or New-BurntToastNotification functions.

        .INPUTS
        int
        Microsoft.Toolkit.Uwp.Notifications.IAdaptiveSubgroupChild
        Microsoft.Toolkit.Uwp.Notifications.AdaptiveSubgroupTextStacking

        You cannot pipe input to this function.

        .OUTPUTS
        Microsoft.Toolkit.Uwp.Notifications.AdaptiveSubgroup

        .EXAMPLE
        PS C:\>$HeadingText = New-BTText -Text 'Now Playing'

        PS C:\>$TitleLabel = New-BTText -Text 'Title:' -Style Base
        PS C:\>$AlbumLabel = New-BTText -Text 'Album:' -Style Base
        PS C:\>$ArtistLabel = New-BTText -Text 'Artist:' -Style Base

        PS C:\>$Title = New-BTText -Text 'soft focus' -Style BaseSubtle
        PS C:\>$Album = New-BTText -Text 'Birocratic' -Style BaseSubtle
        PS C:\>$Artist = New-BTText -Text 'beets 4 (2017)' -Style BaseSubtle

        PS C:\>$Column1 = New-BTColumn -Children $TitleLabel, $AlbumLabel, $ArtistLabel -Weight 4
        PS C:\>$Column2 = New-BTColumn -Children $Title, $Album, $Artist -Weight 6

        PS C:\>$Binding1 = New-BTBinding -Children $HeadingText -Column $Column1, $Column2
        PS C:\>$Visual1 = New-BTVisual -BindingGeneric $Binding1
        PS C:\>$Content1 = New-BTContent -Visual $Visual1

        PS C:\>Submit-BTNotification -Content $Content1

        This example results in a toast notification displaying hard coded music information.

        Two columns are created, the first containing three labels with the 'Base' text style,
        the second column contains the corresponding three peices of data that match the labels.

        These columns are have relative weights, making the label column smaller than the data column.

        The columns are added to the toast notification via the Column parameter of the New-BTBinding
        function.

        .EXAMPLE
        PS C:\>$TitleLabel = New-BTText -Text 'Title:' -Style Base
        PS C:\>$AlbumLabel = New-BTText -Text 'Album:' -Style Base
        PS C:\>$ArtistLabel = New-BTText -Text 'Artist:' -Style Base

        PS C:\>$Title = New-BTText -Text 'soft focus' -Style BaseSubtle
        PS C:\>$Album = New-BTText -Text 'Birocratic' -Style BaseSubtle
        PS C:\>$Artist = New-BTText -Text 'beets 4 (2017)' -Style BaseSubtle

        PS C:\>$Column1 = New-BTColumn -Children $TitleLabel, $AlbumLabel, $ArtistLabel -Weight 4
        PS C:\>$Column2 = New-BTColumn -Children $Title, $Album, $Artist -Weight 6

        PS C:\>New-BurntToastNotification -Text 'Now Playing' -Column $Column1, $Column2

        This example is similar to the first, except that the toast notification is created via the
        New-BurntToastNotification function rather than the component functions.

        .NOTES
        Credit for most of the help text for this function go to the authors of the WindowsCommunityToolkit library that this module relies upon.

        Please see the originating repo here: https://github.com/windows-toolkit/WindowsCommunityToolkit

        .LINK
        https://github.com/Windos/BurntToast/blob/main/Help/New-BTColumn.md
    #>

    # [CmdletBinding(SupportsShouldProcess = $true)]
    [cmdletBinding(HelpUri = 'https://github.com/Windos/BurntToast/blob/main/Help/New-BTColumn.md')]
    [OutputType([Microsoft.Toolkit.Uwp.Notifications.AdaptiveSubgroup])]
    param (
        # The content to be contained within the column. Can contain text (New-BTText) and images (New-BTImage).
        [Parameter()]
        [Microsoft.Toolkit.Uwp.Notifications.IAdaptiveSubgroupChild[]] $Children,

        # Controls the width of this column in relation to other columns. A higher relative weight results in the wider column.
        [int] $Weight,

        # The vertical alignment of the content inside this column.
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

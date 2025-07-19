function New-BTColumn {
    <#
        .SYNOPSIS
        Creates a new column (Adaptive Subgroup) for Toast Notifications.

        .DESCRIPTION
        The New-BTColumn function creates a column (Adaptive Subgroup) for Toast Notifications.
        Columns contain text and images and are provided to the Column parameter of New-BTBinding or New-BurntToastNotification.
        Content is arranged vertically and multiple columns can be combined for side-by-side layout.

        .PARAMETER Children
        Array. Elements (such as Adaptive Text or Image objects) for display in this column, created via New-BTText or New-BTImage.

        .PARAMETER Weight
        Int. The relative width of this column compared to others in the toast.

        .PARAMETER TextStacking
        Enum. Controls vertical alignment of the content; accepts values from AdaptiveSubgroupTextStacking.

        .INPUTS
        int
        Microsoft.Toolkit.Uwp.Notifications.IAdaptiveSubgroupChild
        Microsoft.Toolkit.Uwp.Notifications.AdaptiveSubgroupTextStacking
        You cannot pipe input to this function.

        .OUTPUTS
        Microsoft.Toolkit.Uwp.Notifications.AdaptiveSubgroup

        .EXAMPLE
        $labels = New-BTText -Text 'Title:' -Style Base
        $values = New-BTText -Text 'Example' -Style BaseSubtle
        $col1 = New-BTColumn -Children $labels -Weight 4
        $col2 = New-BTColumn -Children $values -Weight 6
        New-BTBinding -Column $col1, $col2

        .EXAMPLE
        $label = New-BTText -Text 'Now Playing'
        $col = New-BTColumn -Children $label
        New-BTBinding -Children $label -Column $col

        .LINK
        https://github.com/Windos/BurntToast/blob/main/Help/New-BTColumn.md
    #>

    # [CmdletBinding(SupportsShouldProcess = $true)]
    [cmdletBinding(HelpUri = 'https://github.com/Windos/BurntToast/blob/main/Help/New-BTColumn.md')]
    [OutputType([Microsoft.Toolkit.Uwp.Notifications.AdaptiveSubgroup])]
    param (
        [Parameter()]
        [Microsoft.Toolkit.Uwp.Notifications.IAdaptiveSubgroupChild[]] $Children,

        [int] $Weight,

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

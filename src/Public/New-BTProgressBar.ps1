function New-BTProgressBar {
    <#
        .SYNOPSIS
        Creates a new Progress Bar element for Toast Notifications.

        .DESCRIPTION
        The New-BTProgressBar function creates a new AdaptiveProgressBar element for Toast Notifications, visualizing completion via percentage or indeterminate animation.

        .PARAMETER Title
        Text displayed above the progress bar (optional context).

        .PARAMETER Status
        Mandatory. String describing the current operation status, shown below the bar.

        .PARAMETER Indeterminate
        Switch. When set, an indeterminate animation is shown (can't be used with Value).

        .PARAMETER Value
        Double (0-1). The percent complete (e.g. 0.45 = 45%).

        .PARAMETER ValueDisplay
        String. Replaces default percentage label with a custom one.

        .INPUTS
        None. You cannot pipe input to this function.

        .OUTPUTS
        Microsoft.Toolkit.Uwp.Notifications.AdaptiveProgressBar

        .EXAMPLE
        New-BTProgressBar -Status 'Copying files' -Value 0.2
        Creates a 20% full progress bar showing the status.

        .EXAMPLE
        New-BTProgressBar -Status 'Copying files' -Indeterminate
        Progress bar with indeterminate animation.

        .EXAMPLE
        New-BTProgressBar -Status 'Copying files' -Value 0.2 -ValueDisplay '4/20 files complete'
        Progress bar at 20%, overridden label text.

        .EXAMPLE
        New-BTProgressBar -Title 'File Copy' -Status 'Copying files' -Value 0.2
        Displays title and status.

        .EXAMPLE
        $Progress = New-BTProgressBar -Status 'Copying files' -Value 0.2
        New-BurntToastNotification -Text 'File copy script running', 'More details!' -ProgressBar $Progress
        Toast notification includes a progress bar.

        .LINK
        https://github.com/Windos/BurntToast/blob/main/Help/New-BTProgressBar.md
    #>

    [CmdletBinding(DefaultParameterSetName = 'Determinate',
                   SupportsShouldProcess   = $true,
                   HelpUri = 'https://github.com/Windos/BurntToast/blob/main/Help/New-BTProgressBar.md')]
    param (
        [string] $Title,

        [Parameter(Mandatory)]
        [string] $Status,

        [Parameter(Mandatory,
                   ParameterSetName = 'Indeterminate')]
        [switch] $Indeterminate,

        [Parameter(Mandatory,
                   ParameterSetName = 'Determinate')]
        #[ValidateRange(0.0, 1.0)]
        $Value,

        [string] $ValueDisplay
    )

    $ProgressBar = [Microsoft.Toolkit.Uwp.Notifications.AdaptiveProgressBar]::new()

    $ProgressBar.Status = $Status

    if ($PSCmdlet.ParameterSetName -eq 'Determinate') {
        $ProgressBar.Value = [Microsoft.Toolkit.Uwp.Notifications.BindableProgressBarValue]::new($Value)
    } else {
        $ProgressBar.Value = 'indeterminate'
    }


    if ($Title) {
        $ProgressBar.Title = $Title
    }

    if ($ValueDisplay) {
        $ProgressBar.ValueStringOverride = $ValueDisplay
    }

    if($PSCmdlet.ShouldProcess("returning: [$($ProgressBar.GetType().Name)]:Status=$($ProgressBar.Status.BindingName):Title=$($ProgressBar.Title.BindingName):Value=$($ProgressBar.Value.BindingName):ValueStringOverride=$($ProgressBar.ValueStringOverride.BindingName)")) {
        $ProgressBar
    }
}

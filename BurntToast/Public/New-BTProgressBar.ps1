function New-BTProgressBar {
    <#
        .SYNOPSIS
        Creates a new Progress Bar Element for Toast Notifications.

        .DESCRIPTION
        The New-BTProgressBar function creates a new Progress Bar Element for Toast Notifications.

        You must specify the status and value for the progress bar and can optionally give the bar a title and override the automatic text representiation of the progress.

        .INPUTS
        String

        You cannot pipe input to this cmdlet.

        .OUTPUTS
        Microsoft.Toolkit.Uwp.Notifications.AdaptiveProgressBar

        .EXAMPLE
        New-BTProgressBar -Status 'Copying files' -Value 0.2

        This command creates a Progress Bar that is 20% full with the current status of 'Copying files' and the (default) text 20% displayed underneath.

        .EXAMPLE
        New-BTProgressBar -Status 'Copying files' -Indeterminate

        This command creates a Progress Bar with an 'indeterminate' animation rather than a bar filled to a certain percentage.

        .EXAMPLE
        New-BTProgressBar -Status 'Copying files' -Value 0.2 -ValueDisplay '4/20 files complete'

        This command creates a Progress Bar that is 20% full with the current status of 'Copying files' and the default text displayed underneath overridden to '4/20 files complete.'

        .EXAMPLE
        New-BTProgressBar -Title 'File Copy' -Status 'Copying files' -Value 0.2

        This example creates a Progress Bar that is 20% full with the current status of 'Copying files' and the (default) text 20% displayed underneath.

        The Progress Bar is displayed under the title 'File Copy.'

        .EXAMPLE
        $Progress = New-BTProgressBar -Status 'Copying files' -Value 0.2
        New-BurntToastNotification -Text 'File copy script running', 'More details!' -ProgressBar $Progress

        This example creates a Toast Notification which will include a progress bar.

        .LINK
        https://github.com/Windos/BurntToast/blob/main/Help/New-BTProgressBar.md
    #>

    [CmdletBinding(DefaultParameterSetName = 'Determinate',
                   SupportsShouldProcess   = $true,
                   HelpUri = 'https://github.com/Windos/BurntToast/blob/main/Help/New-BTProgressBar.md')]
    param (
        # The text displayed above the progress bar. Generally used to give context around what the bar represents.
        [string] $Title,

        # The text displayed under the progress bar. Used to show the current status of the operation being performed.
        #
        # Examples include: Running, Paused, Stopped, Finished.
        [Parameter(Mandatory)]
        [string] $Status,

        # Used where the percentage complete is unknown, the resulting progress bar displays a system generated animation rather than a filled bar.
        #
        # Cannot be used at the same time as a set Value.
        [Parameter(Mandatory,
                   ParameterSetName = 'Indeterminate')]
        [switch] $Indeterminate,

        # Specifies the percentage to fill the progress bar as represented by a double, between 0 and 1 (inclusive.)
        #
        # For example 0.4 is 40%, 1 is 100%.
        [Parameter(Mandatory,
                   ParameterSetName = 'Determinate')]
        #[ValidateRange(0.0, 1.0)]
        $Value,

        # A string that replaces the default text representation of the percentage complete.
        #
        # The default text for the value 0.2 would be '20%', this parameter replaces this text with something of your own choice.
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

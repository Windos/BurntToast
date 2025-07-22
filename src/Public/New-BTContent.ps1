function New-BTContent {
    <#
        .SYNOPSIS
        Creates a new Toast Content object (base element for displaying a toast).

        .DESCRIPTION
        The New-BTContent function creates a new ToastContent object, the root config for a toast, containing the toast's visual, actions, audio, header, scenario, etc.

        .PARAMETER Actions
        Contains one or more custom actions (buttons, context menus, input fields), created via New-BTAction.

        .PARAMETER ActivationType
        Enum. Specifies what activation type is used when the user clicks the toast body.

        .PARAMETER Audio
        Adds audio properties for the toast, as created by New-BTAudio.

        .PARAMETER Duration
        Enum. How long the toast notification is displayed (Short/Long).

        .PARAMETER Header
        ToastHeader object, created via New-BTHeader, categorizing the toast in Action Center.

        .PARAMETER Launch
        String. Data passed to the activation context when a toast is clicked.

        .PARAMETER Scenario
        Enum. Tells Windows to treat the toast as an alarm, reminder, or more (ToastScenario).

        .PARAMETER Visual
        Required. ToastVisual object, created by New-BTVisual, representing the core content of the toast.

        .PARAMETER ToastPeople
        ToastPeople object, representing recipient/persons (optional, used for group chat/etc).

        .PARAMETER CustomTimestamp
        DateTime. Optional timestamp for when the toast is considered created (affects Action Center sort order).

        .INPUTS
        None. You cannot pipe input to this function.

        .OUTPUTS
        Microsoft.Toolkit.Uwp.Notifications.ToastContent

        .EXAMPLE
        $binding = New-BTBinding -Children (New-BTText -Content 'Title')
        $visual = New-BTVisual -BindingGeneric $binding
        New-BTContent -Visual $visual

        .EXAMPLE
        $content = New-BTContent -Visual $visual -ActivationType Protocol -Launch 'https://example.com'
        Toast opens a browser to a URL when clicked.

        .LINK
        https://github.com/Windos/BurntToast/blob/main/Help/New-BTContent.md
    #>

    [CmdletBinding(SupportsShouldProcess = $true,
                   HelpUri = 'https://github.com/Windos/BurntToast/blob/main/Help/New-BTContent.md')]
    [OutputType([Microsoft.Toolkit.Uwp.Notifications.ToastContent])]
    param (
        [Microsoft.Toolkit.Uwp.Notifications.IToastActions] $Actions,

        [Microsoft.Toolkit.Uwp.Notifications.ToastActivationType] $ActivationType,

        [Microsoft.Toolkit.Uwp.Notifications.ToastAudio] $Audio,

        [Microsoft.Toolkit.Uwp.Notifications.ToastDuration] $Duration,

        [Microsoft.Toolkit.Uwp.Notifications.ToastHeader] $Header,

        [string] $Launch,

        [Microsoft.Toolkit.Uwp.Notifications.ToastScenario] $Scenario,

        [Parameter(Mandatory)]
        [Microsoft.Toolkit.Uwp.Notifications.ToastVisual] $Visual,

        [Microsoft.Toolkit.Uwp.Notifications.ToastPeople] $ToastPeople,

        [datetime] $CustomTimestamp
    )

    $ToastContent = [Microsoft.Toolkit.Uwp.Notifications.ToastContent]::new()

    if ($Actions) {
        $ToastContent.Actions = $Actions
    }

    if ($ActivationType) {
        $ToastContent.ActivationType = $ActivationType
    }

    if ($Audio) {
        $ToastContent.Audio = $Audio
    }

    if ($Duration) {
        $ToastContent.Duration = $Duration
    }

    if ($Header) {
        $ToastContent.Header = $Header
    }

    if ($Launch) {
        $ToastContent.Launch = $Launch
    }

    if ($Scenario) {
        $ToastContent.Scenario = $Scenario
    }

    if ($Visual) {
        $ToastContent.Visual = $Visual
    }

    if ($Actions) {
        $ToastContent.Actions = $Actions
    }

    if ($ToastPeople) {
        $ToastContent.HintPeople = $ToastPeople
    }

    if ($CustomTimestamp) {
        $ToastContent.DisplayTimestamp = $CustomTimestamp
    }

    if($PSCmdlet.ShouldProcess( "returning: [$($ToastContent.GetType().Name)] with XML: $($ToastContent.GetContent())" )) {
        $ToastContent
    }
}

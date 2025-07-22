function New-BTButton {
    <#
        .SYNOPSIS
        Creates a new clickable button for a Toast Notification.

        .DESCRIPTION
        The New-BTButton function creates a new button for a Toast Notification. Up to five buttons can be added to a single Toast notification.
        Buttons may have display text, an icon, an optional activation type, argument string, or serve as system managed Dismiss/Snooze buttons.

        .PARAMETER Snooze
        Switch. Creates a system-handled snooze button. When paired with a selection box on the toast, the snooze time is customizable.

        .PARAMETER Dismiss
        Switch. Creates a system-handled dismiss button.

        .PARAMETER Content
        String. The text to display on this button. For system buttons, this overrides the default label.

        .PARAMETER Arguments
        String. App-defined string to pass when the button is pressed. Often a URI or file path to open.

        .PARAMETER ActivationType
        Enum. Defines the activation type that triggers when the button is pressed. Defaults to Protocol.

        .PARAMETER ImageUri
        String. Path or URI of an image icon to display next to the button label.

        .PARAMETER Id
        String. Specifies an ID associated with another toast control (textbox or selection box). For standard buttons, this aligns the button next to a control, for snooze buttons it associates with a selection box.

        .INPUTS
        None. You cannot pipe input to this function.

        .OUTPUTS
        Microsoft.Toolkit.Uwp.Notifications.ToastButton
        Microsoft.Toolkit.Uwp.Notifications.ToastButtonDismiss
        Microsoft.Toolkit.Uwp.Notifications.ToastButtonSnooze

        .EXAMPLE
        New-BTButton -Dismiss
        Creates a button which mimics the act of 'swiping away' the Toast when clicked.

        .EXAMPLE
        New-BTButton -Snooze
        Creates a snooze button with system default snooze duration.

        .EXAMPLE
        New-BTButton -Snooze -Content 'Sleep' -Id 'TimeSelection'
        Snooze button using the label 'Sleep' and referencing a selection box control.

        .EXAMPLE
        New-BTButton -Content 'Blog' -Arguments 'https://king.geek.nz'
        Regular button that opens a URL when clicked.

        .EXAMPLE
        $pic = 'C:\temp\example.png'
        New-BTButton -Content 'View Picture' -Arguments $pic -ImageUri $pic
        Button with a picture to the left, launches the image file.

        .LINK
        https://github.com/Windos/BurntToast/blob/main/Help/New-BTButton.md
    #>

    [CmdletBinding(DefaultParametersetName = 'Button',
                   SupportsShouldProcess   = $true,
                   HelpUri = 'https://github.com/Windos/BurntToast/blob/main/Help/New-BTButton.md')]
    [OutputType([Microsoft.Toolkit.Uwp.Notifications.ToastButton], ParameterSetName = 'Button')]
    [OutputType([Microsoft.Toolkit.Uwp.Notifications.ToastButtonDismiss], ParameterSetName = 'Dismiss')]
    [OutputType([Microsoft.Toolkit.Uwp.Notifications.ToastButtonSnooze], ParameterSetName = 'Snooze')]

    param (
        [Parameter(Mandatory,
                   ParameterSetName = 'Snooze')]
        [switch] $Snooze,

        [Parameter(Mandatory,
                   ParameterSetName = 'Dismiss')]
        [switch] $Dismiss,

        [Parameter(Mandatory,
                   ParameterSetName = 'Button')]
        [Parameter(ParameterSetName = 'Dismiss')]
        [Parameter(ParameterSetName = 'Snooze')]
        [string] $Content,

        [Parameter(Mandatory,
                   ParameterSetName = 'Button')]
        [string] $Arguments,

        [Parameter(ParameterSetName = 'Button')]
        [Microsoft.Toolkit.Uwp.Notifications.ToastActivationType] $ActivationType = [Microsoft.Toolkit.Uwp.Notifications.ToastActivationType]::Protocol,

        [Parameter(ParameterSetName = 'Button')]
        [Parameter(ParameterSetName = 'Snooze')]
        [string] $ImageUri,

        [Parameter(ParameterSetName = 'Button')]
        [Parameter(ParameterSetName = 'Snooze')]
        [alias('TextBoxId', 'SelectionBoxId')]
        [string] $Id
    )

    switch ($PsCmdlet.ParameterSetName) {
        'Button' {
            $Button = [Microsoft.Toolkit.Uwp.Notifications.ToastButton]::new($Content, $Arguments)

            $Button.ActivationType = $ActivationType

            if ($Id) {
                $Button.TextBoxId = $Id
            }

            if ($ImageUri) {
                $Button.ImageUri = $ImageUri
            }
        }
        'Snooze' {

            if ($Content) {
                $Button = [Microsoft.Toolkit.Uwp.Notifications.ToastButtonSnooze]::new($Content)
            } else {
                $Button = [Microsoft.Toolkit.Uwp.Notifications.ToastButtonSnooze]::new()
            }

            if ($Id) {
                $Button.SelectionBoxId = $Id
            }
            
            if ($ImageUri) {
                $Button.ImageUri = $ImageUri
            }
        }
        'Dismiss' {
            if ($Content) {
                $Button = [Microsoft.Toolkit.Uwp.Notifications.ToastButtonDismiss]::new($Content)
            } else {
                $Button = [Microsoft.Toolkit.Uwp.Notifications.ToastButtonDismiss]::new()
            }
        }
    }

    switch ($Button.GetType().Name) {
        ToastButton { if($PSCmdlet.ShouldProcess("returning: [$($Button.GetType().Name)]:Content=$($Button.Content):Arguments=$($Button.Arguments):ActivationType=$($Button.ActivationType):ImageUri=$($Button.ImageUri):TextBoxId=$($Button.TextBoxId)")) { $Button }}
        ToastButtonSnooze { if($PSCmdlet.ShouldProcess("returning: [$($Button.GetType().Name)]:CustomContent=$($Button.CustomContent):ImageUri=$($Button.ImageUri):SelectionBoxId=$($Button.SelectionBoxId)")) { $Button } }
        ToastButtonDismiss { if($PSCmdlet.ShouldProcess("returning: [$($Button.GetType().Name)]:CustomContent=$($Button.CustomContent):ImageUri=$($Button.ImageUri)")) { $Button } }
    }
}

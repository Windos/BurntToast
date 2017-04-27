﻿function New-BTButton {
    <#
        .SYNOPSIS
        Creates a new clickable button for a Toast Notification.

        .DESCRIPTION
        The New-BTButton function creates a new clickable button for a Toast Notification. Up to five buttons can be added to one Toast.

        Buttons can be fully customized with display text, images and arguments or system handled 'Snooze' and 'Dismiss' buttons.

        .INPUTS
        None
            You cannot pipe input to this function.

        .OUTPUTS
        Microsoft.Toolkit.Uwp.Notifications.ToastButton
        Microsoft.Toolkit.Uwp.Notifications.ToastButtonDismiss
        Microsoft.Toolkit.Uwp.Notifications.ToastButtonSnooze

        .EXAMPLE
        New-BTButton -Dismiss

        This command creates a button which mimmicks the act of 'swiping away' the Toast when clicked.

        .EXAMPLE
        New-BTButton -Snooze

        This command creates a button which will snooze the Toast for the system default snooze time (often 10 minutes).

        .EXAMPLE
        New-BTButton -Snooze -Content 'Sleep' -Id 'TimeSelection'

        This command creates a button which will snooze the Toast for the time selected in the SelectionBox with the ID 'TimeSelection'. The button will show the text 'Sleep' rather than 'Dismiss.'

        .EXAMPLE
        New-BTButton -Content 'Blog' -Arguments 'http://king.geek.nz'

        This command creates a button with the display text "Blog", which will launch a browser window to "http://king.geek.nz" when clicked.

        .EXAMPLE
        $Picture = 'C:\temp\example.png'
        New-BTButton -Content 'View Picture' -Arguments $Picture -ImageUri $Picture

        This example creates a button with the display text "View Picture" with a picture to the left, which will launch the default picture viewer application and load the picture when clicked.

        .LINK
        https://github.com/Windos/BurntToast/blob/master/Help/New-BTButton.md
    #>

    [CmdletBinding(DefaultParametersetName = 'Button')]
    [OutputType([Microsoft.Toolkit.Uwp.Notifications.ToastButton], ParameterSetName = 'Button')]
    [OutputType([Microsoft.Toolkit.Uwp.Notifications.ToastButtonDismiss], ParameterSetName = 'Dismiss')]
    [OutputType([Microsoft.Toolkit.Uwp.Notifications.ToastButtonSnooze], ParameterSetName = 'Snooze')]

    param (
        # Specifies a system handled snooze button. When paired with a selection box the snooze time is customizable and user selectable, otherwise the system default snooze time is used.
        #
        # Display text defaults to a localized 'Snooze', but this can be overridden with the Content parameter.
        [Parameter(Mandatory,
                   ParameterSetName = 'Snooze')]
        [switch] $Snooze,

        # Specifies a system handled dismiss button. Clicking the resulting button has the same affect as 'swiping away' or otherwise dismissing the Toast.
        #
        # Display text defaults to a localized 'Dismiss', but this can be overridden with the Content parameter.
        [Parameter(Mandatory,
                   ParameterSetName = 'Dismiss')]
        [switch] $Dismiss,

        # Specifies the text to display on the button.
        [Parameter(Mandatory,
                   ParameterSetName = 'Button')]
        [Parameter(ParameterSetName = 'Dismiss')]
        [Parameter(ParameterSetName = 'Snooze')]
        [string] $Content,

        # Specifies an app defined string.
        #
        # For the purposes of BurntToast notifications this is generally the path to a file or URI and paired with the Protocol ActivationType.
        [Parameter(Mandatory,
                   ParameterSetName = 'Button')]
        [string] $Arguments,

        # Defines tne ActivationType that is trigger when the button is pressed.
        #
        # Defaults to Protocol which will open the file or URI specified in with the Arguments parameter in the rlevant system default application.
        [Parameter(ParameterSetName = 'Button')]
        [Microsoft.Toolkit.Uwp.Notifications.ToastActivationType] $ActivationType = [Microsoft.Toolkit.Uwp.Notifications.ToastActivationType]::Protocol,

        # Specifies an image icon to display on the button.
        [Parameter(ParameterSetName = 'Button')]
        [string] $ImageUri,

        # Specifies the ID of a relevant Toast control.
        #
        # Standard buttons can be paried with a text box which makes the button appear to the right of it.
        #
        # Snooze buttons can be paired with a selection box to select the ammount of time to snooze.
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
        }
        'Dismiss' {
            if ($Content) {
                $Button = [Microsoft.Toolkit.Uwp.Notifications.ToastButtonDismiss]::new($Content)
            } else {
                $Button = [Microsoft.Toolkit.Uwp.Notifications.ToastButtonDismiss]::new()
            }
        }
    }

    $Button
}

function New-BurntToastShoulderTap {
    <#
        .SYNOPSIS
        Creates and displays a Shoulder Tap notification.

        .DESCRIPTION
        The New-BurntToastShoulderTap function creates and displays a Shoulder Tap notification on Microsoft Windows 10.

        You can provide a static image or animated GIF, which will be displayed above the specified pinned contact.

        You must first pin a contact to the Taskbar using the Windows 10 People app.  Next, you can refer to the contact **by its e-mail address** to display a notification.

        If a matching contact cannot be found, Windows will fall back to a toast notification. This toast notification will also been seen in the Action Center (with or without a working Shoulder Tap.)

        You can optionally call the New-BurntToastShoulderTap function with the ShoulderTap alias.

        .INPUTS
        LOTS...

        .OUTPUTS
        None
            New-BurntToastShoulderTap displays the Shoulder Tap that is created.

        .EXAMPLE
        $Image = 'https://i.imgur.com/WKiNp5o.gif'
        $Contact = 'stormy@example.com'
        $Text = 'First Shoulder Tap', 'This is for the fallback toast.'

        New-BurntToastShoulderTap -Image $Image -Person $Contact -Text $Text

        .NOTES
        There's some manual steps required to create and pin a contact which matches the specified email address in the Person parameter.

        There will be a blog post about this on https://toastit.dev, and also further documented within this module in the next release.

        .LINK
        https://github.com/Windos/BurntToast/blob/main/Help/New-BurntToastShoulderTap.md
    #>

    [Obsolete('This cmdlet is being deprecated, it will be removed in v0.9.0')]
    [Alias('ShoulderTap')]
    [CmdletBinding(SupportsShouldProcess   = $true,
                   HelpUri = 'https://github.com/Windos/BurntToast/blob/main/Help/New-BurntToastShoulderTap.md')]
    param (
        # The URI of the image. Can be a static image or animated GIF.
        [Parameter(Mandatory)]
        [string] $Image,

        # The email address of the "person" from which the Shoulder Tap is coming from.
        #
        # A contact with a matching email address must be pinned to the task bar.
        [Parameter(Mandatory)]
        [string] $Person,

        # Specifies the text to show on the Toast Notification. Up to three strings can be displayed, the first of which will be embolden as a title.
        #
        # The toast version will be shown on screen if the required contact is not pinned to the task bar, and will also appear in the Action Center.
        [ValidateCount(0, 3)]
        [string[]] $Text = 'Default Notification',

        # Specifies the path to an image that will override the default image displayed with a Toast Notification.
        [string] $AppLogo,

        # Allows up to five buttons to be added to the bottom of the Toast Notification. These buttons should be created using the New-BTButton function.
        [Microsoft.Toolkit.Uwp.Notifications.IToastButton[]] $Button,

        # Specify the Toast Header object created using the New-BTHeader function, for seperation/categorization of toasts from the same AppId.
        [Microsoft.Toolkit.Uwp.Notifications.ToastHeader] $Header,

        # Specify one or more Progress Bar object created using the New-BTProgressBar function.
        [Microsoft.Toolkit.Uwp.Notifications.AdaptiveProgressBar[]] $ProgressBar,

        # A string that uniquely identifies a toast notification. Submitting a new toast with the same identifier as a previous toast will replace the previous toast.
        #
        # This is useful when updating the progress of a process, using a progress bar, or otherwise correcting/updating the information on a toast.
        [string] $UniqueIdentifier,

        # The time after which the notification is no longer relevant and should be removed from the People notification and Action Center.
        [datetime] $ExpirationTime,

        # Bypasses display to the screen and sends the notification directly to the Action Center.
        [switch] $SuppressPopup,

        # Sets the time at which Windows should consider the notification to have been created. If not specified the time at which the notification was recieved will be used.
        #
        # The time stamp affects sorting of notifications in the Action Center.
        [datetime] $CustomTimestamp,

        # Specifies the AppId of the 'application' or process that spawned the toast notification.
        #
        # Defaults to the People App, rather than the configured default.
        [string] $AppId = 'Microsoft.People_8wekyb3d8bbwe!x4c7a3b7dy2188y46d4ya362y19ac5a5805e5x'
    )

    $ChildObjects = @()

    foreach ($Txt in $Text) {
        $ChildObjects += New-BTText -Text $Txt -WhatIf:$false
    }

    if ($ProgressBar) {
        foreach ($Bar in $ProgressBar) {
            $ChildObjects += $Bar
        }
    }

    if ($AppLogo) {
        $AppLogoImage = New-BTImage -Source $AppLogo -AppLogoOverride -Crop Circle -WhatIf:$false
    } else {
        $AppLogoImage = New-BTImage -AppLogoOverride -Crop Circle -WhatIf:$false
    }

    $Binding = New-BTBinding -Children $ChildObjects -AppLogoOverride $AppLogoImage -WhatIf:$false

    $ShoulderTapBinding = New-BTShoulderTapBinding -Image (New-BTShoulderTapImage -Source $Image)

    $Visual = New-BTVisual -BindingGeneric $Binding -BindingShoulderTap $ShoulderTapBinding -WhatIf:$false

    $ContentSplat = @{
        'Visual' = $Visual
        'ToastPeople' = (New-BTShoulderTapPeople -Email $Person)
    }

    if ($Header) {
        $ContentSplat.Add('Header', $Header)
    }

    if ($CustomTimestamp) {
        $ContentSplat.Add('CustomTimestamp', $CustomTimestamp)
    }

    $Content = New-BTContent @ContentSplat -WhatIf:$false

    $ToastSplat = @{
        Content = $Content
        AppId = $AppId
    }

    if ($UniqueIdentifier) {
        $ToastSplat.Add('UniqueIdentifier', $UniqueIdentifier)
    }

    if ($ExpirationTime) {
        $ToastSplat.Add('ExpirationTime', $ExpirationTime)
    }

    if ($SuppressPopup.IsPresent) {
        $ToastSplat.Add('SuppressPopup', $true)
    }

    if($PSCmdlet.ShouldProcess( "submitting: $($Content.GetContent())" )) {
        Submit-BTNotification @ToastSplat
    }
}

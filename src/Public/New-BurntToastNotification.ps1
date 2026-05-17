function New-BurntToastNotification {
    <#
        .SYNOPSIS
        Creates and displays a rich Toast Notification for Windows.

        .DESCRIPTION
        The New-BurntToastNotification function creates and displays a Toast Notification supporting text, images, sounds, progress bars, actions, snooze/dismiss, attribution, and more on Microsoft Windows 10+.
        Parameter sets ensure mutual exclusivity (e.g., you cannot use Silent and Sound together).
        The `-Urgent` switch will designate the toast as an "Important Notification" that can break through Focus Assist.

        .PARAMETER Text
        Up to 3 strings to show within the Toast Notification. The first is the title.

        .PARAMETER Column
        Array of columns, created by New-BTColumn, to be rendered side-by-side in the toast.

        .PARAMETER AppLogo
        Path to an image that will appear as the application logo.

        .PARAMETER HeroImage
        Path to a prominent hero image for the notification.

        .PARAMETER Attribution
        Optional attribution text displayed at the bottom of the notification. Only supported on modern versions of Windows.

        .PARAMETER Sound
        The sound to play. Choose from Default, alarms, calls, etc. (Cannot be used with Silent.)

        .PARAMETER Silent
        Switch. Makes the notification silent.

        .PARAMETER SnoozeAndDismiss
        Switch. Adds system-provided snooze and dismiss controls.

        .PARAMETER Button
        Array of button objects for custom actions, created by New-BTButton.

        .PARAMETER Header
        Toast header object (New-BTHeader): categorize or group notifications.

        .PARAMETER ProgressBar
        One or more progress bars, created by New-BTProgressBar, for visualizing progress within the notification.

        .PARAMETER UniqueIdentifier
        Optional string grouping related notifications; allows newer notifications to overwrite older.

        .PARAMETER DataBinding
        Hashtable. Associates string values with binding variables to allow updating toasts by data.

        .PARAMETER ExpirationTime
        DateTime. After which the notification is removed from the Action Center.

        .PARAMETER SuppressPopup
        Switch. If set, the toast is sent to Action Center but not displayed as a popup.

        .PARAMETER CustomTimestamp
        DateTime. Custom timestamp used for Action Center sorting.

        .PARAMETER ActivatedAction
        Script block to invoke when the toast is activated (clicked).

        .PARAMETER DismissedAction
        Script block to invoke when the toast is dismissed by the user.

        .PARAMETER EventDataVariable
        The name of the global variable that will contain event data for use in event handler script blocks.

        .PARAMETER Urgent
        If set, designates the toast as an "Important Notification" (scenario 'urgent'), allowing it to break through Focus Assist.

        .PARAMETER CooldownSeconds
        Minimum seconds between repeated toasts sharing the same UniqueIdentifier.
        Prevents notification spam from rapid-fire scripts, hooks, or automation loops.
        Passed through to Submit-BTNotification where the actual throttle logic runs.

        .PARAMETER AutoAppLogo
        Automatically detects the calling application (terminal, IDE, etc.) by walking the
        process tree, extracts its icon, and uses it as the toast logo. Cannot be combined
        with -AppLogo since they'd conflict over which image to show.

        .PARAMETER AppLogoMap
        Hashtable mapping process names (without .exe) to custom icon file paths.
        Used with -AutoAppLogo to override the auto-detected icon for specific apps.
        Example: @{ 'node' = 'C:\icons\claude.ico' } uses the Claude icon when the
        calling process is node.exe (as it is when running Claude Code).

        .INPUTS
        None. You cannot pipe input to this function.

        .OUTPUTS
        None. New-BurntToastNotification displays the toast, it does not return an object.

        .EXAMPLE
        New-BurntToastNotification
        Shows a toast with all default values.

        .EXAMPLE
        New-BurntToastNotification -Text 'Example', 'Details about the operation.'
        Shows a toast with custom title and body text.

        .EXAMPLE
        $btn = New-BTButton -Content 'Google' -Arguments 'https://google.com'
        New-BurntToastNotification -Text 'New Blog!' -Button $btn
        Displays a toast with a button that opens Google.

        .EXAMPLE
        $header = New-BTHeader -Id '001' -Title 'Updates'
        New-BurntToastNotification -Text 'Major Update Available!' -Header $header
        Creates a categorized notification under the 'Updates' header.

        .EXAMPLE
        New-BurntToastNotification -Text 'Integration Complete' -Attribution 'Powered by BurntToast'
        Displays a notification with attribution at the bottom.

        .LINK
        https://github.com/Windos/BurntToast/blob/main/Help/New-BurntToastNotification.md
    #>

    [Alias('Toast')]
    [CmdletBinding(DefaultParameterSetName = 'Sound',
                   SupportsShouldProcess = $true,
                   HelpUri = 'https://github.com/Windos/BurntToast/blob/main/Help/New-BurntToastNotification.md')]
    param (
        [ValidateCount(0, 3)]
        [String[]] $Text = 'Default Notification',

        [Microsoft.Toolkit.Uwp.Notifications.AdaptiveSubgroup[]] $Column,

        [String] $AppLogo,

        # Auto-detect the calling app (terminal, IDE) and use its icon as the toast logo.
        # Walks the process tree to find the first ancestor with a visible window,
        # extracts its .exe icon, and caches it. Cannot be combined with -AppLogo.
        [Switch] $AutoAppLogo,

        # Override map for AutoAppLogo: keys are process names (without .exe),
        # values are paths to custom icon files. Lets you pin specific icons to
        # specific apps — e.g., @{ 'node' = 'C:\icons\claude.ico' } for Claude Code.
        [hashtable] $AppLogoMap,

        [String] $HeroImage,

        [String] $Attribution,

        [Parameter(ParameterSetName = 'Sound')]
        [Parameter(Mandatory = $true,
                   ParameterSetName = 'Sound-SnD')]
        [Parameter(Mandatory = $true,
                   ParameterSetName = 'Sound-Button')]
        [ValidateSet('Default',
                     'IM',
                     'Mail',
                     'Reminder',
                     'SMS',
                     'Alarm',
                     'Alarm2',
                     'Alarm3',
                     'Alarm4',
                     'Alarm5',
                     'Alarm6',
                     'Alarm7',
                     'Alarm8',
                     'Alarm9',
                     'Alarm10',
                     'Call',
                     'Call2',
                     'Call3',
                     'Call4',
                     'Call5',
                     'Call6',
                     'Call7',
                     'Call8',
                     'Call9',
                     'Call10')]
        [String] $Sound = 'Default',

        [Parameter(Mandatory = $true,
                   ParameterSetName = 'Silent')]
        [Parameter(Mandatory = $true,
                   ParameterSetName = 'Silent-SnD')]
        [Parameter(Mandatory = $true,
                   ParameterSetName = 'Silent-Button')]
        [Switch] $Silent,

        [Parameter(Mandatory = $true,
                   ParameterSetName = 'SnD')]
        [Parameter(Mandatory = $true,
                   ParameterSetName = 'Silent-SnD')]
        [Parameter(Mandatory = $true,
                   ParameterSetName = 'Sound-SnD')]
        [Switch] $SnoozeAndDismiss,

        [Parameter(Mandatory = $true,
                   ParameterSetName = 'Button')]
        [Parameter(Mandatory = $true,
                   ParameterSetName = 'Silent-Button')]
        [Parameter(Mandatory = $true,
                   ParameterSetName = 'Sound-Button')]
        [Microsoft.Toolkit.Uwp.Notifications.IToastButton[]] $Button,

        [Microsoft.Toolkit.Uwp.Notifications.ToastHeader] $Header,

        [Microsoft.Toolkit.Uwp.Notifications.AdaptiveProgressBar[]] $ProgressBar,

        [string] $UniqueIdentifier,

        [hashtable] $DataBinding,

        [datetime] $ExpirationTime,

        [switch] $SuppressPopup,

        [datetime] $CustomTimestamp,

        [scriptblock] $ActivatedAction,

        [scriptblock] $DismissedAction,

        [string] $EventDataVariable,

        [switch] $Urgent,

        # Throttle: minimum seconds between repeated toasts sharing the same UniqueIdentifier.
        # Passed through to Submit-BTNotification where the actual suppression happens.
        [int] $CooldownSeconds
    )

    # AutoAppLogo and AppLogo both control the same image slot — can't use both.
    if ($AutoAppLogo -and $AppLogo) {
        throw 'Cannot use -AutoAppLogo and -AppLogo together. Choose one.'
    }

    $ChildObjects = @()

    foreach ($Txt in $Text) {
        $ChildObjects += New-BTText -Text $Txt -WhatIf:$false
    }

    if ($ProgressBar) {
        foreach ($Bar in $ProgressBar) {
            $ChildObjects += $Bar
        }
    }

    # Resolve which logo to use: explicit path, auto-detected from caller app, or default.
    if ($AutoAppLogo) {
        $detectedIcon = Get-BTCallerAppIcon -AppLogoMap $AppLogoMap
        if ($detectedIcon) {
            $AppLogoImage = New-BTImage -Source $detectedIcon -AppLogoOverride -Crop Circle -WhatIf:$false
        } else {
            # Detection failed — fall back to the default BurntToast logo silently.
            $AppLogoImage = New-BTImage -AppLogoOverride -Crop Circle -WhatIf:$false
        }
    } elseif ($AppLogo) {
        $AppLogoImage = New-BTImage -Source $AppLogo -AppLogoOverride -Crop Circle -WhatIf:$false
    } else {
        $AppLogoImage = New-BTImage -AppLogoOverride -Crop Circle -WhatIf:$false
    }

    if ($Silent) {
        $Audio = New-BTAudio -Silent -WhatIf:$false
    } else {
        if ($Sound -ne 'Default') {
            if ($Sound -like 'Alarm*' -or $Sound -like 'Call*') {
                $Audio = New-BTAudio -Source "ms-winsoundevent:Notification.Looping.$Sound" -Loop -WhatIf:$false
                $Long = $True
            } else {
                $Audio = New-BTAudio -Source "ms-winsoundevent:Notification.$Sound" -WhatIf:$false
            }
        }
    }

    $BindingSplat = @{
        Children        = $ChildObjects
        AppLogoOverride = $AppLogoImage
        WhatIf          = $false
    }

    if ($Attribution) {
        $BindingSplat['Attribution'] = $Attribution
    }

    if ($HeroImage) {
        $BTImageHero = New-BTImage -Source $HeroImage -HeroImage -WhatIf:$false
        $BindingSplat['HeroImage'] = $BTImageHero
    }

    if ($Column) {
        $BindingSplat['Column'] = $Column
    }

    $Binding = New-BTBinding @BindingSplat
    $Visual = New-BTVisual -BindingGeneric $Binding -WhatIf:$false

    $ContentSplat = @{
        'Audio'  = $Audio
        'Visual' = $Visual
    }

    if ($Long) {
        $ContentSplat.Add('Duration', [Microsoft.Toolkit.Uwp.Notifications.ToastDuration]::Long)
    }

    if ($SnoozeAndDismiss) {
        $ContentSplat.Add('Actions', (New-BTAction -SnoozeAndDismiss -WhatIf:$false))
    } elseif ($Button) {
        $ContentSplat.Add('Actions', (New-BTAction -Buttons $Button -WhatIf:$false))
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

    if ($DataBinding) {
        $ToastSplat.Add('DataBinding', $DataBinding)
    }

    # Toast events may not be supported, this check happens inside Submit-BTNotification
    if ($ActivatedAction) {
        $ToastSplat.Add('ActivatedAction', $ActivatedAction)
    }

    if ($DismissedAction) {
        $ToastSplat.Add('DismissedAction', $DismissedAction)
    }

    if ($EventDataVariable) {
        $ToastSplat.Add('EventDataVariable', $EventDataVariable)
    }

    if ($Urgent) {
        $ToastSplat.Add('Urgent', $true)
    }

    # Throttle check at the wrapper level too — Submit-BTNotification has the same check,
    # but this wrapper's own ShouldProcess runs first and would print WhatIf output before
    # Submit-BTNotification even gets called. By checking here, we bail out early and avoid
    # misleading WhatIf messages for throttled notifications.
    if ($CooldownSeconds -and $UniqueIdentifier) {
        $throttleDir = Join-Path $env:TEMP 'BurntToast-Throttle'
        if (-not [System.IO.Directory]::Exists($throttleDir)) {
            [System.IO.Directory]::CreateDirectory($throttleDir) | Out-Null
        }
        $throttleFile = Join-Path $throttleDir "$UniqueIdentifier.lock"
        if ([System.IO.File]::Exists($throttleFile)) {
            $lastFired = [System.IO.File]::GetLastWriteTime($throttleFile)
            if (([datetime]::Now - $lastFired).TotalSeconds -lt $CooldownSeconds) {
                return
            }
        }
        [System.IO.File]::WriteAllText($throttleFile, (Get-Date -Format o))
    }

    # Still forward CooldownSeconds for callers using Submit-BTNotification directly.
    if ($CooldownSeconds) {
        $ToastSplat.Add('CooldownSeconds', $CooldownSeconds)
    }

    if ($PSCmdlet.ShouldProcess( "submitting: $($Content.GetContent())" )) {
        Submit-BTNotification @ToastSplat
    }
}

function Submit-BTNotification {
    <#
        .SYNOPSIS
        Submits a completed toast notification for display.

        .DESCRIPTION
        The Submit-BTNotification function submits a completed toast notification to the operating system's notification manager for display.
        This function supports advanced scenarios such as event callbacks for user actions or toast dismissal, sequence numbering to ensure correct update order, unique identification for toast replacement, expiration control, and direct Action Center delivery.
        Supports colored action buttons: when a button generated via New-BTButton includes the -Color parameter
        ('Green' or 'Red'), the notification will style those buttons as "Success" (green) or "Critical" (red)
        to visually distinguish positive or destructive actions where supported.

        When an action ScriptBlock is supplied (Activated, Dismissed, or Failed), a normalized SHA256 hash of its content is used to generate a unique SourceIdentifier for event registration.
        This prevents duplicate handler registration for the same ScriptBlock, warning if a duplicate registration is attempted.

        If the -ReturnEventData switch is used and any event action scriptblocks are supplied (ActivatedAction, DismissedAction, FailedAction),
        the $Event automatic variable from the event will be assigned to $global:ToastEvent before invoking your script block.
        You can override the variable name used for event data by specifying -EventDataVariable. If supplied, the event data will be assigned to the chosen global variable in your event handler (e.g., -EventDataVariable 'CustomEvent' results in $global:CustomEvent).
        Specifying -EventDataVariable implicitly enables the behavior of -ReturnEventData.

        .PARAMETER Content
        A ToastContent object to display, such as returned by New-BTContent. The content defines the visual and data parts of the toast.

        .PARAMETER SequenceNumber
        A number that sequences this notification's version. When updating a toast, a higher sequence number ensures the most recent notification is displayed, and older ones are not resurrected if received out-of-order.

        .PARAMETER UniqueIdentifier
        A string that uniquely identifies the toast notification. Submitting a new toast with the same identifier as a previous toast replaces the previous notification. Useful for updating or overwriting the same toast notification (e.g., for progress).

        .PARAMETER DataBinding
        Hashtable mapping strings to binding keys in a toast notification. Enables advanced updating scenarios; the original toast must include the relevant databinding keys to be updateable.

        .PARAMETER ExpirationTime
        A [datetime] specifying when the notification is no longer relevant and should be removed from the Action Center.

        .PARAMETER SuppressPopup
        If set, the notification is delivered directly to the Action Center (bypasses immediate display as a popup/toast notification).

        .PARAMETER ActivatedAction
        A script block executed if the user activates/clicks the toast notification.

        .PARAMETER DismissedAction
        A script block executed if the user dismisses the toast notification.

        .PARAMETER FailedAction
        A script block executed if the notification fails to display properly.

        .PARAMETER ReturnEventData
        If set, the $Event variable from notification activation/dismissal is made available as $global:ToastEvent within event action script blocks.

        .PARAMETER EventDataVariable
        If specified, assigns the $Event variable from notification callbacks to this global variable name (e.g., -EventDataVariable MyVar gives $global:MyVar in handlers). Implies ReturnEventData.

        .PARAMETER Urgent
        If set, designates the toast as an "Important Notification" (scenario 'urgent') which can break through Focus Assist, ensuring the notification is delivered even when user focus mode is enabled.

        .PARAMETER CooldownSeconds
        Minimum number of seconds between repeated toasts that share the same UniqueIdentifier.
        If a toast with the same identifier was shown within this window, the new one is silently suppressed.
        Requires UniqueIdentifier to be set — without it, there is nothing to key the cooldown on.
        Throttle state is stored as lock files in %TEMP%\BurntToast-Throttle.

        .INPUTS
        None. You cannot pipe input to this function.

        .OUTPUTS
        None. This function submits a toast but returns no objects.

        .EXAMPLE
        Submit-BTNotification -Content $Toast1 -UniqueIdentifier 'Toast001'
        Submits the toast content object $Toast1 and tags it with a unique identifier so it can be replaced or updated.

        .LINK
        https://github.com/Windos/BurntToast/blob/main/Help/Submit-BTNotification.md
    #>

    [CmdletBinding(SupportsShouldProcess = $true,
                   HelpUri = 'https://github.com/Windos/BurntToast/blob/main/Help/Submit-BTNotification.md')]
    param (
        [Microsoft.Toolkit.Uwp.Notifications.ToastContent] $Content,
        [uint64] $SequenceNumber,
        [string] $UniqueIdentifier,
        [hashtable] $DataBinding,
        [datetime] $ExpirationTime,
        [switch] $SuppressPopup,
        [switch] $Urgent,
        [scriptblock] $ActivatedAction,
        [scriptblock] $DismissedAction,
        [scriptblock] $FailedAction,
        [switch] $ReturnEventData,
        [string] $EventDataVariable = 'ToastEvent',

        # Throttle: suppress duplicate toasts within N seconds.
        # Useful for hooks or automation that fire rapidly (e.g., CI agents, subprocesses).
        # Requires UniqueIdentifier so each notification type gets its own cooldown window.
        [int] $CooldownSeconds
    )

    # Throttle guard: CooldownSeconds without UniqueIdentifier has nothing to key on,
    # so we warn the user rather than silently ignoring it.
    if ($CooldownSeconds -gt 0 -and -not $UniqueIdentifier) {
        Write-Warning '-CooldownSeconds requires -UniqueIdentifier to track throttle state.'
    }

    # Throttle logic: uses a per-identifier lock file in %TEMP%\BurntToast-Throttle.
    # We compare the lock file's LastWriteTime against the cooldown window.
    # If the last toast was shown within the window, we bail out early — no toast, no noise.
    # Note: we use .NET I/O here instead of Set-Content/New-Item because those cmdlets
    # respect -WhatIf from the calling scope, but throttle state is internal bookkeeping
    # that must persist even during dry runs — otherwise the second call can't see the first.
    if ($CooldownSeconds -gt 0 -and $UniqueIdentifier) {
        $throttleDir = Join-Path $env:TEMP 'BurntToast-Throttle'
        if (-not [System.IO.Directory]::Exists($throttleDir)) {
            [System.IO.Directory]::CreateDirectory($throttleDir) | Out-Null
        }

        $throttleFile = Join-Path $throttleDir "$UniqueIdentifier.lock"

        if ([System.IO.File]::Exists($throttleFile)) {
            $lastFired = [System.IO.File]::GetLastWriteTime($throttleFile)
            if (([datetime]::Now - $lastFired).TotalSeconds -lt $CooldownSeconds) {
                # Still within cooldown — skip this notification entirely.
                return
            }
        }

        # Touch the lock file so subsequent calls know when this one fired.
        [System.IO.File]::WriteAllText($throttleFile, (Get-Date -Format o))
    }

    if (-not $IsWindows) {
        $null = [Windows.Data.Xml.Dom.XmlDocument, Windows.Data.Xml.Dom.XmlDocument, ContentType = WindowsRuntime]
    }

    $ToastXml = [Windows.Data.Xml.Dom.XmlDocument]::new()

    $ToastXmlContent = $Content.GetContent()

    if (-not $DataBinding) {
        $ToastXmlContent = $ToastXmlContent -replace '<text(.*?)>{', '<text$1>'
        $ToastXmlContent = $ToastXmlContent.Replace('}</text>', '</text>')
        $ToastXmlContent = $ToastXmlContent.Replace('="{', '="')
        $ToastXmlContent = $ToastXmlContent.Replace('}" ', '" ')
    }

    $ToastXml.LoadXml($ToastXmlContent)

    if ($Urgent) {
        try {$ToastXml.GetElementsByTagName('toast')[0].SetAttribute('scenario', 'urgent')} catch {}
    }

    if ($ToastXml.GetElementsByTagName('toast')[0].GetAttribute('scenario') -eq 'incomingCall') {
        foreach ($BindingElement in $ToastXml.GetElementsByTagName('binding')[0].ChildNodes) {
            if ($BindingElement.TagName -eq 'text') {
                $BindingElement.SetAttribute('hint-callScenarioCenterAlign', 'true')
            }
        }
    }

    if ($ToastXml.GetXml() -match 'hint-actionId="(Red|Green)"') {
        try {$ToastXml.GetElementsByTagName('toast').SetAttribute('useButtonStyle', 'true')} catch {}

        foreach ($ActionElement in $ToastXml.GetElementsByTagName('actions')[0].ChildNodes) {
            if ($ActionElement.GetAttribute('hint-actionId') -eq 'Red') {
                $ActionElement.SetAttribute('hint-buttonStyle', 'Critical')
            }
            if ($ActionElement.GetAttribute('hint-actionId') -eq 'Green') {
                $ActionElement.SetAttribute('hint-buttonStyle', 'Success')
            }
        }
    }

    $Toast = [Windows.UI.Notifications.ToastNotification]::new($ToastXml)

    if ($DataBinding) {
        $DataDictionary = New-Object 'system.collections.generic.dictionary[string,string]'

        if ($DataBinding) {
            foreach ($Key in $DataBinding.Keys) {
                $DataDictionary.Add($Key, $DataBinding.$Key)
            }
        }

        foreach ($Child in $Content.Visual.BindingGeneric.Children) {
            if ($Child.GetType().Name -eq 'AdaptiveText') {
                $BindingName = $Child.Text.BindingName

                if (!$DataDictionary.ContainsKey($BindingName)) {
                    $DataDictionary.Add($BindingName, $BindingName)
                }
            } elseif ($Child.GetType().Name -eq 'AdaptiveProgressBar') {
                if ($Child.Title) {
                    $BindingName = $Child.Title.BindingName

                    if (!$DataDictionary.ContainsKey($BindingName)) {
                        $DataDictionary.Add($BindingName, $BindingName)
                    }
                }

                if ($Child.Value) {
                    $BindingName = $Child.Value.BindingName

                    if (!$DataDictionary.ContainsKey($BindingName)) {
                        $DataDictionary.Add($BindingName, $BindingName)
                    }
                }

                if ($Child.ValueStringOverride) {
                    $BindingName = $Child.ValueStringOverride.BindingName

                    if (!$DataDictionary.ContainsKey($BindingName)) {
                        $DataDictionary.Add($BindingName, $BindingName)
                    }
                }

                if ($Child.Status) {
                    $BindingName = $Child.Status.BindingName

                    if (!$DataDictionary.ContainsKey($BindingName)) {
                        $DataDictionary.Add($BindingName, $BindingName)
                    }
                }
            }
        }

        $Toast.Data = [Windows.UI.Notifications.NotificationData]::new($DataDictionary)
    }

    if ($UniqueIdentifier) {
        $Toast.Group = $UniqueIdentifier
        $Toast.Tag = $UniqueIdentifier
    }

    if ($ExpirationTime) {
        $Toast.ExpirationTime = $ExpirationTime
    }

    if ($SuppressPopup.IsPresent) {
        $Toast.SuppressPopup = $SuppressPopup
    }

    if ($SequenceNumber) {
        $Toast.Data.SequenceNumber = $SequenceNumber
    }

    $CompatMgr = [Microsoft.Toolkit.Uwp.Notifications.ToastNotificationManagerCompat]

    if ($ActivatedAction -or $DismissedAction -or $FailedAction) {
        $Action_Activated = $ActivatedAction
        $Action_Dismissed = $DismissedAction
        $Action_Failed = $FailedAction

        if ($ReturnEventData -or $EventDataVariable -ne 'ToastEvent') {
            $EventReturn = '$global:{0} = $Event' -f $EventDataVariable
            if ($ActivatedAction) {
                $Action_Activated = [ScriptBlock]::Create($EventReturn + "`n" + $Action_Activated.ToString())
            }
            if ($DismissedAction) {
                $Action_Dismissed = [ScriptBlock]::Create($EventReturn + "`n" + $Action_Dismissed.ToString())
            }
            if ($FailedAction) {
                $Action_Failed = [ScriptBlock]::Create($EventReturn + "`n" + $Action_Failed.ToString())
            }
        }

        if ($Action_Activated) {
            try {
                $ActivatedHash = Get-BTScriptBlockHash $Action_Activated
                $activatedParams = @{
                    InputObject      = $CompatMgr
                    EventName        = 'OnActivated'
                    Action           = $Action_Activated
                    SourceIdentifier = "BT_Activated_$ActivatedHash"
                    ErrorAction      = 'Stop'
                }
                Register-ObjectEvent @activatedParams | Out-Null
            } catch {
                Write-Warning "Duplicate or conflicting OnActivated ScriptBlock event detected: Activation action not registered. $_"
            }
            <#
                EDGE CASES / NOTES
                - Hash collisions: In the rare event that two different ScriptBlocks normalize to the same text, they will share a SourceIdentifier and not both be registered.
                - Only ScriptBlocks are handled: if a non-ScriptBlock is supplied where an action is expected, registration will fail.
                - Actions with dynamic or closure content: If `ToString()` outputs identical strings for two blocks with different closure state, only one event will register.
                - User warnings: Any error during event registration (including duplicate) triggers a user-facing warning instead of otherwise disrupting notification flow.
            #>
        }
        if ($Action_Dismissed -or $Action_Failed) {
            if ($Script:ActionsSupported) {
                if ($Action_Dismissed) {
                    try {
                        $DismissedHash = Get-BTScriptBlockHash $Action_Dismissed
                        $dismissedParams = @{
                            InputObject      = $Toast
                            EventName        = 'Dismissed'
                            Action           = $Action_Dismissed
                            SourceIdentifier = "BT_Dismissed_$DismissedHash"
                            ErrorAction      = 'Stop'
                        }
                        Register-ObjectEvent @dismissedParams | Out-Null
                    } catch {
                        Write-Warning "Duplicate or conflicting Dismissed ScriptBlock event detected: Dismissed action not registered. $_"
                    }
                }
                if ($Action_Failed) {
                    try {
                        $FailedHash = Get-BTScriptBlockHash $Action_Failed
                        $failedParams = @{
                            InputObject      = $Toast
                            EventName        = 'Failed'
                            Action           = $Action_Failed
                            SourceIdentifier = "BT_Failed_$FailedHash"
                            ErrorAction      = 'Stop'
                        }
                        Register-ObjectEvent @failedParams | Out-Null
                    } catch {
                        Write-Warning "Duplicate or conflicting Failed ScriptBlock event detected: Failed action not registered. $_"
                    }
                }
            } else {
                Write-Warning $Script:UnsupportedEvents
            }
        }
    }

    if($PSCmdlet.ShouldProcess( "submitting: [$($Toast.GetType().Name)] with Id $UniqueIdentifier, Sequence Number $($Toast.Data.SequenceNumber) and XML: $($Content.GetContent())")) {
        $CompatMgr::CreateToastNotifier().Show($Toast)
    }
}

function Submit-BTNotification {
    <#
        .SYNOPSIS
        Submits a completed toast notification for display.

        .DESCRIPTION
        The Submit-BTNotification function submits a completed toast notification to the operating systems' notification manager for display.

        .INPUTS
        None

        .OUTPUTS
        None

        .EXAMPLE
        Submit-BTNotification -Content $Toast1 -UniqueIdentifier 'Toast001'

        This command submits the complete toast content object $Toast1, from the New-BTContent function, and tags it with a unique identifier so that it can be replaced/updated.

        .LINK
        https://github.com/Windos/BurntToast/blob/main/Help/Submit-BTNotification.md
    #>

    [CmdletBinding(SupportsShouldProcess = $true,
                   HelpUri = 'https://github.com/Windos/BurntToast/blob/main/Help/Submit-BTNotification.md')]
    param (
        # A Toast Content object which is the Base Toast element, created using the New-BTContent function.
        [Microsoft.Toolkit.Uwp.Notifications.ToastContent] $Content,

        # When updating toasts (not curently working) rapidly, the sequence number helps to ensure that toasts recieved out of order will not be displayed in a manner that may confuse.
        #
        # A higher sequence number indicates a newer toast.
        [uint64] $SequenceNumber,

        # A string that uniquely identifies a toast notification. Submitting a new toast with the same identifier as a previous toast will replace the previous toast.
        #
        # This is useful when updating the progress of a process, using a progress bar, or otherwise correcting/updating the information on a toast.
        [string] $UniqueIdentifier,

        # Specifies the AppId of the 'application' or process that spawned the toast notification.
        [string] $AppId = $Script:Config.AppId,

        # A hashtable that binds strings to keys in a toast notification. In order to update a toast, the original toast needs to include a databinding hashtable.
        [hashtable] $DataBinding,

        # The time after which the notification is no longer relevant and should be removed from the Action Center.
        [datetime] $ExpirationTime,

        # Bypasses display to the screen and sends the notification directly to the Action Center.
        [switch] $SuppressPopup,

        [scriptblock] $ActivatedAction,

        [scriptblock] $DismissedAction,

        [scriptblock] $FailedAction
    )

    if (!(Test-Path -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Notifications\Settings\$AppId")) {
        Write-Warning -Message "The AppId $AppId is not present in the registry, please run New-BTAppId to avoid inconsistent Toast behaviour."
    }

    if (-not $IsWindows) {
        $null = [Windows.Data.Xml.Dom.XmlDocument, Windows.Data.Xml.Dom.XmlDocument, ContentType = WindowsRuntime]
    }

    $ToastXml = [Windows.Data.Xml.Dom.XmlDocument]::new()

    if (-not $DataBinding) {
        $CleanContent = $Content.GetContent() -Replace '<text(.*?)>{', '<text$1>'
        $CleanContent = $CleanContent.Replace('}</text>', '</text>')
        $CleanContent = $CleanContent.Replace('="{', '="')
        $CleanContent = $CleanContent.Replace('}" ', '" ')

        $ToastXml.LoadXml($CleanContent)
    } else {
        $ToastXml.LoadXml($Content.GetContent())
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

    if ($ActivatedAction -or $DismissedAction -or $FailedAction) {
        if ($Script:ActionsSupported) {
            if ($ActivatedAction) {
                Register-ObjectEvent -InputObject $Toast -EventName Activated -Action $ActivatedAction |Out-Null
            }
            if ($DismissedAction) {
                Register-ObjectEvent -InputObject $Toast -EventName Dismissed -Action $DismissedAction | Out-Null
            }
            if ($FailedAction) {
                Register-ObjectEvent -InputObject $Toast -EventName Failed -Action $FailedAction | Out-Null
            }
        } else {
            Write-Warning $Script:UnsupportedEvents
        }
    }

    if($PSCmdlet.ShouldProcess( "submitting: [$($Toast.GetType().Name)] with AppId $AppId, Id $UniqueIdentifier, Sequence Number $($Toast.Data.SequenceNumber) and XML: $($Content.GetContent())")) {
        [Windows.UI.Notifications.ToastNotificationManager]::CreateToastNotifier($AppId).Show($Toast)
    }
}

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
        https://github.com/Windos/BurntToast/blob/master/Help/Submit-BTNotification.md
    #>

    [CmdletBinding(SupportsShouldProcess = $true)]
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
        [string] $AppId = $Script:Config.AppId
    )

    if (!(Test-Path -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Notifications\Settings\$AppId")) {
        Write-Warning -Message "The AppId $AppId is not present in the registry, please run New-BTAppId to avoid inconsistent Toast behaviour."
    }

    $null = [Windows.UI.Notifications.ToastNotificationManager, Windows.UI.Notifications, ContentType = WindowsRuntime]
    $null = [Windows.Data.Xml.Dom.XmlDocument, Windows.Data.Xml.Dom.XmlDocument, ContentType = WindowsRuntime]

    $ToastXml = [Windows.Data.Xml.Dom.XmlDocument]::new()

    $CleanContent = $Content.GetContent().Replace('<text>{', '<text>')
    $CleanContent = $CleanContent.Replace('}</text>', '</text>')
    $CleanContent = $CleanContent.Replace('="{', '="')
    $CleanContent = $CleanContent.Replace('}" ', '" ')

    $ToastXml.LoadXml($CleanContent)
    $Toast = [Windows.UI.Notifications.ToastNotification]::new($ToastXml)

    if ($SequenceNumber) {
        $Toast.Data = [Windows.UI.Notifications.NotificationData]::new()
        $Toast.Data.SequenceNumber = $SequenceNumber
    }

    if ($UniqueIdentifier) {
        $Toast.Group = $UniqueIdentifier
        $Toast.Tag = $UniqueIdentifier
    }

    if($PSCmdlet.ShouldProcess( "submitting: [$($Toast.GetType().Name)] with AppId $AppId, Id $UniqueIdentifier, Sequence Number $($Toast.Data.SequenceNumber) and XML: $CleanContent")) {
        [Windows.UI.Notifications.ToastNotificationManager]::CreateToastNotifier($AppId).Show($Toast)
    }
}

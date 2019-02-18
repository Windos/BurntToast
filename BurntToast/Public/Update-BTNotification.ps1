function Update-BTNotification {
    <#
        .SYNOPSIS
        Updates a toast notification for display.

        .DESCRIPTION
        The Update-BTNotification function updates a toast notification in the operating systems' notification manager.

        .INPUTS
        TODO

        .OUTPUTS
        TODO

        .EXAMPLE
        TODO

        .LINK
        https://github.com/Windos/BurntToast/blob/master/Help/Update-BTNotification.md
    #>

    [CmdletBinding(SupportsShouldProcess = $true)]
    param (
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

        [hashtable] $DataBinding
    )

    if (!(Test-Path -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Notifications\Settings\$AppId")) {
        Write-Warning -Message "The AppId $AppId is not present in the registry, please run New-BTAppId to avoid inconsistent Toast behaviour."
    }

    $null = [Windows.UI.Notifications.ToastNotificationManager, Windows.UI.Notifications, ContentType = WindowsRuntime]
    $null = [Windows.Data.Xml.Dom.XmlDocument, Windows.Data.Xml.Dom.XmlDocument, ContentType = WindowsRuntime]

    if ($DataBinding) {
        $DataDictionary = New-Object 'system.collections.generic.dictionary[string,string]'

        foreach ($Key in $DataBinding.Keys) {
            $DataDictionary.Add($Key, $DataBinding.$Key)
        }
    }

    $ToastData = [Windows.UI.Notifications.NotificationData]::new($DataDictionary)

    if ($SequenceNumber) {
        $ToastData.SequenceNumber = $SequenceNumber
    }

    # if($PSCmdlet.ShouldProcess( "submitting: [$($Toast.GetType().Name)] with AppId $AppId, Id $UniqueIdentifier, Sequence Number $($Toast.Data.SequenceNumber) and XML: $CleanContent")) {
    [Windows.UI.Notifications.ToastNotificationManager]::CreateToastNotifier($AppId).Update($ToastData, $UniqueIdentifier, $UniqueIdentifier)
    # }
}

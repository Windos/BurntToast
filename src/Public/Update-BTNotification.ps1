function Update-BTNotification {
    <#
        .SYNOPSIS
        Updates an existing toast notification.

        .DESCRIPTION
        The Update-BTNotification function updates a toast notification by matching UniqueIdentifier and replacing or updating its contents/data.
        DataBinding provides the values to update in the notification, and SequenceNumber ensures correct ordering if updates overlap.

        .PARAMETER SequenceNumber
        Used for notification versioning; higher numbers indicate newer content to prevent out-of-order display.

        .PARAMETER UniqueIdentifier
        String uniquely identifying the toast notification to update.

        .PARAMETER DataBinding
        Hashtable containing the data binding keys/values to update.

        .INPUTS
        None. You cannot pipe input to this function.

        .OUTPUTS
        None.

        .EXAMPLE
        $data = @{ Key = 'Value' }
        Update-BTNotification -UniqueIdentifier 'ID001' -DataBinding $data
        Updates notification with key 'ID001' using new data binding values.

        .LINK
        https://github.com/Windos/BurntToast/blob/main/Help/Update-BTNotification.md
    #>

    [CmdletBinding(SupportsShouldProcess = $true,
                   HelpUri = 'https://github.com/Windos/BurntToast/blob/main/Help/Update-BTNotification.md')]
    [CmdletBinding()]
    param (
        [uint64] $SequenceNumber,
        [string] $UniqueIdentifier,
        [hashtable] $DataBinding
    )

    if (-not $IsWindows) {
        $null = [Windows.Data.Xml.Dom.XmlDocument, Windows.Data.Xml.Dom.XmlDocument, ContentType = WindowsRuntime]
    }

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

    if($PSCmdlet.ShouldProcess("UniqueId: $UniqueIdentifier", 'Updating notification')) {
        [Microsoft.Toolkit.Uwp.Notifications.ToastNotificationManagerCompat]::CreateToastNotifier().Update($ToastData, $UniqueIdentifier, $UniqueIdentifier)
    }
}

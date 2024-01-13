function Update-BTNotification {
    <#
        .SYNOPSIS
        Updates a toast notification for display.

        .DESCRIPTION
        The Update-BTNotification function updates a toast notification in the operating systems' notification manager.

        .INPUTS
        LOTS...

        .OUTPUTS
        NONE

        .EXAMPLE
        $FirstDataBinding = @{
            FirstLine = 'Example Toast Heading'
            SecondLine = 'This toast is still the original'
        }

        New-BurntToastNotification -Text 'FirstLine', 'SecondLine' -UniqueIdentifier 'ExampleToast' -DataBinding $FirstDataBinding

        $SecondDataBinding = @{
            SecondLine = 'This toast has been updated!'
        }

        Update-BTNotification -UniqueIdentifier 'ExampleToast' -DataBinding $SecondDataBinding

        .LINK
        https://github.com/Windos/BurntToast/blob/main/Help/Update-BTNotification.md
    #>

    [CmdletBinding(SupportsShouldProcess = $true,
                   HelpUri = 'https://github.com/Windos/BurntToast/blob/main/Help/Update-BTNotification.md')]
    [CmdletBinding()]
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

        # A hashtable that binds strings to keys in a toast notification. In order to update a toast, the original toast needs to include a databinding hashtable.
        [hashtable] $DataBinding
    )

    if (!(Test-Path -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Notifications\Settings\$AppId")) {
        Write-Warning -Message "The AppId $AppId is not present in the registry, please run New-BTAppId to avoid inconsistent Toast behaviour."
    }

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

    if($PSCmdlet.ShouldProcess("AppId: $AppId, UniqueId: $UniqueIdentifier", 'Updating notification')) {
        [Windows.UI.Notifications.ToastNotificationManager]::CreateToastNotifier($AppId).Update($ToastData, $UniqueIdentifier, $UniqueIdentifier)
    }
}

function Submit-BTNotification
{
    <#
        .SYNOPSIS

        .DESCRIPTION

        .INPUTS
        None

        .OUTPUTS
        None

        .EXAMPLE

        .EXAMPLE

        .EXAMPLE

        .LINK
        https://github.com/Windos/BurntToast
    #>

    [CmdletBinding()]
    param
    (
        [Parameter()]
        [Microsoft.Toolkit.Uwp.Notifications.ToastContent] $Content,

        [Parameter()]
        [uint64] $SequenceNumber,

        [Parameter()]
        [string] $UniqueIdentifier,

        [Parameter()]
        [string] $AppId = $Script:Config.AppId
    )

    if (!(Test-Path -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Notifications\Settings\$AppId"))
    {
        Write-Warning -Message "The AppId $AppId is not present in the registry, please run New-BTAppId to avoid inconsistent Toast behaviour."
    }

    $null = [Windows.UI.Notifications.ToastNotificationManager, Windows.UI.Notifications, ContentType = WindowsRuntime]
    $null = [Windows.Data.Xml.Dom.XmlDocument, Windows.Data.Xml.Dom.XmlDocument, ContentType = WindowsRuntime]

    $ToastXml = [Windows.Data.Xml.Dom.XmlDocument]::new()

    $CleanContent = $Content.GetContent().Replace('<text>{','<text>')
    $CleanContent = $CleanContent.Replace('}</text>','</text>')
    $CleanContent = $CleanContent.Replace('="{','="')
    $CleanContent = $CleanContent.Replace('}" ','" ')

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

    [Windows.UI.Notifications.ToastNotificationManager]::CreateToastNotifier($AppId).Show($Toast)
}

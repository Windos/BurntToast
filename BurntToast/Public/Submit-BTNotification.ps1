using namespace Microsoft.Toolkit.Uwp.Notifications

function Submit-BTNotification
{
    <#
        .SYNOPSIS
        Creates a new Image Element for Toast Notifications.

        .DESCRIPTION
        The New-BTImageElement cmdlet creates a new Image Element for Toast Notifications.
    
        You can use the parameters of New-BTImageElement to specify the source image, alt text, placement on the Toast Notification and crop shape.

        .INPUTS
        None

        .OUTPUTS
        Image
        
        .EXAMPLE

        .EXAMPLE

        .EXAMPLE

        .LINK
        https://github.com/Windos/BurntToast
    #>

    [CmdletBinding()]
    [OutputType($null)]
    param
    (
        [Parameter()]
        [ToastContent] $Content,

        [Parameter()]
        [string] $AppId = 'BurntToast'
    )

    #TODO: Add checking for valid AppId in registry

    $ToastXml = [Windows.Data.Xml.Dom.XmlDocument]::new()
    $ToastXml.LoadXml($Content.GetContent())
    $Toast = [Windows.UI.Notifications.ToastNotification]::new($ToastXml)
    [Windows.UI.Notifications.ToastNotificationManager]::CreateToastNotifier($AppId).Show($Toast)
}

function Show-BTNotification {
    <#
        .SYNOPSIS
        Shows a new toast notification.

        .DESCRIPTION
        The Show-BTNotification function shows a new toast notification with its configured content.

        .INPUTS
        Microsoft.Toolkit.Uwp.Notifications.ToastContentBuilder. You can pipe a toast content builder object to Show-BTNotification.

        .OUTPUTS
        None

        .EXAMPLE
        PS C:\>Show-BTNotification -ContentBuilder $ToastContentBuilder

        This command displays a toast notification with the content of the ToastContentBuilder object.

        .EXAMPLE
        PS C:\>$ToastContentBuilder | Show-BTNotification

        This command displays a toast notification with the content of the ToastContentBuilder object supplied via the pipeline.

        .EXAMPLE
        PS C:\>$Builder = New-BTContentBuilder

        PS C:\>$Builder | Add-BTText -Text 'First Line of Text', 'Second Line of Text'

        PS C:\>Show-BTNotification -ContentBuilder $Builder

        This example demonstrates the full life cycle of a ToastContentBuilder object from creation to display.

        .LINK
        https://docs.toastit.dev/commands/show-btnotification
    #>

    [CmdletBinding(SupportsShouldProcess = $true)]
    param (
        [Parameter(Mandatory,
                   Position = 0,
                   ValueFromPipeline = $true)]
        [Microsoft.Toolkit.Uwp.Notifications.ToastContentBuilder[]] $ContentBuilder
    )

    begin {}
    process {
        foreach ($Builder in $ContentBuilder) {
            if($PSCmdlet.ShouldProcess( "submitting: $($Builder.GetToastContent().GetContent())")) {
                $Toast = [Windows.UI.Notifications.ToastNotification]::new($Builder.GetXml())

                $Builder.Show([Microsoft.Toolkit.Uwp.Notifications.CustomizeToast] {
                    $Toast.Group = $Builder.Group
                    $Toast.Tag = $Builder.Tag}
                )
            }
        }
    }
    end {}
}
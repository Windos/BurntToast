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
        PS C:\>

        .EXAMPLE
        PS C:\>

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
                $Builder.Show()
            }
        }
    }
    end {}
}
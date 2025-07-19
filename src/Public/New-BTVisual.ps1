function New-BTVisual {
    <#
        .SYNOPSIS
        Creates a new visual element for toast notifications.

        .DESCRIPTION
        The New-BTVisual function creates a ToastVisual object, defining the visual appearance and layout for a Toast Notification. This includes the root Toast binding, optional alternate bindings, image query, base URI, and locale settings.

        .PARAMETER BindingGeneric
        Mandatory. ToastBindingGeneric object describing the main layout and visuals (text, images, progress bars, columns).

        .PARAMETER BindingShoulderTap
        Optional alternate Toast binding that can be rendered on devices supporting ShoulderTap notifications.

        .PARAMETER AddImageQuery
        Switch. Allows image URIs to include scale and language info added by Windows.

        .PARAMETER BaseUri
        URI to prepend to all relative image uris in the toast.

        .PARAMETER Language
        BCP-47 tag specifying what language/locale to use for display.

        .INPUTS
        None. You cannot pipe input to this function.

        .OUTPUTS
        Microsoft.Toolkit.Uwp.Notifications.ToastVisual

        .EXAMPLE
        New-BTVisual -BindingGeneric $Binding1
        Creates a Toast Visual containing the provided binding.

        .LINK
        https://github.com/Windos/BurntToast/blob/main/Help/New-BTVisual.md
    #>

    [CmdletBinding(SupportsShouldProcess = $true,
                   HelpUri = 'https://github.com/Windos/BurntToast/blob/main/Help/New-BTVisual.md')]
    [OutputType([Microsoft.Toolkit.Uwp.Notifications.ToastVisual])]
    param (
        [Parameter(Mandatory)]
        [Microsoft.Toolkit.Uwp.Notifications.ToastBindingGeneric] $BindingGeneric,

        [Microsoft.Toolkit.Uwp.Notifications.ToastBindingShoulderTap] $BindingShoulderTap,

        [switch] $AddImageQuery,

        [uri] $BaseUri,

        [string] $Language
    )

    $Visual = [Microsoft.Toolkit.Uwp.Notifications.ToastVisual]::new()
    $Visual.BindingGeneric = $BindingGeneric

    $Visual.BindingShoulderTap = $BindingShoulderTap

    if ($AddImageQuery) {
        $Visual.AddImageQuery = $AddImageQuery
    }

    if ($BaseUri) {
        $Visual.BaseUri = $BaseUri
    }

    if ($Language) {
        $Visual.Language = $Language
    }

    if($PSCmdlet.ShouldProcess("returning: [$($Visual.GetType().Name)]:BindingGeneric=$($Visual.BindingGeneric.Children.Count):BaseUri=$($Visual.BaseUri):Language=$($Visual.Language)")) {
        $Visual
    }
}

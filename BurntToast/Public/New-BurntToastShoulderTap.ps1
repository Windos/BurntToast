function New-BurntToastShoulderTap {
    <#
        .SYNOPSIS
        TODO

        .DESCRIPTION
        TODO

        .INPUTS
        TODO

        .OUTPUTS
        TODO

        .EXAMPLE
        TODO

        .LINK
        https://github.com/Windos/BurntToast/blob/master/Help/New-BurntToastShoulderTap.md
    #>

    [alias('ShoulderTap')]
    [CmdletBinding(SupportsShouldProcess   = $true)]
    param (
        [Parameter(Mandatory)]
        [string] $Image,

        [Parameter(Mandatory)]
        [string] $Person,

        # Specifies the text to show on the Toast Notification. Up to three strings can be displayed, the first of which will be embolden as a title.
        [ValidateCount(0, 3)]
        [string[]] $Text = 'Default Notification',

        #TODO: [ValidateScript({ Test-ToastImage -Path $_ })]

        # Specifies the path to an image that will override the default image displayed with a Toast Notification.
        [string] $AppLogo,

        # Allows up to five buttons to be added to the bottom of the Toast Notification. These buttons should be created using the New-BTButton function.
        [Microsoft.Toolkit.Uwp.Notifications.IToastButton[]] $Button,

        # Specify the Toast Header object created using the New-BTHeader function, for seperation/categorization of toasts from the same AppId.
        [Microsoft.Toolkit.Uwp.Notifications.ToastHeader] $Header,

        # Specify one or more Progress Bar object created using the New-BTProgressBar function.
        [Microsoft.Toolkit.Uwp.Notifications.AdaptiveProgressBar[]] $ProgressBar,

        # A string that uniquely identifies a toast notification. Submitting a new toast with the same identifier as a previous toast will replace the previous toast.
        #
        # This is useful when updating the progress of a process, using a progress bar, or otherwise correcting/updating the information on a toast.
        [string] $UniqueIdentifier,

        [datetime] $ExpirationTime,

        [switch] $SuppressPopup,

        [datetime] $CustomTimestamp,

        [string] $AppId
    )

    $ChildObjects = @()

    foreach ($Txt in $Text) {
        $ChildObjects += New-BTText -Text $Txt -WhatIf:$false
    }

    if ($ProgressBar) {
        foreach ($Bar in $ProgressBar) {
            $ChildObjects += $Bar
        }
    }

    if ($AppLogo) {
        $AppLogoImage = New-BTImage -Source $AppLogo -AppLogoOverride -Crop Circle -WhatIf:$false
    } else {
        $AppLogoImage = New-BTImage -AppLogoOverride -Crop Circle -WhatIf:$false
    }

    $Binding = New-BTBinding -Children $ChildObjects -AppLogoOverride $AppLogoImage -WhatIf:$false

    $ShoulderTapBinding = New-BTShoulderTapBinding -Image (New-BTShoulderTapImage -Source $Image)

    $Visual = New-BTVisual -BindingGeneric $Binding -BindingShoulderTap $ShoulderTapBinding -WhatIf:$false

    $ContentSplat = @{
        'Visual' = $Visual
        'ToastPeople' = (New-BTShoulderTapPeople -Email $Person)
    }

    if ($Header) {
        $ContentSplat.Add('Header', $Header)
    }

    if ($CustomTimestamp) {
        $ContentSplat.Add('CustomTimestamp', $CustomTimestamp)
    }

    $Content = New-BTContent @ContentSplat -WhatIf:$false

    $ToastSplat = @{
        Content = $Content
        AppId = $Script:Config.AppId
    }

    if ($UniqueIdentifier) {
        $ToastSplat.Add('UniqueIdentifier', $UniqueIdentifier)
    }

    if ($ExpirationTime) {
        $ToastSplat.Add('ExpirationTime', $ExpirationTime)
    }

    if ($SuppressPopup.IsPresent) {
        $ToastSplat.Add('SuppressPopup', $true)
    }

    if ($AppId) {
        $ToastSplat.Add('AppId', $AppId)
    } else {
        $ToastSplat.Add('AppId', 'Microsoft.People_8wekyb3d8bbwe!x4c7a3b7dy2188y46d4ya362y19ac5a5805e5x')
    }

    if($PSCmdlet.ShouldProcess( "submitting: $($Content.GetContent())" )) {
        Submit-BTNotification @ToastSplat
    }
}

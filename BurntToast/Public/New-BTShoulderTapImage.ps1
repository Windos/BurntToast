function New-BTShoulderTapImage {
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
        https://github.com/Windos/BurntToast/blob/master/Help/New-BTShoulderTapImage.md
    #>

    [CmdletBinding(DefaultParameterSetName = 'Image')]
    [OutputType([Microsoft.Toolkit.Uwp.Notifications.ToastShoulderTapImage])]

    param (
        [Parameter(ParameterSetName = 'Image',
                   Mandatory)]
        [string] $Source,

        [Parameter(ParameterSetName = 'Sprite',
                   Mandatory)]
        [string] $SpriteSheet,

        [Parameter(ParameterSetName = 'Sprite',
                   Mandatory)]
        [uint32] $FrameHeight,

        [Parameter(ParameterSetName = 'Sprite',
                   Mandatory)]
        [uint32] $FPS,

        [Parameter(ParameterSetName = 'Sprite')]
        [uint32] $StartingFrame,

        [string] $AlternateText,

        [switch] $AddImageQuery
    )

    $ShoulderTapImage = [Microsoft.Toolkit.Uwp.Notifications.ToastShoulderTapImage]::new()

    if ($PSCmdlet.ParameterSetName -eq 'Sprite') {
        $Sprite = [Microsoft.Toolkit.Uwp.Notifications.ToastSpriteSheet]::new()

        $Sprite.Source = Optimize-BTImageSource -Source $SpriteSheet
        $Sprite.FrameHeight = $FrameHeight
        $Sprite.Fps = $FPS

        if ($StartingFrame) {
            $Sprite.StartingFrame = $StartingFrame
        }

        $ShoulderTapImage.SpriteSheet = $Sprite
    } else {
        $ShoulderTapImage.Source = Optimize-BTImageSource -Source $Source
    }

    if ($AddImageQuery.IsPresent) {
        $ShoulderTapImage.AddImageQuery = $true
    }

    if ($AlternateText) {
        $ShoulderTapImage.AlternateText = $AlternateText
    }

    $ShoulderTapImage
}

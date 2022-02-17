function New-BTShoulderTapImage {
    <#
        .SYNOPSIS
        Creates a new ToastShoulderTapImage object.

        .DESCRIPTION
        The New-BTShoulderTapImage function creates a new ToastShoulderTapImage object.

        The image can be a static image or anitmated gif, specified using the Source parameter. It can also be a spritesheet.

        This function is mainly used internally, as it is abstracted away when using New-BurntToastShoulderTap.

        .INPUTS
        LOTS

        .OUTPUTS
        ToastShoulderTapImage

        .EXAMPLE
        $Image = New-BTShoulderTapImage -Source 'https://www.route66sodas.com/wp-content/uploads/2019/01/Alert.gif'

        .LINK
        https://github.com/Windos/BurntToast/blob/main/Help/New-BTShoulderTapImage.md
    #>

    [Obsolete('This cmdlet is being deprecated, it will be removed in v0.9.0')]
    [CmdletBinding(DefaultParameterSetName = 'Image',
                   HelpUri = 'https://github.com/Windos/BurntToast/blob/main/Help/New-BTShoulderTapImage.md')]
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

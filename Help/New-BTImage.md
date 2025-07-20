# New-BTImage

## SYNOPSIS

Creates a new Image Element for Toast Notifications.

## DESCRIPTION

The `New-BTImage` function creates an image element for Toast Notifications, which can be a standard, app logo, or hero image.
You can specify the image source, cropping, alt text, alignment, and additional display properties.

## PARAMETERS

| Name             | Type                                                    | Description                                                                                 |
|------------------|---------------------------------------------------------|---------------------------------------------------------------------------------------------|
| `Source`         | String                                                  | URI or file path of the image. Can be from your app, local filesystem, or the internet (must be <200KB for remote). |
| `AlternateText`  | String                                                  | Description of the image for assistive technology.                                          |
| `AppLogoOverride`| Switch                                                  | Marks this image as the logo, to be shown as the app logo on the toast.                     |
| `HeroImage`      | Switch                                                  | Marks this image as the hero image, to be prominently displayed.                            |
| `Align`          | Microsoft.Toolkit.Uwp.Notifications.AdaptiveImageAlign  | Horizontal alignment (only supported within groups).                                        |
| `Crop`           | Microsoft.Toolkit.Uwp.Notifications.AdaptiveImageCrop   | Specifies cropping of the image (e.g., Circle for logos).                                   |
| `RemoveMargin`   | Switch                                                  | Removes default 8px margin around the image.                                                |
| `AddImageQuery`  | Switch                                                  | Allows Windows to append scaling/language query string to the URI.                          |
| `IgnoreCache`    | Switch                                                  | Forces image to be refreshed (when used with `Optimize-BTImageSource`).                     |

## INPUTS

None. You cannot pipe input to this function.

## OUTPUTS

- Microsoft.Toolkit.Uwp.Notifications.AdaptiveImage
- Microsoft.Toolkit.Uwp.Notifications.ToastGenericAppLogo
- Microsoft.Toolkit.Uwp.Notifications.ToastGenericHeroImage

## EXAMPLES

### Example 1

```powershell
$image1 = New-BTImage -Source 'C:\Media\BurntToast.png'
```

Standard image for a toast body.

### Example 2

```powershell
$image2 = New-BTImage -Source 'C:\Media\BurntToast.png' -AppLogoOverride -Crop Circle
```

Cropped circular logo for use on the toast.

### Example 3

```powershell
$image3 = New-BTImage -Source 'C:\Media\BurntToast.png' -HeroImage
```

Hero image for the toast header.

## LINKS

- [New-BTContent](New-BTContent.md)
- [Optimize-BTImageSource](#)
- [New-BTBinding](New-BTBinding.md)
- [New-BTColumn](New-BTColumn.md)

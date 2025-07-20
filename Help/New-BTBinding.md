# New-BTBinding

## SYNOPSIS

Creates a new Generic Toast Binding object.

## DESCRIPTION

The `New-BTBinding` function creates a new Generic Toast Binding, in which you provide text, images, columns, progress bars, and more, controlling the visual appearance of the notification.

## PARAMETERS

| Name            | Type                                                                   | Description                                                                                                       | Mandatory |
|-----------------|------------------------------------------------------------------------|-------------------------------------------------------------------------------------------------------------------|-----------|
| `Children`      | Microsoft.Toolkit.Uwp.Notifications.IToastBindingGenericChild[]        | Array of binding children elements to include, such as Text, Image, Group, or Progress Bar objects, created by other BurntToast functions (`New-BTText`, `New-BTImage`, `New-BTProgressBar`, etc.). | No        |
| `Column`        | Microsoft.Toolkit.Uwp.Notifications.AdaptiveSubgroup[]                 | Array of AdaptiveSubgroup elements (columns), created via `New-BTColumn`, to display content side by side.         | No        |
| `AddImageQuery` | Switch                                                                 | Allows Windows to append a query string to image URIs for scale/language support; only needed for remote images.   | No        |
| `AppLogoOverride` | Microsoft.Toolkit.Uwp.Notifications.ToastGenericAppLogo              | Optional override for the logo displayed, created with `New-BTImage` using the `AppLogoOverride` switch.           | No        |
| `Attribution`   | Microsoft.Toolkit.Uwp.Notifications.ToastGenericAttributionText        | Optional attribution text. Only supported on modern Windows versions.                                              | No        |
| `BaseUri`       | Uri                                                                    | A URI that is combined with relative image URIs for images in the notification.                                    | No        |
| `HeroImage`     | Microsoft.Toolkit.Uwp.Notifications.ToastGenericHeroImage              | Optional hero image object, created with `New-BTImage` using the `HeroImage` switch.                               | No        |
| `Language`      | String                                                                 | Specifies the locale (e.g. "en-US" or "fr-FR") for the binding and contained text.                                 | No        |

## INPUTS

None. You cannot pipe input to this function.

## OUTPUTS

Microsoft.Toolkit.Uwp.Notifications.ToastBindingGeneric

## EXAMPLES

### Example 1

```powershell
$text1 = New-BTText -Content 'This is a test'
$image1 = New-BTImage -Source 'C:\BurntToast\Media\BurntToast.png'
$binding = New-BTBinding -Children $text1, $image1
```

Combines text and image into a binding for use in a visual toast.

### Example 2

```powershell
$progress = New-BTProgressBar -Title 'Updating' -Status 'Running' -Value 0.4
$binding = New-BTBinding -Children $progress
```

Includes a progress bar element in the binding.

### Example 3

```powershell
$col1 = New-BTColumn -Children (New-BTText -Text 'a')
$col2 = New-BTColumn -Children (New-BTText -Text 'b')
$binding = New-BTBinding -Column $col1, $col2
```

Uses two columns to display content side by side.

## LINKS

- [New-BTText](New-BTText.md)
- [New-BTImage](New-BTImage.md)
- [New-BTColumn](New-BTColumn.md)
- [New-BTProgressBar](New-BTProgressBar.md)

# New-BTImage

## SYNOPSIS

Creates a new Image Element for Toast Notifications.

## SYNTAX

### Image (Default)

```powershell
New-BTImage [-Source <String>] [-AlternateText <String>] [-Align <AdaptiveImageAlign>]
 [-Crop <AdaptiveImageCrop>] [-RemoveMargin] [-AddImageQuery]
```

### AppLogo

```powershell
New-BTImage [-Source <String>] [-AlternateText <String>] [-AppLogoOverride] [-Crop <AdaptiveImageCrop>]
 [-AddImageQuery]
```

### Hero

```powershell
New-BTImage [-Source <String>] [-AlternateText <String>] [-HeroImage] [-AddImageQuery]
```

## DESCRIPTION

The New-BTImageElement function creates a new Image Element for Toast Notifications.

You can use the parameters of New-BTImageElement to specify the source image, alt text, placement on the Toast Notification and crop shape.

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------

```powershell
PS C:\>$image1 = New-BTImage -Source 'C:\Media\BurntToast.png'
```

This command creates a standard image object to be included in the main body of a toast.

### -------------------------- EXAMPLE 2 --------------------------

```powershell
PS C:\>$image2 = New-BTImage -Source 'C:\Media\BurntToast.png' -AppLogoOverride -Crop Circle
```

This command creates an image object to be used as the logo on a toast, cropped into the shape fo a circle.

### -------------------------- EXAMPLE 3 --------------------------

```powershell
PS C:\>$image3 = New-BTImage -Source 'C:\Media\BurntToast.png' -HeroImage
```

This command creates an inmage to be used as a toast's hero image.

## PARAMETERS

### -AddImageQuery

Set to true to allow Windows to append a query string to the image URI supplied in the Tile notification. Use this attribute if your server hosts images and can handle query strings, either by retrieving an image variant based on the query strings or by ignoring the query string and returning the image as specified without the query string. This query string specifies scale, contrast setting, and language.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Align

The horizontal alignment of the image. For Toast, this is only supported when inside a group (not yet implemented.)

```yaml
Type: AdaptiveImageAlign
Parameter Sets: Image
Aliases:
Accepted values: Default, Stretch, Left, Center, Right

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -AlternateText

A description of the image, for users of assistive technologies.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -AppLogoOverride

Specifies that the image is to be used as the logo on the toast.

```yaml
Type: SwitchParameter
Parameter Sets: AppLogo
Aliases:

Required: True
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Crop

Control the desired cropping of the image. Supported on Toast since Anniversary Update.

```yaml
Type: AdaptiveImageCrop
Parameter Sets: Image, AppLogo
Aliases:
Accepted values: Default, None, Circle

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -HeroImage

Specifies that the image is to be used as the hero image on the toast.

```yaml
Type: SwitchParameter
Parameter Sets: Hero
Aliases:

Required: True
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -RemoveMargin

By default, images have an 8px margin around them. You can remove this margin by including this switch. Supported on Toast since Anniversary Update.

```yaml
Type: SwitchParameter
Parameter Sets: Image
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Source

The URI of the image. Can be from your application package, application data, or the internet. Internet images must be less than 200 KB in size.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: $Script:DefaultImage
Accept pipeline input: False
Accept wildcard characters: False
```

## INPUTS

TODO

## OUTPUTS

AdaptiveImage

ToastGenericAppLogo

ToastGenericHeroImage

## NOTES
Credit for most of the help text for this function go to the authors of the UWPCommunityToolkit library that this module relies upon.

Please see the [originating repo](https://github.com/Microsoft/UWPCommunityToolkit).

## RELATED LINKS

[New-BTImage](https://github.com/Windos/BurntToast/blob/master/Help/New-BTImage.md)

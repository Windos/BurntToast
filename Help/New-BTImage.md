---
external help file: BurntToast-help.xml
online version: https://github.com/Windos/BurntToast
schema: 2.0.0
---

# New-BTImage

## SYNOPSIS
Creates a new Image Element for Toast Notifications.

## SYNTAX

### Image (Default)
```
New-BTImage [-Source <String>] [-AlternateText <String>] [-Align <AdaptiveImageAlign>]
 [-Crop <AdaptiveImageCrop>] [-RemoveMargin] [-AddImageQuery]
```

### AppLogo
```
New-BTImage [-Source <String>] [-AlternateText <String>] [-AppLogoOverride] [-Crop <AdaptiveImageCrop>]
 [-AddImageQuery]
```

### Hero
```
New-BTImage [-Source <String>] [-AlternateText <String>] [-HeroImage] [-AddImageQuery]
```

## DESCRIPTION
The New-BTImageElement cmdlet creates a new Image Element for Toast Notifications.

You can use the parameters of New-BTImageElement to specify the source image, alt text, placement on the Toast Notification and crop shape.

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```

```

### -------------------------- EXAMPLE 2 --------------------------
```

```

### -------------------------- EXAMPLE 3 --------------------------
```

```

## PARAMETERS

### -AddImageQuery
{{Fill AddImageQuery Description}}

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
{{Fill Align Description}}

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
{{Fill AlternateText Description}}

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
{{Fill AppLogoOverride Description}}

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
{{Fill Crop Description}}

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
{{Fill HeroImage Description}}

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
{{Fill RemoveMargin Description}}

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
{{Fill Source Description}}

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

### None

## OUTPUTS

### Image

## NOTES

## RELATED LINKS

[https://github.com/Windos/BurntToast](https://github.com/Windos/BurntToast)


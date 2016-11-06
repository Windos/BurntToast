---
external help file: BurntToast-help.xml
online version: https://github.com/Windos/BurntToast
schema: 2.0.0
---

# New-BTText

## SYNOPSIS
Creates a new Text Element for Toast Notifications.

## SYNTAX

```
New-BTText [[-Text] <String>] [[-MaxLines] <Int32>] [[-MinLines] <Int32>] [-Wrap]
 [[-Align] <AdaptiveTextAlign>] [[-Style] <AdaptiveTextStyle>] [[-Language] <String>]
```

## DESCRIPTION
The New-BTTextElement cmdlet creates a new Text Element for Toast Notifications.

You can specify the text you want displayed in a Toast Notification as a string, or run the cmdlet without a paramter for a blank line.

Each Text Element is the equivalent of one line in on a Toast Notification, long lines will wrap.

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
New-BTTextElement -Content 'This is a line with text!'
```

Creates a Text Element that will show the string 'This is a line with text!' on a Toast Notification.

### -------------------------- EXAMPLE 2 --------------------------
```
New-BTTextElement
```

Creates a Text Element that will show a blank line on a Toast Notification.

## PARAMETERS

### -Align
{{Fill Align Description}}

```yaml
Type: AdaptiveTextAlign
Parameter Sets: (All)
Aliases: 
Accepted values: Default, Auto, Left, Center, Right

Required: False
Position: 4
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Language
{{Fill Language Description}}

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: False
Position: 6
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -MaxLines
{{Fill MaxLines Description}}

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: 

Required: False
Position: 2
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -MinLines
{{Fill MinLines Description}}

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: 

Required: False
Position: 3
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -Style
{{Fill Style Description}}

```yaml
Type: AdaptiveTextStyle
Parameter Sets: (All)
Aliases: 
Accepted values: Default, Caption, CaptionSubtle, Body, BodySubtle, Base, BaseSubtle, Subtitle, SubtitleSubtle, Title, TitleSubtle, TitleNumeral, Subheader, SubheaderSubtle, SubheaderNumeral, Header, HeaderSubtle, HeaderNumeral

Required: False
Position: 5
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Text
{{Fill Text Description}}

```yaml
Type: String
Parameter Sets: (All)
Aliases: Content

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Wrap
{{Fill Wrap Description}}

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

## INPUTS

### String

You cannot pipe input to this cmdlet.

## OUTPUTS

### Text

## NOTES
TODO: Implement hint-style (https://blogs.msdn.microsoft.com/tiles_and_toasts/2015/06/30/adaptive-tile-templates-schema-and-documentation/)

## RELATED LINKS

[https://github.com/Windos/BurntToast](https://github.com/Windos/BurntToast)


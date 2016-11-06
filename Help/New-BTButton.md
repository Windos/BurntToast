---
external help file: BurntToast-help.xml
online version: https://github.com/Windos/BurntToast
schema: 2.0.0
---

# New-BTButton

## SYNOPSIS

## SYNTAX

### Button (Default)
```
New-BTButton -Content <String> -Arguments <String> [-ActivationType <ToastActivationType>] [-ImageUri <String>]
 [-Id <String>]
```

### Snooze
```
New-BTButton [-Snooze] [-Content <String>] [-ImageUri <String>] [-Id <String>]
```

### Dismiss
```
New-BTButton [-Dismiss] [-Content <String>] [-ImageUri <String>]
```

## DESCRIPTION
{{Fill in the Description}}

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

### -ActivationType
{{Fill ActivationType Description}}

```yaml
Type: ToastActivationType
Parameter Sets: Button
Aliases: 
Accepted values: Foreground, Background, Protocol

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Arguments
{{Fill Arguments Description}}

```yaml
Type: String
Parameter Sets: Button
Aliases: 

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Content
{{Fill Content Description}}

```yaml
Type: String
Parameter Sets: Button
Aliases: 

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

```yaml
Type: String
Parameter Sets: Snooze, Dismiss
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Dismiss
{{Fill Dismiss Description}}

```yaml
Type: SwitchParameter
Parameter Sets: Dismiss
Aliases: 

Required: True
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Id
{{Fill Id Description}}

```yaml
Type: String
Parameter Sets: Button, Snooze
Aliases: TextBoxId, SelectionBoxId

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ImageUri
{{Fill ImageUri Description}}

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

### -Snooze
{{Fill Snooze Description}}

```yaml
Type: SwitchParameter
Parameter Sets: Snooze
Aliases: 

Required: True
Position: Named
Default value: False
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


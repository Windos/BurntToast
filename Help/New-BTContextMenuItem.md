# New-BTContextMenuItem

## SYNOPSIS
Creates a Context Menu Item object.

## SYNTAX

```
New-BTContextMenuItem [-Content] <String> [-Arguments] <String> [[-ActivationType] <ToastActivationType>]
```

## DESCRIPTION
The New-BTContextMenuItem function creates a Context Menu Item object.

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
PS C:\>New-BTContextMenuItem -Content 'Google' -Arguments 'https://google.com' -ActivationType Protocol
```

This command creates a new Context Menu Item object with the specified properties.

## PARAMETERS

### -ActivationType
Controls what type of activation this menu item will use when clicked. Defaults to Foreground.

```yaml
Type: ToastActivationType
Parameter Sets: (All)
Aliases:
Accepted values: Foreground, Background, Protocol

Required: False
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Arguments
App-defined string of arguments that the app can later retrieve once it is activated when the user clicks the menu item.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Content
The text to display on the menu item.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

## INPUTS

### None

## OUTPUTS

### ToastContextMenuItem

## NOTES
Credit for most of the help text for this function go to the authors of the UWPCommunityToolkit library that this module relies upon.

Please see the originating repo here: https://github.com/Microsoft/UWPCommunityToolkit

## RELATED LINKS

[New-BTContextMenuItem](https://github.com/Windos/BurntToast/blob/master/Help/New-BTContextMenuItem.md)

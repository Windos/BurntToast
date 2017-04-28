---
online version: https://github.com/Windos/BurntToast/blob/master/Help/New-BTProgressBar.md
schema: 2.0.0
---

# New-BTProgressBar

## SYNOPSIS
Creates a new Progress Bar Element for Toast Notifications.

## SYNTAX

### Determinate (Default)
```
New-BTProgressBar [-Title <String>] -Status <String> -Value <Double> [-ValueDisplay <String>]
```

### Indeterminate
```
New-BTProgressBar [-Title <String>] -Status <String> -Indeterminate [-ValueDisplay <String>]
```

## DESCRIPTION
The New-BTProgressBar function creates a new Progress Bar Element for Toast Notifications.

You must specify the status and value for the progress bar and can optionally give the bar a title and override the automatic text representiation of the progress.

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
PS C:\>New-BTProgressBar -Status 'Copying files' -Value 0.2
```

This command creates a Progress Bar that is 20% full with the current status of 'Copying files' and the (default) text 20% displayed underneath.

### -------------------------- EXAMPLE 2 --------------------------
```
PS C:\>New-BTProgressBar -Status 'Copying files' -Indeterminate
```

This command creates a Progress Bar with an 'indeterminate' animation rather than a bar filled to a certain percentage.

### -------------------------- EXAMPLE 3 --------------------------
```
PS C:\>New-BTProgressBar -Status 'Copying files' -Value 0.2 -ValueDisplay '4/20 files complete'
```

This command creates a Progress Bar that is 20% full with the current status of 'Copying files' and the default text displayed underneath overridden to '4/20 files complete.'

### -------------------------- EXAMPLE 4 --------------------------
```
PS C:\>New-BTProgressBar -Title 'File Copy' -Status 'Copying files' -Value 0.2
```

This example creates a Progress Bar that is 20% full with the current status of 'Copying files' and the (default) text 20% displayed underneath.

The Progress Bar is displayed under the title 'File Copy.'

## PARAMETERS

### -Title
The text displayed above the progress bar. Generally used to give context around what the bar represents.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Names
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Status
The text displayed under the progress bar. Used to show the current status of the operation being performed.

Examples include: Running, Paused, Stopped, Finished.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Indeterminate
Used where the percentage complete is unknown, the resulting progress bar displays a system generated animation rather than a filled bar.

Cannot be used at the same time as a set Value.

```yaml
Type: SwitchParameter
Parameter Sets: Indeterminate
Aliases:

Required: True
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Value
Specifies the percentage to fill the progress bar as represented by a double, between 0 and 1 (inclusive.)

For example 0.4 is 40%, 1 is 100%.

```yaml
Type: Double
Parameter Sets: Determinate
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ValueDisplay
A string that replaces the default text representation of the percentage complete.

The default text for the value 0.2 would be '20%', this parameter replaces this text with something of your own choice.

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

## INPUTS

### String

You cannot pipe input to this cmdlet.

## OUTPUTS

### AdaptiveProgressBar

## NOTES

## RELATED LINKS

[New-BTProgressBar](https://github.com/Windos/BurntToast/blob/master/Help/New-BTProgressBar.md)

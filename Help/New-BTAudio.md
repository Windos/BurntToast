---
external help file: BurntToast-help.xml
online version: https://github.com/Windos/BurntToast
schema: 2.0.0
---

# New-BTAudio

## SYNOPSIS
Creates a new Audio Element for Toast Notifications.

## SYNTAX

```
New-BTAudio [[-Source] <Uri>] [-Loop] [-Silent]
```

## DESCRIPTION
The New-BTAudioElement cmdlet creates a new Audio Element for Toast Notifications.

You can use the parameters of New-BTAudioElement to select an audio file or a standard notification sound (including alarms).
Alternativly you can specify that a Toast Notification should be silent.

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
New-BTAudioElement -Source SMS
```

Creates an Audio Element which will cause a Toast Notification to play the standard Microsoft 'SMS' sound.

### -------------------------- EXAMPLE 2 --------------------------
```
New-BTAudioElement -Path 'C:\Music\FavSong.mp3'
```

Creates an Audio Element which will cause a Toast Notification to play the specified song.

### -------------------------- EXAMPLE 3 --------------------------
```
New-BTAudioElement -Silent
```

Creates an Audio Element which will cause a Toast Notification to be silent.

## PARAMETERS

### -Loop
{{Fill Loop Description}}

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

### -Silent
{{Fill Silent Description}}

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

### -Source
{{Fill Source Description}}

```yaml
Type: Uri
Parameter Sets: (All)
Aliases: 

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

## INPUTS

### None

You cannot pipe input to this cmdlet.

## OUTPUTS

### Audio

## NOTES

## RELATED LINKS

[https://github.com/Windos/BurntToast](https://github.com/Windos/BurntToast)


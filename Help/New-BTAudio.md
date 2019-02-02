# New-BTAudio

## SYNOPSIS
Creates a new Audio Element for Toast Notifications.

## SYNTAX

### StandardSound (Default)
```
New-BTAudio -Source <Uri> [-Loop]
```

### StandardSound (Default)
```
New-BTAudio -Path <String> [-Loop]
```

### StandardSound (Default)
```
New-BTAudio -Silent
```

## DESCRIPTION
The New-BTAudioElement function creates a new Audio Element for Toast Notifications.

You can use the parameters of New-BTAudioElement to select an audio file or a standard notification sound (including alarms).
Alternativly you can specify that a Toast Notification should be silent.

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
PS C:\>New-BTAudioElement -Source SMS
```

Creates an Audio Element which will cause a Toast Notification to play the standard Microsoft 'SMS' sound.

### -------------------------- EXAMPLE 2 --------------------------
```
PS C:\>New-BTAudioElement -Path 'C:\Music\FavSong.mp3'
```

Creates an Audio Element which will cause a Toast Notification to play the specified song.

### -------------------------- EXAMPLE 3 --------------------------
```
PS C:\>New-BTAudioElement -Silent
```

Creates an Audio Element which will cause a Toast Notification to be silent.

## PARAMETERS

### -Loop
Specifies that the slected sound should play multiple times if its duration is shorter than that of the toast it accompanies.

```yaml
Type: SwitchParameter
Parameter Sets: CustomSound, StandardSound
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Path
The full path to an audio file. Supported file types include:

*.aac
*.flac
*.m4a
*.mp3
*.wav
*.wma

```yaml
Type: String
Parameter Sets: CustomSound
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Silent
Specifies that the toast should be displayed without sound.

```yaml
Type: SwitchParameter
Parameter Sets: Silent
Aliases:

Required: True
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Source
Specifies one of the built in Microsoft notification sounds.

This paramater takes the full form of the sounds, in the form of a uri. The New-BurntToastNotification function simplifies this, so be aware of the difference.

```yaml
Type: Uri
Parameter Sets: StandardSound
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

## INPUTS

### None

You cannot pipe input to this cmdlet.

## OUTPUTS

### ToastAudio

## NOTES

## RELATED LINKS

[New-BTAudio](https://github.com/Windos/BurntToast/blob/master/Help/New-BTAudio.md)

# New-BTAudio

## SYNOPSIS

Creates a new Audio object for Toast Notifications.

## DESCRIPTION

The `New-BTAudio` function creates an audio object for Toast Notifications.
You can use this function to select a built-in notification sound (including alarms/calls), specify a custom audio file, or indicate that the notification should be silent.

## PARAMETERS

| Name        | Type         | Description                                                                                                                                                                | Mandatory              |
|-------------|--------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------|------------------------|
| `Source`    | Uri          | URI string. Specifies the sound to play with the Toast Notification. Accepts Microsoft notification sound URIs such as `ms-winsoundevent:Notification.IM` or a file path for custom audio. | Yes (when using standard sound) |
| `Loop`      | Switch       | Specifies that the selected sound should loop, if its duration is shorter than the toast it accompanies.                                                                    | No                     |
| `Silent`    | Switch       | Makes the toast silent (no sound).                                                                                                                                         | Yes (when using silent) |

## INPUTS

None. You cannot pipe input to this function.

## OUTPUTS

Microsoft.Toolkit.Uwp.Notifications.ToastAudio

## EXAMPLES

### Example 1

```powershell
New-BTAudio -Source ms-winsoundevent:Notification.SMS
```

Creates an audio object which will cause a Toast Notification to play the standard Microsoft 'SMS' sound.

### Example 2

```powershell
New-BTAudio -Source 'C:\Music\FavSong.mp3'
```

Creates an audio object which will cause a Toast Notification to play the specified song or audio file.

### Example 3

```powershell
New-BTAudio -Silent
```

Creates an audio object which will cause a Toast Notification to be silent.

## LINKS

- [New-BurntToastNotification](New-BurntToastNotification.md)
- [New-BTProgressBar](New-BTProgressBar.md)
- [New-BTAction](New-BTAction.md)

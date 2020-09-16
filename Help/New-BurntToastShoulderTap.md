# New-BurntToastShoulderTap

## SYNOPSIS

Creates and displays a Windows 10 Shoulder Tap Notification, which is a notification for a person pinned to your Taskbar.

## NOTES
There's some manual steps required to create and pin a contact which matches the specified email address in the Person parameter.

Follow the [instructions here](https://toastit.dev/2019/04/02/crouton-10/) for the prerequisites to use this cmdlet.  See below for the expected output!

<img src="https://toastit.dev/content/images/2019/04/Carlton.gif">

## SYNTAX

### Sound (Default)

```powershell
New-BurntToastNotification [-Text <String[]>] [-AppLogo <String>] [-Sound <String>] [-Header <ToastHeader>] [-ProgressBar <AdaptiveProgressBar>]
```

### Silent

```powershell
New-BurntToastNotification [-Text <String[]>] [-AppLogo <String>] [-Silent] [-Header <ToastHeader>] [-ProgressBar <AdaptiveProgressBar>]
```

### Snooze and Dismiss

```powershell
New-BurntToastNotification [-Text <String[]>] [-AppLogo <String>] -SnoozeAndDismiss [-Header <ToastHeader>] [-ProgressBar <AdaptiveProgressBar>]
```

### Custom Buttons

```powershell
New-BurntToastNotification [-Text <String[]>] [-AppLogo <String>] -Button <IToastButton[]> [-Header <ToastHeader>] [-ProgressBar <AdaptiveProgressBar>]
```

### Silent and Snooze and Dismiss

```powershell
New-BurntToastNotification [-Text <String[]>] [-AppLogo <String>] [-Silent] -SnoozeAndDismiss [-Header <ToastHeader>] [-ProgressBar <AdaptiveProgressBar>]
```

### Silent and Custom Buttons

```powershell
New-BurntToastNotification [-Text <String[]>] [-AppLogo <String>] [-Silent] -Button <IToastButton[]> [-Header <ToastHeader>] [-ProgressBar <AdaptiveProgressBar>]
```

### Sound and Snooze and Dismiss

```powershell
New-BurntToastNotification [-Text <String[]>] [-AppLogo <String>] [-Sound <String>] -SnoozeAndDismiss [-Header <ToastHeader>] [-ProgressBar <AdaptiveProgressBar>]
```

### Sound and Custom Buttons

```powershell
New-BurntToastNotification [-Text <String[]>] [-AppLogo <String>] [-Sound <String>] -Button <IToastButton[]> [-Header <ToastHeader>] [-ProgressBar <AdaptiveProgressBar>]
```

## DESCRIPTION

The New-BurntToastShoulderTap function creates and displays a Should Tap Toast Notification on Microsoft Windows 10.

You can specify the text and/or image displayed as well as selecting the sound that is played when the Toast Notification is displayed.

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------

```powershell
PS C:\>$Image = 'https://i.imgur.com/WKiNp5o.gif'
    $Contact = 'stormy@example.com'
    $Text = 'First Shoulder Tap', 'This is for the fallback toast.'

    New-BurntToastShoulderTap -Image $Image -Person $Contact -Text $Text
```

This command creates and displays a Should Tap Toast Notification with all default values, for a pinned user named 'stormy@example.com'.  If this user does not exist or is not pinned to the Taskbar, Burnt Toast will fall back to a default notification instead.

## PARAMETERS

### -AppLogo

Specifies the path to an image that will override the default image displayed with a Toast Notification.

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

### -Button

Allows up to five buttons to be added to the bottom of the Toast Notification. These buttons should be created using the New-BTButton function.

```yaml
Type: IToastButton[]
Parameter Sets: Custom Buttons, Silent and Custom Buttons, Sound and Custom Buttons
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Silent

Indicates that the Toast Notification will be displayed on screen without an accompanying sound.

Cannot be used in conjunction with the 'Sound' parameter.

```yaml
Type: SwitchParameter
Parameter Sets: Silent, Silent and Snooze and Dismiss, Silent and Custom Buttons
Aliases:

Required: True
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -SnoozeAndDismiss

Adds a default selection box and snooze/dismiss buttons to the bottom of the Toast Notification.

```yaml
Type: SwitchParameter
Parameter Sets: Snooze and Dismiss, Silent and Snooze and Dismiss, Sound and Snooze and Dismiss
Aliases:

Required: True
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Sound

Selects the sound to acompany the Toast Notification. Any 'Alarm' or 'Call' tones will automatically loop and extent the amount of time that a Toast is displayed on screen.

Cannot be used in conjunction with the 'Silent' switch.

```yaml
Type: String
Parameter Sets: Sound
Aliases:

Required: False
Position: Named
Default value: Default
Accept pipeline input: False
Accept wildcard characters: False
```

```yaml
Type: String
Parameter Sets: Sound and Snooze and Dismiss, Sound and Custom Buttons
Aliases:

Required: True
Position: Named
Default value: Default
Accept pipeline input: False
Accept wildcard characters: False
```

### -Text

Specifies the text to show on the Toast Notification. Up to three strings can be displayed, the first of which will be embolden as a title.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: Default Notification
Accept pipeline input: False
Accept wildcard characters: False
```

### -UniqueIdentifier

A string that uniquely identifies a toast notification. Submitting a new toast with the same identifier as a previous toast will replace the previous toast.

This is useful when updating the progress of a process, using a progress bar, or otherwise correcting/updating the information on a toast.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value:
Accept pipeline input: False
Accept wildcard characters: False
```

## INPUTS

TODO

You cannot pipe input to this function.

## OUTPUTS

Displays a Windows 10 Shoulder Tap message is a matching user (matches by e-mail address) is pinned to the task bar.

If not, fails back to a standard Burnt Toast notification

## RELATED LINKS

[New-BurntToastShoulderTap](https://github.com/Windos/BurntToast/blob/main/Help/New-BurntToastShoulderTap.md)

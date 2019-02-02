# New-BTButton

## SYNOPSIS

Creates a new clickable button for a Toast Notification.

## SYNTAX

### Button (Default)

```powershell
New-BTButton -Content <String> -Arguments <String> [-ActivationType {Foreground | Background | Protocol}] [-ImageUri <String>] [-Id <String>]
```

### Snooze

```powershell
New-BTButton -Snooze [-Content <String>] [-Id <String>]
```

### Dismiss

```powershell
New-BTButton -Dismiss [-Content <String>]
```

## DESCRIPTION

The New-BTButton function creates a new clickable button for a Toast Notification. Up to five buttons can be added to one Toast.

Buttons can be fully customized with display text, images and arguments or system handled 'Snooze' and 'Dismiss' buttons.

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------

```powershell
PS C:\>New-BTButton -Dismiss
```

This command creates a button which mimmicks the act of 'swiping away' the Toast when clicked.

### -------------------------- EXAMPLE 2 --------------------------

```powershell
PS C:\>New-BTButton -Snooze
```

This command creates a button which will snooze the Toast for the system default snooze time (often 10 minutes).

### -------------------------- EXAMPLE 3 --------------------------

```powershell
PS C:\>New-BTButton -Snooze -Content 'Sleep' -Id 'TimeSelection'
```

This command creates a button which will snooze the Toast for the time selected in the SelectionBox with the ID 'TimeSelection'. The button will show the text 'Sleep' rather than 'Dismiss.'

### -------------------------- EXAMPLE 4 --------------------------

```powershell
PS C:\>New-BTButton -Content 'Blog' -Arguments 'http://king.geek.nz'
```

This command creates a button with the display text "Blog", which will launch a browser window to "http://king.geek.nz" when clicked.

### -------------------------- EXAMPLE 5 --------------------------

```powershell
PS C:\>$Picture = 'C:\temp\example.png'
PS C:\>New-BTButton -Content 'View Picture' -Arguments $Picture -ImageUri $Picture
```

This example creates a button with the display text "View Picture" with a picture to the left, which will launch the default picture viewer application and load the picture when clicked.

## PARAMETERS

### -ActivationType

Defines the ActivationType that is trigger when the button is pressed.

Defaults to Protocol which will open the file or URI specified in with the Arguments parameter in the rlevant system default application.

```yaml
Type: ToastActivationType
Parameter Sets: Button
Aliases:
Accepted values: Foreground, Background, Protocol

Required: False
Position: Named
Default value: Protocol
Accept pipeline input: False
Accept wildcard characters: False
```

### -Arguments

Specifies an app defined string.

For the purposes of BurntToast notifications this is generally the path to a file or URI and paired with the Protocol ActivationType.

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

Specifies the text to display on the button.

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

Specifies a system handled dismiss button. Clicking the resulting button has the same affect as 'swiping away' or otherwise dismissing the Toast.

Display text defaults to a localized 'Dismiss', but this can be overridden with the Content parameter.

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

Specifies the ID of a relevant Toast control.

Standard buttons can be paried with a text box which makes the button appear to the right of it.

Snooze buttons can be paired with a selection box to select the ammount of time to snooze.

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

Specifies an image icon to display on the button.

```yaml
Type: String
Parameter Sets: Button
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Snooze

Specifies a system handled snooze button. When paired with a selection box the snooze time is customizable and user selectable, otherwise the system default snooze time is used.

Display text defaults to a localized 'Snooze', but this can be overridden with the Content parameter.

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

TODO

You cannot pipe input to this function.

## OUTPUTS

Microsoft.Toolkit.Uwp.Notifications.ToastButton

Microsoft.Toolkit.Uwp.Notifications.ToastButtonDismiss

Microsoft.Toolkit.Uwp.Notifications.ToastButtonSnooze

## NOTES

## RELATED LINKS

[New-BTButton](https://github.com/Windos/BurntToast/blob/master/Help/New-BTButton.md)

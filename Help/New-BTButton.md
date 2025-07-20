# New-BTButton

## SYNOPSIS

Creates a new clickable button for a Toast Notification.

## DESCRIPTION

The `New-BTButton` function creates a new button for a Toast Notification.
Up to five buttons can be added to a single Toast notification. Buttons may have display text, an icon, an optional activation type, argument string, or serve as system managed Dismiss/Snooze buttons.

## PARAMETERS

| Name           | Type                                                    | Description                                                                                                                                                                                                                  |
|----------------|---------------------------------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `Snooze`       | Switch                                                  | Creates a system-handled snooze button. When paired with a selection box on the toast, the snooze time is customizable.                                                               |
| `Dismiss`      | Switch                                                  | Creates a system-handled dismiss button.                                                                                                                                               |
| `Content`      | String                                                  | The text to display on this button. For system buttons, this overrides the default label.                                                                                              |
| `Arguments`    | String                                                  | App-defined string to pass when the button is pressed. Often a URI or file path to open.                                                                                              |
| `ActivationType`| Microsoft.Toolkit.Uwp.Notifications.ToastActivationType| Defines the activation type that triggers when the button is pressed. Defaults to Protocol.                                                                                            |
| `ImageUri`     | String                                                  | Path or URI of an image icon to display next to the button label.                                                                                                                      |
| `Id`           | String                                                  | Specifies an ID associated with another toast control (textbox or selection box). For standard buttons, this aligns the button next to a control; for snooze buttons, associates with a selection box.                      |

## INPUTS

None. You cannot pipe input to this function.

## OUTPUTS

- Microsoft.Toolkit.Uwp.Notifications.ToastButton
- Microsoft.Toolkit.Uwp.Notifications.ToastButtonDismiss
- Microsoft.Toolkit.Uwp.Notifications.ToastButtonSnooze

## EXAMPLES

### Example 1

```powershell
New-BTButton -Dismiss
```

Creates a button which mimics the act of 'swiping away' the Toast when clicked.

### Example 2

```powershell
New-BTButton -Snooze
```

Creates a snooze button with system default snooze duration.

### Example 3

```powershell
New-BTButton -Snooze -Content 'Sleep' -Id 'TimeSelection'
```

Snooze button using the label 'Sleep' and referencing a selection box control.

### Example 4

```powershell
New-BTButton -Content 'Blog' -Arguments 'https://king.geek.nz'
```

Regular button that opens a URL when clicked.

### Example 5

```powershell
$pic = 'C:\temp\example.png'
New-BTButton -Content 'View Picture' -Arguments $pic -ImageUri $pic
```

Button with a picture to the left, launches the image file.

## LINKS

- [New-BTAction](New-BTAction.md)
- [New-BTContextMenuItem](New-BTContextMenuItem.md)
- [New-BTText](New-BTText.md)
- [New-BTSelectionBoxItem](New-BTSelectionBoxItem.md)

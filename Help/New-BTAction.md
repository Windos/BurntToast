# New-BTAction

## SYNOPSIS

Creates an action set for a Toast Notification.

## DESCRIPTION

The `New-BTAction` function creates a Toast action object (`IToastActions`), defining the controls displayed at the bottom of a Toast Notification. Actions can be custom (buttons, context menu items, and input controls) or system handled (Snooze and Dismiss).

## PARAMETERS

| Name              | Type                                                      | Description                                                                                                                           | Mandatory           |
|-------------------|-----------------------------------------------------------|---------------------------------------------------------------------------------------------------------------------------------------|---------------------|
| `Buttons`         | Microsoft.Toolkit.Uwp.Notifications.IToastButton[]        | Button objects created with `New-BTButton`. Up to five may be included, or fewer if context menu items are also included.              | No                  |
| `ContextMenuItems`| Microsoft.Toolkit.Uwp.Notifications.ToastContextMenuItem[]| Right-click context menu item objects created with `New-BTContextMenuItem`. Up to five may be included, or fewer if Buttons are included.| No                  |
| `Inputs`          | Microsoft.Toolkit.Uwp.Notifications.IToastInput[]         | Input objects created via `New-BTText` and `New-BTSelectionBoxItem`. Up to five can be included.                                      | No                  |
| `SnoozeAndDismiss`| Switch                                                    | Switch. Creates a system-handled set of Snooze and Dismiss buttons, only available in the 'SnoozeAndDismiss' parameter set. Cannot be used with custom actions. | Yes (when using 'SnoozeAndDismiss' set) |

## INPUTS

None. You cannot pipe input to this function.

## OUTPUTS

Microsoft.Toolkit.Uwp.Notifications.IToastActions

## EXAMPLES

### Example 1

```powershell
New-BTAction -SnoozeAndDismiss
```

Creates an action set using the system handled snooze and dismiss modal.

### Example 2

```powershell
New-BTAction -Buttons (New-BTButton -Content 'Google' -Arguments 'https://google.com')
```

Creates an action set with a single button that opens Google.

### Example 3

```powershell
$Button = New-BTButton -Content 'Google' -Arguments 'https://google.com'
$ContextMenuItem = New-BTContextMenuItem -Content 'Bing' -Arguments 'https://bing.com'
New-BTAction -Buttons $Button -ContextMenuItems $ContextMenuItem
```

Creates an action set with both a clickable button and a context menu item.

### Example 4

```powershell
New-BTAction -Inputs (New-BTText -Content "Add comment")
```

Creates an action set allowing user textual input in the notification.

## LINKS

- [New-BTButton](New-BTButton.md)
- [New-BTContextMenuItem](New-BTContextMenuItem.md)
- [New-BTText](New-BTText.md)
- [New-BTSelectionBoxItem](New-BTSelectionBoxItem.md)

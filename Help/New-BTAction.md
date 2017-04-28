---
online version: https://github.com/Windos/BurntToast/blob/master/Help/New-BTAction.md
schema: 2.0.0
---

# New-BTAction

## SYNOPSIS
Creates an action object for a Toast Notification.

## SYNTAX

### Custom Actions (Default)

```
New-BTAction [[-Buttons] <IToastButton[]>] [[-ContextMenuItems] <ToastContextMenuItem[]>] [[-Inputs] <IToastInput[]>]
```

### SnoozeAndDismiss

```
New-BTAction -SnoozeAndDismiss
```

## DESCRIPTION
The New-BTAction function creates an 'action' object which contains defines the controls displayed at the bottom of a Toast Notification.

Actions can either be system handeled and automatically localized Snooze and Dismiss buttons or a custom collection of inputs.

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
PS C:\>New-BTAction -SnoozeAndDismiss
```

This command creates an action element using the system handled snooze and dismiss modal.

### -------------------------- EXAMPLE 2 --------------------------
```
PS C:\>New-BTAction -Buttons (New-BTButton -Content 'Google' -Arguments 'https://google.com')
```

This command creates an action element with a single clickable button.

### -------------------------- EXAMPLE 3 --------------------------
```
PS C:\>$Button = New-BTButton -Content 'Google' -Arguments 'https://google.com'
PS C:\>$ContextMenuItem = New-BTContextMenuItem -Content 'Bing' -Arguments 'https://bing.com'
PS C:\>New-BTAction -Buttons $Button -ContextMenuItems $ContextMenuItem
```

This example creates an action elemnt with both a clickable button and a right click context menu item.

## PARAMETERS

### -Buttons
Button objects created with the New-BTButton function. Up to five can be included, or less if Context Menu Items are also included.

```yaml
Type: IToastButton[]
Parameter Sets: Custom Actions
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ContextMenuItems
Right click context menu item objects created with the New-BTContextMenuItem function. Up to five can be included, or less if Buttons are also included.

```yaml
Type: ToastContextMenuItem[]
Parameter Sets: Custom Actions
Aliases:

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Inputs
Input objects created via the New-BTText and New-BTSelectionBoxItem functions. Up to five can be included.

```yaml
Type: IToastInput[]
Parameter Sets: Custom Actions
Aliases:

Required: False
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SnoozeAndDismiss
Creates a system handeled snooze and dismiss action. Cannot be included inconjunction with custom actions.

```yaml
Type: SwitchParameter
Parameter Sets: SnoozeAndDismiss
Aliases:

Required: True
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

## INPUTS

### None
You cannot pipe input to this function.

## OUTPUTS

### Microsoft.Toolkit.Uwp.Notifications.IToastActions

## NOTES

## RELATED LINKS

[New-BTAction](https://github.com/Windos/BurntToast/blob/master/Help/New-BTAction.md)

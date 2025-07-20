# Get-BTHistory

## SYNOPSIS

Shows all toast notifications in the Action Center or scheduled notifications.

## DESCRIPTION

The `Get-BTHistory` function returns all toast notifications that are in the Action Center and have not been dismissed by the user.
You can retrieve a specific toast notification with a unique identifier, or include scheduled notifications (either scheduled outright or snoozed).
The objects returned include tag and group information which can be used with `Remove-BTNotification` to remove specific notifications.

## PARAMETERS

| Name              | Type   | Description                                                                                 |
|-------------------|--------|---------------------------------------------------------------------------------------------|
| `UniqueIdentifier`| String | Returns only toasts with a matching tag or group specified by the provided unique identifier.|
| `ScheduledToast`  | Switch | If provided, returns scheduled toast notifications instead of those currently in the Action Center.|

## INPUTS

None. You cannot pipe input to this function.

## OUTPUTS

- Microsoft.Toolkit.Uwp.Notifications.ToastNotification
- Microsoft.Toolkit.Uwp.Notifications.ScheduledToastNotification

## EXAMPLES

### Example 1

```powershell
Get-BTHistory
```

Returns all toast notifications in the Action Center.

### Example 2

```powershell
Get-BTHistory -ScheduledToast
```

Returns scheduled toast notifications.

### Example 3

```powershell
Get-BTHistory -UniqueIdentifier 'Toast001'
```

Returns toasts with the matching unique identifier in their tag or group.

## LINKS

- [Remove-BTNotification](Remove-BTNotification.md)
- [Get-BTHeader](Get-BTHeader.md)

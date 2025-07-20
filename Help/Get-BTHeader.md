# Get-BTHeader

## SYNOPSIS

Shows and filters all toast notification headers in the Action Center.

## DESCRIPTION

The `Get-BTHeader` function returns all the unique toast notification headers currently present in the Action Center (notifications which have not been dismissed by the user).
You can filter by a specific toast notification identifier, header title, or header id.

## PARAMETERS

| Name                   | Type   | Description                                                                      |
|------------------------|--------|----------------------------------------------------------------------------------|
| `ToastUniqueIdentifier`| String | The unique identifier of a toast notification. Only headers belonging to the notification with this identifier will be returned. |
| `Title`                | String | Filters headers by a specific title.                                             |
| `Id`                   | String | Filters headers to only those with the specified header id.                      |

## INPUTS

None. You cannot pipe input to this function.

## OUTPUTS

Microsoft.Toolkit.Uwp.Notifications.ToastHeader

## EXAMPLES

### Example 1

```powershell
Get-BTHeader
```

Returns all unique toast notification headers in the Action Center.

### Example 2

```powershell
Get-BTHeader -ToastUniqueIdentifier 'Toast001'
```

Returns headers for toasts with the specified unique identifier.

### Example 3

```powershell
Get-BTHeader -Title "Stack Overflow Questions"
```

Returns headers with a specific title.

### Example 4

```powershell
Get-BTHeader -Id "001"
```

Returns the header with the matching id.

## LINKS

- [Get-BTHistory](Get-BTHistory.md)
- [New-BTHeader](New-BTHeader.md)

# Update-BTNotification

## SYNOPSIS

Updates an existing toast notification.

## DESCRIPTION

The `Update-BTNotification` function updates a toast notification by matching `UniqueIdentifier` and replacing or updating its contents/data.
`DataBinding` provides the values to update in the notification, and `SequenceNumber` ensures correct ordering if updates overlap.

## PARAMETERS

| Name              | Type     | Description                                                                                             |
|-------------------|----------|---------------------------------------------------------------------------------------------------------|
| `SequenceNumber`  | UInt64   | Used for notification versioning; higher numbers indicate newer content to prevent out-of-order display. |
| `UniqueIdentifier`| String   | String uniquely identifying the toast notification to update.                                            |
| `DataBinding`     | Hashtable| Hashtable containing the data binding keys/values to update.                                             |

## INPUTS

None. You cannot pipe input to this function.

## OUTPUTS

None.

## EXAMPLES

### Example 1

```powershell
$data = @{ Key = 'Value' }
Update-BTNotification -UniqueIdentifier 'ID001' -DataBinding $data
```

Updates notification with key 'ID001' using new data binding values.

## LINKS

- [Submit-BTNotification](Submit-BTNotification.md)
- [New-BurntToastNotification](New-BurntToastNotification.md)

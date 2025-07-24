# Submit-BTNotification

## SYNOPSIS

Submits a completed toast notification for display.

## DESCRIPTION

The `Submit-BTNotification` function submits a completed toast notification to the operating system's notification manager for display.
This function supports advanced scenarios such as event callbacks for user actions or toast dismissal, sequence numbering to ensure correct update order, unique identification for toast replacement, expiration control, and direct Action Center delivery.

When a script block is supplied for any of the event actions (`ActivatedAction`, `DismissedAction`, or `FailedAction`), the function ensures that only one registration for a logically identical handler is allowed per notification event type. This is accomplished by normalizing and hashing the script block; the resulting hash uniquely identifies the action for event registration purposes. Attempting to register the same handler multiple times for a given event will not create a duplicate subscription, but instead will produce an informative warning.

If the `-ReturnEventData` switch is used and any event action scriptblocks are supplied (`ActivatedAction`, `DismissedAction`, `FailedAction`),
the `$Event` automatic variable from the event will be assigned to `$global:ToastEvent` before invoking your script block.
You can override the variable name used for event data by specifying `-EventDataVariable`.
If supplied, the event data will be assigned to the chosen global variable in your event handler (e.g., `-EventDataVariable 'CustomEvent'` results in `$global:CustomEvent`).
Specifying `-EventDataVariable` implicitly enables the behavior of `-ReturnEventData`.

## PARAMETERS

| Name               | Type        | Description                                                                                                           | Mandatory |
|--------------------|-------------|-----------------------------------------------------------------------------------------------------------------------|-----------|
| `Content`          | ToastContent     | A ToastContent object to display, such as returned by `New-BTContent`. The content defines the visual and data parts of the toast.                | No        |
| `SequenceNumber`   | UInt64      | A number that sequences this notification's version. When updating a toast, a higher sequence number ensures the most recent notification is displayed. | No        |
| `UniqueIdentifier` | String      | A string that uniquely identifies the toast notification. Submitting a new toast with the same identifier as a previous toast replaces the previous notification. | No        |
| `DataBinding`      | Hashtable   | Hashtable mapping strings to binding keys in a toast notification. Enables advanced updating scenarios.                | No        |
| `ExpirationTime`   | DateTime    | When the notification is no longer relevant and should be removed from the Action Center.                             | No        |
| `SuppressPopup`    | Switch      | If set, the notification is delivered directly to the Action Center (bypassing immediate display).                    | No        |
| `ActivatedAction`  | ScriptBlock | A script block executed if the user activates/clicks the toast notification.                                         | No        |
| `DismissedAction`  | ScriptBlock | A script block executed if the user dismisses the toast notification.                                                | No        |
| `FailedAction`     | ScriptBlock | A script block executed if the notification fails to display properly.                                               | No        |
| `ReturnEventData`  | Switch      | If set, the `$Event` variable from notification activation/dismissal is made available as `$global:ToastEvent` within event action script blocks. | No        |
| `EventDataVariable`| String      | Assigns the `$Event` variable from notification callbacks to this global variable name. Implies `ReturnEventData`.   | No        |

## INPUTS

None. You cannot pipe input to this function.

## OUTPUTS

None. This function submits a toast but returns no objects.

## EXAMPLES

### Example 1

```powershell
Submit-BTNotification -Content $Toast1 -UniqueIdentifier 'Toast001'
```

Submits the toast content object `$Toast1` and tags it with a unique identifier so it can be replaced or updated.

## LINKS

- [New-BTContent](New-BTContent.md)
- [New-BurntToastNotification](New-BurntToastNotification.md)

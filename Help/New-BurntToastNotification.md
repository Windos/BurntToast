# New-BurntToastNotification

## SYNOPSIS

Creates and displays a rich Toast Notification for Windows.

## DESCRIPTION

The `New-BurntToastNotification` function creates and displays a Toast Notification supporting text, images, sounds, progress bars, actions, snooze/dismiss, and more on Microsoft Windows 10+.
Parameter sets ensure mutual exclusivity (e.g., you cannot use Silent and Sound together).

## PARAMETERS

| Name               | Type   | Description                                                                                                      | Mandatory                                                  |
|--------------------|--------|------------------------------------------------------------------------------------------------------------------|------------------------------------------------------------|
| `Text`             | String[] (up to 3) | Up to 3 strings to show within the Toast Notification. The first is the title.                              | No                                                         |
| `Column`           | AdaptiveSubgroup[]  | Array of columns, created by `New-BTColumn`, to be rendered side-by-side in the toast.                      | No                                                         |
| `AppLogo`          | String              | Path to an image that will appear as the application logo.                                                  | No                                                         |
| `HeroImage`        | String              | Path to a prominent hero image for the notification.                                                        | No                                                         |
| `Sound`            | String              | The sound to play. Choose from Default, alarms, calls, etc. (Cannot be used with Silent.)                   | Yes (when using 'Sound-SnD'/'Sound-Button' set)            |
| `Silent`           | Switch              | Makes the notification silent.                                                                              | Yes (when using 'Silent' sets)                             |
| `SnoozeAndDismiss` | Switch              | Adds system-provided snooze and dismiss controls.                                                           | Yes (when using 'SnD' sets)                                |
| `Button`           | IToastButton[]      | Array of button objects for custom actions, created by `New-BTButton`.                                      | Yes (when using 'Button' sets)                             |
| `Header`           | ToastHeader         | Toast header object (`New-BTHeader`): categorize or group notifications.                                    | No                                                         |
| `ProgressBar`      | AdaptiveProgressBar[] | One or more progress bars, created by `New-BTProgressBar`, for visualizing progress within the notification.| No                                                         |
| `UniqueIdentifier` | String              | Optional string grouping related notifications; allows newer notifications to overwrite older.              | No                                                         |
| `DataBinding`      | Hashtable           | Associates string values with binding variables to allow updating toasts by data.                           | No                                                         |
| `ExpirationTime`   | DateTime            | After which the notification is removed from the Action Center.                                             | No                                                         |
| `SuppressPopup`    | Switch              | If set, the toast is sent to Action Center but not displayed as a popup.                                    | No                                                         |
| `CustomTimestamp`  | DateTime            | Custom timestamp used for Action Center sorting.                                                            | No                                                         |
| `ActivatedAction`  | ScriptBlock         | Script block to invoke when the toast is activated (clicked).                                               | No                                                         |
| `DismissedAction`  | ScriptBlock         | Script block to invoke when the toast is dismissed by the user.                                             | No                                                         |
| `EventDataVariable`| String              | The name of the global variable that will contain event data for use in event handler script blocks.        | No                                                         |

## INPUTS

None. You cannot pipe input to this function.

## OUTPUTS

None. `New-BurntToastNotification` displays the toast; it does not return an object.

## EXAMPLES

### Example 1

```powershell
New-BurntToastNotification
```

Shows a toast with all default values.

### Example 2

```powershell
New-BurntToastNotification -Text 'Example', 'Details about the operation.'
```

Shows a toast with custom title and body text.

### Example 3

```powershell
$btn = New-BTButton -Content 'Google' -Arguments 'https://google.com'
New-BurntToastNotification -Text 'New Blog!' -Button $btn
```

Displays a toast with a button that opens Google.

### Example 4

```powershell
$header = New-BTHeader -Id '001' -Title 'Updates'
New-BurntToastNotification -Text 'Major Update Available!' -Header $header
```

Creates a categorized notification under the 'Updates' header.

## LINKS

- [New-BTButton](New-BTButton.md)
- [New-BTColumn](New-BTColumn.md)
- [New-BTHeader](New-BTHeader.md)
- [New-BTProgressBar](New-BTProgressBar.md)
- [Submit-BTNotification](Submit-BTNotification.md)

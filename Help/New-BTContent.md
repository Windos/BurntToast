# New-BTContent

## SYNOPSIS

Creates a new Toast Content object (base element for displaying a toast).

## DESCRIPTION

The `New-BTContent` function creates a new `ToastContent` object, the root config for a toast, containing the toast's visual, actions, audio, header, scenario, etc.

## PARAMETERS

| Name             | Type                                            | Description                                                                                         |
|------------------|-------------------------------------------------|-----------------------------------------------------------------------------------------------------|
| `Actions`        | Microsoft.Toolkit.Uwp.Notifications.IToastActions| Contains one or more custom actions (buttons, context menus, input fields), created via `New-BTAction`.|
| `ActivationType` | Microsoft.Toolkit.Uwp.Notifications.ToastActivationType | Enum. Specifies what activation type is used when the user clicks the toast body.                   |
| `Audio`          | Microsoft.Toolkit.Uwp.Notifications.ToastAudio   | Adds audio properties for the toast, as created by `New-BTAudio`.                                   |
| `Duration`       | Microsoft.Toolkit.Uwp.Notifications.ToastDuration| Enum. How long the toast notification is displayed (Short/Long).                                    |
| `Header`         | Microsoft.Toolkit.Uwp.Notifications.ToastHeader  | ToastHeader object, created via `New-BTHeader`, categorizing the toast in Action Center.            |
| `Launch`         | String                                          | Data passed to the activation context when a toast is clicked.                                      |
| `Scenario`       | Microsoft.Toolkit.Uwp.Notifications.ToastScenario| Enum. Tells Windows to treat the toast as an alarm, reminder, or more (`ToastScenario`).            |
| `Visual`         | Microsoft.Toolkit.Uwp.Notifications.ToastVisual  | **Required.** ToastVisual object, created by `New-BTVisual`, representing the core content of the toast.   |
| `ToastPeople`    | Microsoft.Toolkit.Uwp.Notifications.ToastPeople  | ToastPeople object, representing recipient/persons (optional, used for group chat/etc).             |
| `CustomTimestamp`| DateTime                                        | Optional timestamp for when the toast is considered created (affects Action Center sort order).      |

## INPUTS

None. You cannot pipe input to this function.

## OUTPUTS

Microsoft.Toolkit.Uwp.Notifications.ToastContent

## EXAMPLES

### Example 1

```powershell
$binding = New-BTBinding -Children (New-BTText -Content 'Title')
$visual = New-BTVisual -BindingGeneric $binding
New-BTContent -Visual $visual
```

### Example 2

```powershell
$content = New-BTContent -Visual $visual -ActivationType Protocol -Launch 'https://example.com'
```

Toast opens a browser to a URL when clicked.

## LINKS

- [New-BTAction](New-BTAction.md)
- [New-BTAudio](New-BTAudio.md)
- [New-BTHeader](New-BTHeader.md)
- [New-BTVisual](New-BTVisual.md)
- [New-BTBinding](New-BTBinding.md)

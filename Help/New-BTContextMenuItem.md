# New-BTContextMenuItem

## SYNOPSIS

Creates a Context Menu Item object.

## DESCRIPTION

The `New-BTContextMenuItem` function creates a context menu item (`ToastContextMenuItem`) for a Toast Notification, typically added via `New-BTAction`.

## PARAMETERS

| Name            | Type                                                   | Description                                                                                     | Mandatory |
|-----------------|--------------------------------------------------------|-------------------------------------------------------------------------------------------------|-----------|
| `Content`       | String (Mandatory)                                     | The text string to display to the user for this menu item.                                      | Yes       |
| `Arguments`     | String (Mandatory)                                     | App-defined string that is returned if the context menu item is selected. Routinely a URI, file path, or app context string. | Yes       |
| `ActivationType`| Microsoft.Toolkit.Uwp.Notifications.ToastActivationType| Controls the type of activation for this menu item. Defaults to Foreground if not specified.     | No        |

## INPUTS

None. You cannot pipe input to this function.

## OUTPUTS

Microsoft.Toolkit.Uwp.Notifications.ToastContextMenuItem

## EXAMPLES

### Example 1

```powershell
New-BTContextMenuItem -Content 'Website' -Arguments 'https://example.com' -ActivationType Protocol
```

Creates a menu item labeled "Website" that opens a URL on right-click.

## LINKS

- [New-BTAction](New-BTAction.md)
- [New-BTButton](New-BTButton.md)

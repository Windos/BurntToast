# New-BTSelectionBoxItem

## SYNOPSIS

Creates a selection box item for use in a toast input.

## DESCRIPTION

The `New-BTSelectionBoxItem` function creates a selection box item (`ToastSelectionBoxItem`) to include as an option in a selection box, produced by `New-BTInput`.

## PARAMETERS

| Name        | Type       | Description                                                                                               |
|-------------|------------|-----------------------------------------------------------------------------------------------------------|
| `Id`        | String (Mandatory) | Unique identifier for this selection box item, also referred to by `DefaultSelectionBoxItemId` when used in `New-BTInput`.|
| `Content`   | String (Mandatory) | String to display as the label for the item in the dropdown.                                        |

## INPUTS

None. You cannot pipe input to this function.

## OUTPUTS

Microsoft.Toolkit.Uwp.Notifications.ToastSelectionBoxItem

## EXAMPLES

### Example 1

```powershell
$Select1 = New-BTSelectionBoxItem -Id 'Item1' -Content 'First option in the list'
```

Creates a Selection Box Item for use in a selection input element.

## LINKS

- [New-BTInput](New-BTInput.md)

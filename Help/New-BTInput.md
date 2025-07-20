# New-BTInput

## SYNOPSIS

Creates an input element (text box or selection box) for a Toast notification.

## DESCRIPTION

The `New-BTInput` function creates a `ToastTextBox` for user-typed input or a `ToastSelectionBox` for user selection, for interaction via toasts.
Use the Text parameter set for a type-in input, and the Selection parameter set with a set of options for pick list behavior.

## PARAMETERS

| Name                      | Type                                                                 | Description                                                                                        |
|---------------------------|----------------------------------------------------------------------|----------------------------------------------------------------------------------------------------|
| `Id`                      | String (Mandatory)                                                   | Developer-provided ID for referencing this input/result.                                           |
| `Title`                   | String                                                               | Text to display above the input box or selection.                                                  |
| `PlaceholderContent`      | String (Text set only)                                               | String placeholder to show when the text box is empty.                                             |
| `DefaultInput`            | String                                                               | Default text to pre-fill in the text box.                                                          |
| `DefaultSelectionBoxItemId` | String                                                            | ID of the default selection item (must match one of the provided SelectionBoxItems).               |
| `Items`                   | Microsoft.Toolkit.Uwp.Notifications.ToastSelectionBoxItem[] (Selection set) | Array of `ToastSelectionBoxItem` objects to populate the pick list.                           |

## INPUTS

None. You cannot pipe input to this function.

## OUTPUTS

- Microsoft.Toolkit.Uwp.Notifications.ToastTextBox
- Microsoft.Toolkit.Uwp.Notifications.ToastSelectionBox

## EXAMPLES

### Example 1

```powershell
New-BTInput -Id 'Reply001' -Title 'Type a reply:'
```

Creates a text input field on the toast.

### Example 2

```powershell
New-BTInput -Id 'Choice' -DefaultSelectionBoxItemId 'Item2' -Items $Sel1, $Sel2
```

Creates a selection (dropdown) input with two options.

## LINKS

- [New-BTAction](New-BTAction.md)
- [New-BTSelectionBoxItem](New-BTSelectionBoxItem.md)
- [New-BTText](New-BTText.md)

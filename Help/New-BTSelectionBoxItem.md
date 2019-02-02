# New-BTSelectionBoxItem

## SYNOPSIS

Creates a selection box item.

## SYNTAX

```powershell
New-BTSelectionBoxItem [-Id] <String> [-Content] <String>
```

## DESCRIPTION

The New-BTSelectionBoxItem function creates a selection box item, for inclusion in a selection box created with New-BTInput.

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------

```powershell
PS C:\>$Select1 = New-BTSelectionBoxItem -Id 'Item1' -Content 'First option in the list'
```

This command creates a new Selection Box Item object which can now be used with the New-BTInput function.

## PARAMETERS

### -Content

String that is displayed on the selection item. This is what the user sees.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Id

Developer-provided ID that the developer uses later to retrieve input when the Toast is interacted with.

Can also be provided to a selection box to identify the default selection.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

## INPUTS

None

## OUTPUTS

ToastSelectionBoxItem

## NOTES

Credit for most of the help text for this function go to the authors of the UWPCommunityToolkit library that this module relies upon.

Please see the [originating repo](https://github.com/Microsoft/UWPCommunityToolkit).

## RELATED LINKS

[New-BTSelectionBoxItem](https://github.com/Windos/BurntToast/blob/master/Help/New-BTSelectionBoxItem.md)

---
online version: https://github.com/Windos/BurntToast/blob/master/Help/New-BTInput.md
schema: 2.0.0
---

# New-BTInput

## SYNOPSIS
Creates an input element on a Toast notification.

## SYNTAX

### Text (Default)
```
New-BTInput -Id <String> [-Title <String>] [-PlaceholderContent <String>] [-DefaultInput <String>]
```

### Selection
```
New-BTInput -Id <String> [-Title <String>] [-DefaultSelectionBoxItemId <String>]
 -Items <ToastSelectionBoxItem[]>
```

## DESCRIPTION
The New-BTInput function creates an input element on a Toast notification.

Returned object is either a TextBox for users to type text into or SelectionBox to users to select from a list of options.

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
PS C:\>New-BTInput -Id Reply001 -Title 'Type a reply:'
```

This command creates a new text box for a user to type a reply. (n.b. this sort of functionality probably won't work through BurntToast as PowerShell cannot, currently, subscribe to WinRT events.)

### -------------------------- EXAMPLE 2 --------------------------
```
PS C:\>New-BTInput -Id 'Selection001' -DefaultSelectionBoxItemId 'Item5' -Items $Select1, $Select2, $Select3, $Select4, $Select5
```

This command creates a new selection box containing five options and specifying the ID of one of the options as the default.

## PARAMETERS

### -DefaultInput
The initial text to place in the text box. Leave this null for a blank text box.

```yaml
Type: String
Parameter Sets: Text
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -DefaultSelectionBoxItemId
This controls which item is selected by default, and refers to the Id property of a Selection Box Item (New-BTSelectionBoxItem.)

If you do not provide this, the default selection will be empty (user sees nothing).

```yaml
Type: String
Parameter Sets: Selection
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Id
Used so that developers can retrieve user input once the app is activated.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Items
The selection items that the user can pick from in this SelectionBox. Only 5 items can be added.

```yaml
Type: ToastSelectionBoxItem[]
Parameter Sets: Selection
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -PlaceholderContent
Placeholder text to be displayed on the text box when the user hasn't typed any text yet.

```yaml
Type: String
Parameter Sets: Text
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Title
Title text to display above the element

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

## INPUTS

### None

## OUTPUTS

### ToastTextBox

### ToastSelectionBox

## NOTES
Credit for most of the help text for this function go to the authors of the UWPCommunityToolkit library that this module relies upon.

Please see the originating repo here: https://github.com/Microsoft/UWPCommunityToolkit

## RELATED LINKS

[New-BTInput](https://github.com/Windos/BurntToast/blob/master/Help/New-BTInput.md)

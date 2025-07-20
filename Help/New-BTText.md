# New-BTText

## SYNOPSIS

Creates a new text element for Toast Notifications.

## DESCRIPTION

The `New-BTText` function creates an `AdaptiveText` object for Toast Notifications, used to display a line (or wrapped lines) of text.
All formatting and layout options (wrapping, lines, alignment, style, language) are customizable.

## PARAMETERS

| Name      | Type      | Description                                                                                           | Mandatory |
|-----------|-----------|-------------------------------------------------------------------------------------------------------|-----------|
| `Text`    | String    | The text to display as the content. If omitted, a blank line is produced. Aliased as 'Content'.       | No        |
| `MaxLines`| Int       | Maximum number of lines the text may display (wraps/collapses extra lines).                           | No        |
| `MinLines`| Int       | Minimum number of lines that must be shown.                                                           | No        |
| `Wrap`    | Switch    | Enable/disable word wrapping.                                                                         | No        |
| `Align`   | AdaptiveTextAlign | Property for horizontal alignment of the text.                                                | No        |
| `Style`   | AdaptiveTextStyle | Controls font size, weight, opacity for the text.                                             | No        |
| `Language`| String    | BCP-47 language tag for payload, e.g. "en-US" (overrides parent).                                     | No        |
| `Bind`    | Switch    | Indicates the text comes from a data binding expression (for advanced scenarios).                     | No        |

## INPUTS

None. You cannot pipe input to this function.

## OUTPUTS

Microsoft.Toolkit.Uwp.Notifications.AdaptiveText

## EXAMPLES

### Example 1

```powershell
New-BTText -Content 'This is a line with text!'
```

Creates a text element that will show this string in a Toast Notification.

### Example 2

```powershell
New-BTText
```

Creates a blank line in the Toast.

## LINKS

- [New-BTBinding](New-BTBinding.md)
- [New-BTColumn](New-BTColumn.md)
- [New-BTInput](New-BTInput.md)

# New-BTHeader

## SYNOPSIS

Creates a new toast notification header.

## DESCRIPTION

The `New-BTHeader` function creates a toast notification header (`ToastHeader`) for a Toast Notification. Headers are displayed at the top and used for categorization or grouping in Action Center.

## PARAMETERS

| Name            | Type                                                   | Description                                                                                        | Mandatory |
|-----------------|--------------------------------------------------------|----------------------------------------------------------------------------------------------------|-----------|
| `Id`            | String                                                 | Unique string identifying this header instance. Used for replacement or updating by reuse.          | No        |
| `Title`         | String (Mandatory)                                     | The text displayed to the user as the header.                                                      | Yes       |
| `Arguments`     | String                                                 | String data passed to Activation if the header itself is clicked.                                   | No        |
| `ActivationType`| Microsoft.Toolkit.Uwp.Notifications.ToastActivationType| Enum specifying the activation type (defaults to Protocol).                                         | No        |

## INPUTS

None. You cannot pipe input to this function.

## OUTPUTS

Microsoft.Toolkit.Uwp.Notifications.ToastHeader

## EXAMPLES

### Example 1

```powershell
New-BTHeader -Title 'First Category'
```

Creates a header titled 'First Category' for categorizing toasts.

### Example 2

```powershell
New-BTHeader -Id '001' -Title 'Stack Overflow Questions' -Arguments 'http://stackoverflow.com/'
```

Creates a header with ID '001' and links activation to a URL.

## LINKS

- [New-BTContent](New-BTContent.md)
- [New-BTVisual](New-BTVisual.md)

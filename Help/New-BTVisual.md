# New-BTVisual

## SYNOPSIS

Creates a new visual element for toast notifications.

## DESCRIPTION

The `New-BTVisual` function creates a `ToastVisual` object, defining the visual appearance and layout for a Toast Notification.
This includes the root Toast binding, optional alternate bindings, image query, base URI, and locale settings.

## PARAMETERS

| Name               | Type                                                    | Description                                                                                                         | Mandatory |
|--------------------|---------------------------------------------------------|---------------------------------------------------------------------------------------------------------------------|-----------|
| `BindingGeneric`   | ToastBindingGeneric (Mandatory)                         | ToastBindingGeneric object describing the main layout and visuals (text, images, progress bars, columns).           | Yes       |
| `BindingShoulderTap`| ToastBindingShoulderTap                                | Optional alternate Toast binding rendered on devices supporting ShoulderTap notifications.                           | No        |
| `AddImageQuery`    | Switch                                                  | Allows image URIs to include scale and language info added by Windows.                                               | No        |
| `BaseUri`          | Uri                                                     | URI to prepend to all relative image URIs in the toast.                                                             | No        |
| `Language`         | String                                                  | BCP-47 tag specifying what language/locale to use for display.                                                      | No        |

## INPUTS

None. You cannot pipe input to this function.

## OUTPUTS

Microsoft.Toolkit.Uwp.Notifications.ToastVisual

## EXAMPLES

### Example 1

```powershell
New-BTVisual -BindingGeneric $Binding1
```

Creates a Toast Visual containing the provided binding.

## LINKS

- [New-BTBinding](New-BTBinding.md)
- [New-BTContent](New-BTContent.md)
- [New-BTColumn](New-BTColumn.md)
- [New-BTHeader](New-BTHeader.md)

# Remove-BTNotification

## SYNOPSIS

Removes toast notifications from the Action Center.

## DESCRIPTION

The `Remove-BTNotification` function removes toast notifications for the current application from the Action Center.
If no parameters are specified, all toast notifications for this app are removed.
Specify `Tag` and/or `Group` to remove specific notifications. Use `UniqueIdentifier` to remove notifications matching both tag and group.

## PARAMETERS

| Name              | Type    | Description                                                                                 |
|-------------------|---------|---------------------------------------------------------------------------------------------|
| `Tag`             | String  | The tag of the toast notification(s) to remove.                                             |
| `Group`           | String  | The group (category) of the toast notification(s) to remove.                                |
| `UniqueIdentifier`| String  | Used to specify both the Tag and Group and remove a uniquely identified toast.              |

## INPUTS

None. You cannot pipe input to this function.

## OUTPUTS

None.

## EXAMPLES

### Example 1

```powershell
Remove-BTNotification
```

Removes all toast notifications for the calling application.

### Example 2

```powershell
Remove-BTNotification -Tag 'Toast001'
```

Removes the toast notification with tag 'Toast001'.

### Example 3

```powershell
Remove-BTNotification -Group 'Updates'
```

Removes all toast notifications in the group 'Updates'.

### Example 4

```powershell
Remove-BTNotification -UniqueIdentifier 'Toast001'
```

Removes the toast notification with both tag and group set to 'Toast001'.

## LINKS

- [Get-BTHistory](Get-BTHistory.md)

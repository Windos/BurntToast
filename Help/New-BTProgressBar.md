# New-BTProgressBar

## SYNOPSIS

Creates a new Progress Bar element for Toast Notifications.

## DESCRIPTION

The `New-BTProgressBar` function creates a new `AdaptiveProgressBar` element for Toast Notifications, visualizing completion via percentage or indeterminate animation.

## PARAMETERS

| Name        | Type                | Description                                                                           |
|-------------|---------------------|---------------------------------------------------------------------------------------|
| `Title`     | String              | Text displayed above the progress bar (optional context).                             |
| `Status`    | String (Mandatory)  | String describing the current operation status, shown below the bar.                  |
| `Indeterminate`| Switch           | When set, an indeterminate animation is shown (can't be used with Value).             |
| `Value`     | Double (0-1)        | The percent complete (e.g. 0.45 = 45%).                                               |
| `ValueDisplay`| String            | Replaces default percentage label with a custom one.                                  |

## INPUTS

None. You cannot pipe input to this function.

## OUTPUTS

Microsoft.Toolkit.Uwp.Notifications.AdaptiveProgressBar

## EXAMPLES

### Example 1

```powershell
New-BTProgressBar -Status 'Copying files' -Value 0.2
```

Creates a 20% full progress bar showing the status.

### Example 2

```powershell
New-BTProgressBar -Status 'Copying files' -Indeterminate
```

Progress bar with indeterminate animation.

### Example 3

```powershell
New-BTProgressBar -Status 'Copying files' -Value 0.2 -ValueDisplay '4/20 files complete'
```

Progress bar at 20%, overridden label text.

### Example 4

```powershell
New-BTProgressBar -Title 'File Copy' -Status 'Copying files' -Value 0.2
```

Displays title and status.

### Example 5

```powershell
$Progress = New-BTProgressBar -Status 'Copying files' -Value 0.2
New-BurntToastNotification -Text 'File copy script running', 'More details!' -ProgressBar $Progress
```

Toast notification includes a progress bar.

## LINKS

- [New-BTBinding](New-BTBinding.md)
- [New-BurntToastNotification](New-BurntToastNotification.md)

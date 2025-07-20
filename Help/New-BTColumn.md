# New-BTColumn

## SYNOPSIS

Creates a new column (Adaptive Subgroup) for Toast Notifications.

## DESCRIPTION

The `New-BTColumn` function creates a column (Adaptive Subgroup) for Toast Notifications.
Columns contain text and images and are provided to the `Column` parameter of `New-BTBinding` or `New-BurntToastNotification`.
Content is arranged vertically and multiple columns can be combined for side-by-side layout.

## PARAMETERS

| Name          | Type                                                                        | Description                                                                                                                             |
|---------------|-----------------------------------------------------------------------------|-----------------------------------------------------------------------------------------------------------------------------------------|
| `Children`    | Microsoft.Toolkit.Uwp.Notifications.IAdaptiveSubgroupChild[]                | Array. Elements (such as Adaptive Text or Image objects) for display in this column, created via `New-BTText` or `New-BTImage`.         |
| `Weight`      | Int                                                                         | The relative width of this column compared to others in the toast.                                                                       |
| `TextStacking`| Microsoft.Toolkit.Uwp.Notifications.AdaptiveSubgroupTextStacking            | Enum. Controls vertical alignment of the content; accepts values from `AdaptiveSubgroupTextStacking`.                                   |

## INPUTS

- int
- Microsoft.Toolkit.Uwp.Notifications.IAdaptiveSubgroupChild
- Microsoft.Toolkit.Uwp.Notifications.AdaptiveSubgroupTextStacking
- You cannot pipe input to this function.

## OUTPUTS

Microsoft.Toolkit.Uwp.Notifications.AdaptiveSubgroup

## EXAMPLES

### Example 1

```powershell
$labels = New-BTText -Text 'Title:' -Style Base
$values = New-BTText -Text 'Example' -Style BaseSubtle
$col1 = New-BTColumn -Children $labels -Weight 4
$col2 = New-BTColumn -Children $values -Weight 6
New-BTBinding -Column $col1, $col2
```

### Example 2

```powershell
$label = New-BTText -Text 'Now Playing'
$col = New-BTColumn -Children $label
New-BTBinding -Children $label -Column $col
```

## LINKS

- [New-BTText](New-BTText.md)
- [New-BTImage](New-BTImage.md)
- [New-BTBinding](New-BTBinding.md)
- [New-BurntToastNotification](New-BurntToastNotification.md)

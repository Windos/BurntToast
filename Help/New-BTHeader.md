# New-BTHeader

## SYNOPSIS

Creates a new toast notification header.

## SYNTAX

```powershell
New-BTHeader [-Id] <String> [-Title] <String> [[-Arguments] <String>] [[-ActivationType] {Foreground | Background | Protocol}]
```

## DESCRIPTION

The New-BTHeader function creates a new toast notification header for a Toast Notification.

These headers are displayed at the top of a toast and are also used to categorize toasts in the Action Center.

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------

```powershell
PS C:\>New-BTHeader -Id 'primary header' -Title 'First Category'
```

This command creates a Toast Header object, which will be displayed with the text "First Category."

### -------------------------- EXAMPLE 2 --------------------------

```powershell
PS C:\>New-BTHeader -Id '001' -Title 'Stack Overflow Questions' -Arguments 'http://stackoverflow.com/'
```

This command creates a Toast Header object, which will be displayed with the text "First Category."

Clicking the header will take the user to the Stack Overflow website.

## PARAMETERS

### -Id

Unique string that identifies a header. If a new Id is provided, the system will treat the header as a new header even if it has the same display text as a previous header.

It is possible to update a header's display text by re-using the Id but changing the title.

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

### -Title

The header string that is displayed to the user.

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

### -Arguments

Specifies an app defined string.

For the purposes of BurntToast notifications this is generally the path to a file or URI and paired with the Protocol ActivationType.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ActivationType

Defines tne ActivationType that is trigger when the button is pressed.

Defaults to Protocol which will open the file or URI specified in with the Arguments parameter in the relevant system default application.

```yaml
Type: ActivationType
Parameter Sets: (All)
Aliases:
Accepted values: Foreground, Background, Protocol

Required: False
Position: 4
Default value: Protocol
Accept pipeline input: False
Accept wildcard characters: False
```

## INPUTS

TODO

You cannot pipe input to this function.

## OUTPUTS

Microsoft.Toolkit.Uwp.Notifications.ToastHeader

## NOTES

## RELATED LINKS

[New-BTHeader](https://github.com/Windos/BurntToast/blob/main/Help/New-BTHeader.md)

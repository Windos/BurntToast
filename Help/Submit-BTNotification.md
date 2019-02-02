# Submit-BTNotification

## SYNOPSIS
Submits a completed toast notification for display.

## SYNTAX

```
Submit-BTNotification [[-Content] <ToastContent>] [[-SequenceNumber] <UInt64>] [[-UniqueIdentifier] <String>] [[-AppId] <String>]
```

## DESCRIPTION
The Submit-BTNotification function submits a completed toast notification to the operating systems' notification manager for display.

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
PS C:\>Submit-BTNotification -Content $Toast1 -UniqueIdentifier 'Toast001'
```

This command submits the complete toast content object $Toast1, from the New-BTContent function, and tags it with a unique identifier so that it can be replaced/updated.

## PARAMETERS

### -AppId
Specifies the AppId of the 'application' or process that spawned the toast notification.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: $Script:Config.AppId
Accept pipeline input: False
Accept wildcard characters: False
```

### -Content
A Toast Content object which is the Base Toast element, created using the New-BTContent function.

```yaml
Type: ToastContent
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SequenceNumber
When updating toasts (not curently working) rapidly, the sequence number helps to ensure that toasts recieved out of order will not be displayed in a manner that may confuse.

A higher sequence number indicates a newer toast.

```yaml
Type: UInt64
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -UniqueIdentifier
A string that uniquely identifies a toast notification. Submitting a new toast with the same identifier as a previous toast will replace the previous toast.

This is useful when updating the progress of a process, using a progress bar, or otherwise correcting/updating the information on a toast.

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

## INPUTS

### None

## OUTPUTS

### None

## NOTES

## RELATED LINKS

[Submit-BTNotification](https://github.com/Windos/BurntToast/blob/master/Help/Submit-BTNotification.md)

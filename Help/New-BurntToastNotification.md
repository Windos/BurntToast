---
external help file: BurntToast-help.xml
online version: https://github.com/Windos/BurntToast
schema: 2.0.0
---

# New-BurntToastNotification

## SYNOPSIS
Creates and displays a Toast Notification.

## SYNTAX

### Sound (Default)
```
New-BurntToastNotification [-Text <String[]>] [-AppLogo <String>] [-AppId <String>] [-Sound <String>]
 [-SnoozeAndDismiss]
```

### Silent
```
New-BurntToastNotification [-Text <String[]>] [-AppLogo <String>] [-AppId <String>] [-Silent]
 [-SnoozeAndDismiss]
```

## DESCRIPTION
The New-BurntToastNotification cmdlet creates and displays a Toast Notification on Microsoft Windows 8 and Windows 10 operating systems.

You can specify the text and/or image displayed as well as selecting the sound that is played when the Toast Notification is displayed.

You can optionally call the New-BurntToastNotification cmdlet with the Toast alias.

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
New-BurntToastNotification
```

This command creates and displays a Toast Notification with all default values.

### -------------------------- EXAMPLE 2 --------------------------
```
New-BurntToastNotification -Text 'Example Script', 'The example script has run successfully.'
```

This command creates and displays a Toast Notification with customized title and display text.

### -------------------------- EXAMPLE 3 --------------------------
```
New-BurntToastNotification -Text 'WAKE UP!' -Sound 'Alarm2'
```

This command creates and displays a Toast Notification which plays a looping alarm sound and lasts longer than a default Toast.

## PARAMETERS

### -AppId
\[ValidateScript({ Test-ToastAppId -Id $_ })\]

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

### -AppLogo
\[ValidateScript({ Test-ToastImage -Path $_ })\]

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

### -Silent
{{Fill Silent Description}}

```yaml
Type: SwitchParameter
Parameter Sets: Silent
Aliases: 

Required: True
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -SnoozeAndDismiss
{{Fill SnoozeAndDismiss Description}}

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Sound
{{Fill Sound Description}}

```yaml
Type: String
Parameter Sets: Sound
Aliases: 

Required: False
Position: Named
Default value: Default
Accept pipeline input: False
Accept wildcard characters: False
```

### -Text
{{Fill Text Description}}

```yaml
Type: String[]
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: Default Notification
Accept pipeline input: False
Accept wildcard characters: False
```

## INPUTS

### None

You cannot pipe input to this cmdlet.

## OUTPUTS

### None

New-BurntToastNotification displays the Toast Notification that is created.

## NOTES
Assume that you have logged into Windows as Example\User01 and have run a PowerShell host as Example\Admin01.

When you run the New-BurntToastNotification cmdlet a toast would attempt to be displayed using Admin01's notification manager but this does not exist.

In this situation you should use the Credential parameter to specify Example\User01 as the user for which notifications should be displayed.

## RELATED LINKS

[https://github.com/Windos/BurntToast](https://github.com/Windos/BurntToast)


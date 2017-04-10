---
online version: https://github.com/Windos/BurntToast/blob/master/Help/New-BTAppId.md
schema: 2.0.0
---

# New-BTAction

## SYNOPSIS
Creates a new AppId Registry Key.

## SYNTAX

```
New-BTAppId [[-AppId] <String>]
```

## DESCRIPTION
The New-BTAppId function create a new AppId registry key in the Current User's Registery Hive. If the desired AppId is already present in the Registry then no changes are made.

If no AppId is specified then the AppId specified in the config.json file in the BurntToast module's root directory is used.


## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
PS C:\>New-BTAppId
```

This command creates an AppId registry key using the value specified in the BurntToast module's config.json file, which is 'BurntToast' by default.

### -------------------------- EXAMPLE 2 --------------------------
```
PS C:\>New-BTAppId -AppId 'Script Checker'
```

This command create an AppId registry key called 'Script Checker.'

## PARAMETERS

### -AppId
Specifies the new AppId. You can use any alphanumeric characters.

Defaults to the AppId specified in the config.json file in the BurntToast module's root directoy if not provided.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: $Script:Config.AppId
Accept pipeline input: False
Accept wildcard characters: False
```

## INPUTS

### None
You cannot pipe input to this function.

## OUTPUTS

### None

## NOTES

## RELATED LINKS

[New-BTAction](https://github.com/Windos/BurntToast/blob/master/Help/New-BTAppId.md)

# Set-BTFunctionLevel

## SYNOPSIS

Changes the function level of the BurntToast module.

## SYNTAX

```
Set-BTFunctionLevel [[-FunctionLevel] <String>]
```

## DESCRIPTION
The Set-BTFunctionLevel function changes the function level of the BurntToast module as defined in config.json.

To use Set-BTFunctionLevel, use the FunctionLevel parameter to identify the desired FunctionLevel. The only valid inputs to the FunctionLevel parameter are 'Basic' and 'Advanced.'

As the confirguration for the BurntToast module is saved into a file, PowerShell must be run as an Administrator in order to set a new function level if the module is saved to a location other than the users' home directory. This function will issue an error if this is the case.

The BurntToast module needs to be re-imported in order for a new function level to take effect and this function will issue a warning when it runs successfully.

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
PS C:\> Set-BTFunctionLevel
```

This command changes the function level of the BurntToast module to 'Basic', as the default option, if the current function level is 'Advanced.' If the current function level is already set to 'Basic' the function ends without making a change.

### -------------------------- EXAMPLE 2 --------------------------
```
PS C:\> Set-BTFunctionLevel -FunctionLevel Basic
```

This command changes the function level of the BurntToast module to 'Basic' if the current function level is 'Advanced.' If the current function level is already set to 'Basic' the function ends without making a change.

### -------------------------- EXAMPLE 3 --------------------------
```
PS C:\> Set-BTFunctionLevel -FunctionLevel Advanced
```

This command changes the function level of the BurntToast module to 'Advanced' if the current function level is 'Basic.' If the current function level is already set to 'Advanced' the function ends without making a change.

## PARAMETERS

### -FunctionLevel
Specifies the function level to set. Valid inputs are 'Basic' and 'Advanced' and 'Basic' is the default option.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: False
Position: 1
Default value: Basic
Accept pipeline input: False
Accept wildcard characters: False
```

## INPUTS

### None

You cannot pipe input to this cmdlet.

## OUTPUTS

### System.String

## NOTES

The Set-BTFunctionLevel function is classified as: Basic

## RELATED LINKS

[Get-BTFunctionLevel](https://github.com/Windos/BurntToast/blob/master/Help/Get-BTFunctionLevel.md)

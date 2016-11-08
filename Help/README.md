---
Module Name: BurntToast
Module Guid: 751a2aeb-a68f-422e-a2ea-376bdd81612a
Download Help Link: http://pshelpcontent.king.geek.nz/
Help Version: 1.0.0.2
Locale: en-US
---

# BurntToast Module
## Description
{{Manually Enter Description Here}}

## BurntToast Cmdlets
### [Get-BTFunctionLevel](Get-BTFunctionLevel.md)
The Get-BTFunctionLevel function returns the current function level of the BurntToast module as defined in config.json.

### [New-BTAction](New-BTAction.md)
{{Manually Enter New-BTAction Description Here}}

### [New-BTAudio](New-BTAudio.md)
{{Manually Enter New-BTAudio Description Here}}

### [New-BTBinding](New-BTBinding.md)
{{Manually Enter New-BTBinding Description Here}}

### [New-BTButton](New-BTButton.md)
{{Manually Enter New-BTButton Description Here}}

### [New-BTContent](New-BTContent.md)
{{Manually Enter New-BTContent Description Here}}

### [New-BTContextMenuItem](New-BTContextMenuItem.md)
{{Manually Enter New-BTContextMenuItem Description Here}}

### [New-BTImage](New-BTImage.md)
{{Manually Enter New-BTImage Description Here}}

### [New-BTInput](New-BTInput.md)
{{Manually Enter New-BTInput Description Here}}

### [New-BTSelectionBoxItem](New-BTSelectionBoxItem.md)
{{Manually Enter New-BTSelectionBoxItem Description Here}}

### [New-BTText](New-BTText.md)
{{Manually Enter New-BTText Description Here}}

### [New-BTVisual](New-BTVisual.md)
{{Manually Enter New-BTVisual Description Here}}

### [New-BurntToastNotification](New-BurntToastNotification.md)
{{Manually Enter New-BurntToastNotification Description Here}}

### [Set-BTFunctionLevel](Set-BTFunctionLevel.md)
The Set-BTFunctionLevel function changes the function level of the BurntToast module as defined in config.json.

To use Set-BTFunctionLevel, use the FunctionLevel parameter to identify the desired FunctionLevel. The only valid inputs to the FunctionLevel parameter are 'Basic' and 'Advanced.'

As the confirguration for the BurntToast module is saved into a file, PowerShell must be run as an Administrator in order to set a new function level if the module is saved to a location other than the users' home directory. This function will issue an error if this is the case.

The BurntToast module needs to be re-imported in order for a new function level to take effect and this function will issue a warning when it runs successfully.

### [Submit-BTNotification](Submit-BTNotification.md)
{{Manually Enter Submit-BTNotification Description Here}}

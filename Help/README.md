# BurntToast Help
## Checklist
- [X] New-BTAction
    - [X] Comment based help
    - [X] Markdown file
    - [X] Content/Index Entry
- [X] New-BTAppId
    - [X] Comment based help
    - [X] Markdown file
    - [X] Content/Index Entry
- [ ] New-BTAudio
    - [ ] Comment based help
    - [ ] Markdown file
    - [ ] Content/Index Entry
- [ ] New-BTBinding
    - [ ] Comment based help
    - [ ] Markdown file
    - [ ] Content/Index Entry
- [ ] New-BTButton
    - [ ] Comment based help
    - [ ] Markdown file
    - [ ] Content/Index Entry
- [ ] New-BTContent
    - [ ] Comment based help
    - [ ] Markdown file
    - [ ] Content/Index Entry
- [ ] New-BTContextMenuItem
    - [ ] Comment based help
    - [ ] Markdown file
    - [ ] Content/Index Entry
- [ ] New-BTImage
    - [ ] Comment based help
    - [ ] Markdown file
    - [ ] Content/Index Entry
- [ ] New-BTInput
    - [ ] Comment based help
    - [ ] Markdown file
    - [ ] Content/Index Entry
- [ ] New-BTSelectionBoxItem
    - [ ] Comment based help
    - [ ] Markdown file
    - [ ] Content/Index Entry
- [ ] New-BTText
    - [ ] Comment based help
    - [ ] Markdown file
    - [ ] Content/Index Entry
- [ ] New-BTVisual
    - [ ] Comment based help
    - [ ] Markdown file
    - [ ] Content/Index Entry
- [X] New-BurntToastNotification
    - [X] Comment based help
    - [X] Markdown file
    - [X] Content/Index Entry
- [ ] Submit-BTNotification
    - [ ] Comment based help
    - [ ] Markdown file
    - [ ] Content/Index Entry

## Description
{{Manually Enter Description Here}}

## BurntToast Cmdlets
### [New-BTAction](New-BTAction.md)
The New-BTAction function creates an 'action' object which contains defines the controls displayed at the bottom of a Toast Notification.

Actions can either be system handeled and automatically localized Snooze and Dismiss buttons or a custom collection of inputs.

### [New-BTAppId](New-BTAppId.md)
The New-BTAppId function create a new AppId registry key in the Current User's Registery Hive. If the desired AppId is already present in the Registry then no changes are made.

If no AppId is specified then the AppId specified in the config.json file in the BurntToast module's root directory is used.

### [New-BurntToastNotification](New-BurntToastNotification.md)
The New-BurntToastNotification cmdlet creates and displays a Toast Notification on Microsoft Windows 10.

You can specify the text and/or image displayed as well as selecting the sound that is played when the Toast Notification is displayed.

You can optionally call the New-BurntToastNotification cmdlet with the Toast alias.

### [New-BTFunction](New-BTFunction.md)
{{Manually Enter New-BTAction Description Here}}

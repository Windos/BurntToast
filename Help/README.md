# BurntToast Help

## Description
Module for creating and displaying Toast Notifications on Microsoft Windows 10.

## BurntToast Functions
### [New-BTAction](New-BTAction.md)
The New-BTAction function creates an 'action' object which contains defines the controls displayed at the bottom of a Toast Notification.

Actions can either be system handeled and automatically localized Snooze and Dismiss buttons or a custom collection of inputs.

### [New-BTAppId](New-BTAppId.md)
The New-BTAppId function create a new AppId registry key in the Current User's Registery Hive. If the desired AppId is already present in the Registry then no changes are made.

If no AppId is specified then the AppId specified in the config.json file in the BurntToast module's root directory is used.

### [New-BTAudio](New-BTAudio.md)
The New-BTAudioElement function creates a new Audio Element for Toast Notifications.

You can use the parameters of New-BTAudioElement to select an audio file or a standard notification sound (including alarms). Alternativly you can specify that a Toast Notification should be silent.

### [New-BTBinding](New-BTBinding.md)
The New-BTBinding function creates a new Generic Toast Binding, where you provide text, images, and other visual elements for your Toast notification.

### [New-BTButton](New-BTButton.md)
The New-BTButton function creates a new clickable button for a Toast Notification. Up to five buttons can be added to one Toast.

Buttons can be fully customized with display text, images and arguments or system handled 'Snooze' and 'Dismiss' buttons.

### [New-BTContent](New-BTContent.md)
The New-BTContent function creates a new Toast Content object which is the Base Toast element, which contains at least a visual element.

### [New-BTContextMenuItem](New-BTContextMenuItem.md)
The New-BTContextMenuItem function creates a Context Menu Item object.

### [New-BTHeader](New-BTHeader.md)
The New-BTHeader function creates a new toast notification header for a Toast Notification.

These headers are diaplyed at the top of a toast and are also used to categorize toasts in the Action Center.

### [New-BTImage](New-BTImage.md)
The New-BTImageElement function creates a new Image Element for Toast Notifications.

You can use the parameters of New-BTImageElement to specify the source image, alt text, placement on the Toast Notification and crop shape.

### [New-BTInput](New-BTInput.md)
The New-BTInput function creates an input element on a Toast notification.

Returned object is either a TextBox for users to type text into or SelectionBox to users to select from a list of options.

### [New-BTProgressBar](New-BTProgressBar.md)
The New-BTProgressBar function creates a new Progress Bar Element for Toast Notifications.

You must specify the status and value for the progress bar and can optionally give the bar a title and override the automatic text representiation of the progress.

### [New-BTSelectionBoxItem](New-BTSelectionBoxItem.md)
The New-BTSelectionBoxItem function creates a selection box item, for inclusion in a selection box created with New-BTInput.

### [New-BTText](New-BTText.md)
The New-BTTextElement function creates a new Text Element for Toast Notifications.

You can specify the text you want displayed in a Toast Notification as a string, or run the function without a paramter for a blank line.

Each Text Element is the equivalent of one line in on a Toast Notification, long lines will wrap.

### [New-BTVisual](New-BTVisual.md)
The New-BTVisual function creates a new visual element for toast notifications, which defines all of the visual aspects of a toast.

### [New-BurntToastNotification](New-BurntToastNotification.md)
The New-BurntToastNotification function creates and displays a Toast Notification on Microsoft Windows 10.

You can specify the text and/or image displayed as well as selecting the sound that is played when the Toast Notification is displayed.

You can optionally call the New-BurntToastNotification function with the Toast alias.

### [Submit-BTNotification](Submit-BTNotification.md)
The Submit-BTNotification function submits a completed toast notification to the operating systems' notification manager for display.

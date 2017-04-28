---
online version: https://github.com/Windos/BurntToast/blob/master/Help/New-BTContent.md
schema: 2.0.0
---

# New-BTContent

## SYNOPSIS
Creates a new Toast Content object.

## SYNTAX

```
New-BTContent [[-Actions] <IToastActions>] [[-ActivationType] <ToastActivationType>] [[-Audio] <ToastAudio>]
 [[-Duration] <ToastDuration>] [[-Launch] <String>] [[-Scenario] <ToastScenario>] [-Visual] <ToastVisual>
```

## DESCRIPTION
The New-BTContent function creates a new Toast Content object which is the Base Toast element, which contains at least a visual element.

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
PS C:\>$binding1 = New-BTBinding -Children $text1, $text2 -AppLogoOverride $image2
PS C:\>$visual1 = New-BTVisual -BindingGeneric $binding1
PS C:\>$content1 = New-BTContent -Visual $visual1
```

This example combines numerous objects created via BurntToast functions into a binding, then a visual element and finally into a content object.

The resultant object can now be displayed using the Submit-BTNotification function.

### -------------------------- EXAMPLE 2 --------------------------
```
PS C:\>$content1 = New-BTContent -Visual $visual1 -ActivationType Protocol -Launch 'https://google.com'
```

This command takes a pre-existing visual object and also specifies options required to launch a browser on the Google homepage when clicking the toast.

## PARAMETERS

### -Actions
Optionally create custom actions with buttons and inputs (New-BTAction.)

```yaml
Type: IToastActions
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ActivationType
Specifies what activation type will be used when the user clicks the body of this Toast.

```yaml
Type: ToastActivationType
Parameter Sets: (All)
Aliases:
Accepted values: Foreground, Background, Protocol

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Audio
Specify custom audio options (New-BTAudio.)

```yaml
Type: ToastAudio
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Duration
The amount of time the Toast should display. You typically should use the Scenario attribute instead, which impacts how long a Toast stays on screen.

```yaml
Type: ToastDuration
Parameter Sets: (All)
Aliases:
Accepted values: Short, Long

Required: False
Position: 4
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Header
New in Creators Update: Specifies an optional header for the toast notification (New-BTHeader.)

```yaml
Type: ToastHeader
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Launch
A string that is passed to the application when it is activated by the Toast. The format and contents of this string are defined by the app for its own use. When the user taps or clicks the Toast to launch its associated app, the launch string provides the context to the app that allows it to show the user a view relevant to the Toast content, rather than launching in its default way.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 6
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Scenario
Specify the scenario, to make the Toast behave like an alarm, reminder, or more.

```yaml
Type: ToastScenario
Parameter Sets: (All)
Aliases:
Accepted values: Default, Alarm, Reminder, IncomingCall

Required: False
Position: 7
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Visual
Specify the visual element object, created with the New-BTVisual function.

```yaml
Type: ToastVisual
Parameter Sets: (All)
Aliases:

Required: True
Position: 8
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

## INPUTS

### None

## OUTPUTS

### ToastContent

## NOTES
Credit for most of the help text for this function go to the authors of the UWPCommunityToolkit library that this module relies upon.

Please see the originating repo here: https://github.com/Microsoft/UWPCommunityToolkit

## RELATED LINKS

[New-BTContent](https://github.com/Windos/BurntToast/blob/master/Help/New-BTContent.md)

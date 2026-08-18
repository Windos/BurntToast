function New-BTAudio {
    <#
        .SYNOPSIS
        Creates a new Audio object for Toast Notifications.

        .DESCRIPTION
        The New-BTAudio function creates an audio object for Toast Notifications.
        You can use this function to select a built-in Microsoft notification sound (including alarms and calls) or indicate that the notification should be silent. Custom audio file paths are not supported in BurntToast 1.0.0 and later.

        .PARAMETER Source
        URI string. Specifies a supported Microsoft notification sound URI, such as ms-winsoundevent:Notification.IM.
        Custom audio file paths are not supported.

        .PARAMETER Loop
        Switch. Specifies that the selected sound should loop, if its duration is shorter than the toast it accompanies.

        .PARAMETER Silent
        Switch. Makes the toast silent (no sound).

        .INPUTS
        None. You cannot pipe input to this function.

        .OUTPUTS
        Microsoft.Toolkit.Uwp.Notifications.ToastAudio

        .EXAMPLE
        New-BTAudio -Source ms-winsoundevent:Notification.SMS
        Creates an audio object which will cause a Toast Notification to play the standard Microsoft 'SMS' sound.

        .EXAMPLE
        New-BTAudio -Source ms-winsoundevent:Notification.Looping.Alarm2 -Loop
        Creates an audio object for the built-in Alarm2 sound with looping enabled.

        .EXAMPLE
        New-BTAudio -Silent
        Creates an audio object which will cause a Toast Notification to be silent.

        .LINK
        https://github.com/Windos/BurntToast/blob/main/Help/New-BTAudio.md
    #>

    [CmdletBinding(DefaultParameterSetName = 'StandardSound',
                   SupportsShouldProcess   = $true,
                   HelpUri = 'https://github.com/Windos/BurntToast/blob/main/Help/New-BTAudio.md')]
    [OutputType([Microsoft.Toolkit.Uwp.Notifications.ToastAudio])]
    param (
        [Parameter(Mandatory,
                   ParameterSetName = 'StandardSound')]
        [ValidateSet('ms-winsoundevent:Notification.Default',
                     'ms-winsoundevent:Notification.IM',
                     'ms-winsoundevent:Notification.Mail',
                     'ms-winsoundevent:Notification.Reminder',
                     'ms-winsoundevent:Notification.SMS',
                     'ms-winsoundevent:Notification.Looping.Alarm',
                     'ms-winsoundevent:Notification.Looping.Alarm2',
                     'ms-winsoundevent:Notification.Looping.Alarm3',
                     'ms-winsoundevent:Notification.Looping.Alarm4',
                     'ms-winsoundevent:Notification.Looping.Alarm5',
                     'ms-winsoundevent:Notification.Looping.Alarm6',
                     'ms-winsoundevent:Notification.Looping.Alarm7',
                     'ms-winsoundevent:Notification.Looping.Alarm8',
                     'ms-winsoundevent:Notification.Looping.Alarm9',
                     'ms-winsoundevent:Notification.Looping.Alarm10',
                     'ms-winsoundevent:Notification.Looping.Call',
                     'ms-winsoundevent:Notification.Looping.Call2',
                     'ms-winsoundevent:Notification.Looping.Call3',
                     'ms-winsoundevent:Notification.Looping.Call4',
                     'ms-winsoundevent:Notification.Looping.Call5',
                     'ms-winsoundevent:Notification.Looping.Call6',
                     'ms-winsoundevent:Notification.Looping.Call7',
                     'ms-winsoundevent:Notification.Looping.Call8',
                     'ms-winsoundevent:Notification.Looping.Call9',
                     'ms-winsoundevent:Notification.Looping.Call10')]
        [uri] $Source,

        [Parameter(ParameterSetName = 'StandardSound')]
        [switch] $Loop,

        [Parameter(Mandatory,
                   ParameterSetName = 'Silent')]
        [switch] $Silent
    )

    $Audio = [Microsoft.Toolkit.Uwp.Notifications.ToastAudio]::new()

    if ($Source) {
        $Audio.Src = $Source
    }

    $Audio.Loop = $Loop
    $Audio.Silent = $Silent

    if($PSCmdlet.ShouldProcess("returning: [$($Audio.GetType().Name)]:Src=$($Audio.Src):Loop=$($Audio.Loop):Silent=$($Audio.Silent)")) {
        $Audio
    }
}

function New-BTAudio {
    <#
        .SYNOPSIS
        Creates a new Audio Element for Toast Notifications.

        .DESCRIPTION
        The New-BTAudioElement function creates a new Audio Element for Toast Notifications.

        You can use the parameters of New-BTAudioElement to select an audio file or a standard notification sound (including alarms). Alternativly you can specify that a Toast Notification should be silent.

        .INPUTS
        None

        You cannot pipe input to this cmdlet.

        .OUTPUTS
        Microsoft.Toolkit.Uwp.Notifications.ToastAudio

        .EXAMPLE
        New-BTAudioElement -Source SMS

        Creates an Audio Element which will cause a Toast Notification to play the standard Microsoft 'SMS' sound.

        .EXAMPLE
        New-BTAudioElement -Path 'C:\Music\FavSong.mp3'

        Creates an Audio Element which will cause a Toast Notification to play the specified song.

        .EXAMPLE
        New-BTAudioElement -Silent

        Creates an Audio Element which will cause a Toast Notification to be silent.

        .LINK
        https://github.com/Windos/BurntToast/blob/master/Help/New-BTAudio.md
    #>

    [CmdletBinding(DefaultParameterSetName = 'StandardSound')]
    [OutputType([Microsoft.Toolkit.Uwp.Notifications.ToastAudio])]
    param (
        # Specifies one of the built in Microsoft notification sounds.
        #
        # This paramater takes the full form of the sounds, in the form of a uri. The New-BurntToastNotification function simplifies this, so be aware of the difference.
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

        # The full path to an audio file. Supported file types include:
        #
        # *.aac
        # *.flac
        # *.m4a
        # *.mp3
        # *.wav
        # *.wma
        [Parameter(Mandatory,
                   ParameterSetName = 'CustomSound')]
        [ValidateScript({Test-BTAudioPath $_})]
        [string] $Path,

        # Specifies that the slected sound should play multiple times if its duration is shorter than that of the toast it accompanies.
        [Parameter(ParameterSetName = 'CustomSound')]
        [Parameter(ParameterSetName = 'StandardSound')]
        [switch] $Loop,

        # Specifies that the toast should be displayed without sound.
        [Parameter(Mandatory,
                   ParameterSetName = 'Silent')]
        [switch] $Silent
    )

    $Audio = [Microsoft.Toolkit.Uwp.Notifications.ToastAudio]::new()

    if ($Source) {
        $Audio.Src = $Source
    }

    if ($Path) {
        $Audio.Src = $Path
    }

    $Audio.Loop = $Loop
    $Audio.Silent = $Silent

    $Audio
}

using namespace Microsoft.Toolkit.Uwp.Notifications

function New-BTAudio
{
    <#
        .SYNOPSIS
        Creates a new Audio Element for Toast Notifications.

        .DESCRIPTION
        The New-BTAudioElement cmdlet creates a new Audio Element for Toast Notifications.
    
        You can use the parameters of New-BTAudioElement to select an audio file or a standard notification sound (including alarms). Alternativly you can specify that a Toast Notification should be silent.

        .INPUTS
        None

        You cannot pipe input to this cmdlet.

        .OUTPUTS
        Audio
        
        .EXAMPLE
        New-BTAudioElement -Source SMS

        Creates an Audio Element which will cause a Toast Notification to play the standard Microsoft 'SMS' sound.

        .EXAMPLE
        New-BTAudioElement -Path 'C:\Music\FavSong.mp3'

        Creates an Audio Element which will cause a Toast Notification to play the specified song.

        .EXAMPLE
        New-BTAudioElement -Silent

        Creates an Audio Element which will cause a Toast Notification to be silent.

        .PARAMETER Path
        The full path to an audio file. Supported file types include:

        *.aac
        *.flac
        *.m4a
        *.mp3
        *.wav
        *.wma

        .LINK
        https://github.com/Windos/BurntToast
    #>

    [CmdletBinding()]
    [OutputType([ToastAudio])]
    param
    (
        [Parameter()]
        [uri] $Source,

        [Parameter()]
        [switch] $Loop,

        [Parameter()]
        [switch] $Silent
    )

    #TODO: Add ability to select 'ms-winsoundevent:Notification' sounds

    $Audio = [ToastAudio]::new()
    
    if ($Source)
    {
        $Audio.Src = $Source
    }

    $Audio.Loop = $Loop
    $Audio.Silent = $Silent

    $Audio
}

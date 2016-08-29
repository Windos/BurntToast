function New-BTAudioElement
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

    [CmdletBinding(DefaultParameterSetName = 'BuiltIn')]
    [OutputType([Audio])]
    param
    (
        [Parameter(ParameterSetName = 'BuiltIn')]
        [alias('Sound')]
        [AudioSource] $Source = 'Default',

        [Parameter(ParameterSetName = 'Custom')]
        [ValidateScript({Test-BTAudioPath -Path $_})]
        [String] $Path,

        [Parameter(Mandatory,
                   ParameterSetName = 'Silent')]
        [Switch] $Silent
    )

    if ($Silent)
    {
        [Audio]::new($true)
    }
    else
    {
        if ($Path)
        {
            [Audio]::new($Path)
        }
        else
        {
            [Audio]::new($Source)
        }
    }
}

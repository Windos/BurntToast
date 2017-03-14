function New-BurntToastNotification
{
    <#
        .SYNOPSIS
        Creates and displays a Toast Notification.
        
        .DESCRIPTION
        The New-BurntToastNotification cmdlet creates and displays a Toast Notification on Microsoft Windows 10.

        You can specify the text and/or image displayed as well as selecting the sound that is played when the Toast Notification is displayed.

        You can optionally call the New-BurntToastNotification cmdlet with the Toast alias.
        
        .INPUTS
        None
            You cannot pipe input to this cmdlet.

        .OUTPUTS
        None
            New-BurntToastNotification displays the Toast Notification that is created.
        
        .EXAMPLE
        New-BurntToastNotification
        
        This command creates and displays a Toast Notification with all default values.
        
        .EXAMPLE
        New-BurntToastNotification -Text 'Example Script', 'The example script has run successfully.'
        
        This command creates and displays a Toast Notification with customized title and display text.

        .EXAMPLE
        New-BurntToastNotification -Text 'WAKE UP!' -Sound 'Alarm2'

        This command creates and displays a Toast Notification which plays a looping alarm sound and lasts longer than a default Toast.

        .EXAMPLE
        $BlogButton = New-BTButton -Content 'Open Blog' -Arguments 'http://king.geek.nz'
        New-BurntToastNotification -Text 'New Blog Post!' -Button $BlogButton

        This exmaple creates a Toast Notification with a button which will open a link to "http://king.geek.nz" when clicked.
        
        .NOTES
        I'm *really* sorry about the number of Parameter Sets. The best explanation is:

        * You cannot specify a sound and mark the toast as silent at the same time.
        * You cannot specify SnoozeAndDismiss and custom buttons at the same time.

        .LINK
        https://github.com/Windos/BurntToast/blob/master/Help/New-BurntToastNotification.md
    #>

    [alias('Toast')]
    [CmdletBinding(DefaultParameterSetName = 'Sound')]
    param
    (
        # Specifies the text to show on the Toast Notification. Up to three strings can be displayed, the first of which will be embolden as a title.
        [ValidateCount(0,3)]
        [String[]] $Text = 'Default Notification',

        #TODO: [ValidateScript({ Test-ToastImage -Path $_ })]
        
        # Specifies the path to an image that will override the default image displayed with a Toast Notification.
        [String] $AppLogo,

        #TODO: [ValidateScript({ Test-ToastAppId -Id $_ })]
        
        # Specifies a string that identifies the source of the Toast Notification. Different AppIds allow different types of Toasts to be grouped in the Action Centre.
        [String] $AppId = $Script:Config.AppId,

        # Selects the sound to acompany the Toast Notification. Any 'Alarm' or 'Call' tones will automatically loop and extent the amount of time that a Toast is displayed on screen.
        #
        # Cannot be used in conjunction with the 'Silent' switch.
        [Parameter(ParameterSetName = 'Sound')]
        [Parameter(Mandatory = $true,
                   ParameterSetName = 'Sound-SnD')]
        [Parameter(Mandatory = $true,
                   ParameterSetName = 'Sound-Button')]
        [ValidateSet('Default',
                     'IM',
                     'Mail',
                     'Reminder',
                     'SMS',
                     'Alarm',
                     'Alarm2',
                     'Alarm3',
                     'Alarm4',
                     'Alarm5',
                     'Alarm6',
                     'Alarm7',
                     'Alarm8',
                     'Alarm9',
                     'Alarm10',
                     'Call',
                     'Call2',
                     'Call3',
                     'Call4',
                     'Call5',
                     'Call6',
                     'Call7',
                     'Call8',
                     'Call9',
                     'Call10')]
        [String] $Sound = 'Default',

        # Indicates that the Toast Notification will be displayed on screen without an accompanying sound.
        #
        # Cannot be used in conjunction with the 'Sound' parameter.
        [Parameter(Mandatory = $true,
                   ParameterSetName = 'Silent')]
        [Parameter(Mandatory = $true,
                   ParameterSetName = 'Silent-SnD')]
        [Parameter(Mandatory = $true,
                   ParameterSetName = 'Silent-Button')]
        [Switch] $Silent,

        # Adds a default selection box and snooze/dismiss buttons to the bottom of the Toast Notification.
        [Parameter(Mandatory = $true,
                   ParameterSetName = 'SnD')]
        [Parameter(Mandatory = $true,
                   ParameterSetName = 'Silent-SnD')]
        [Parameter(Mandatory = $true,
                   ParameterSetName = 'Sound-SnD')]
        [Switch] $SnoozeAndDismiss,
        
        # Allows up to five buttons to be added to the bottom of the Toast Notification. These buttons should be created using the New-BTButton function.
        [Parameter(Mandatory = $true,
                   ParameterSetName = 'Button')]
        [Parameter(Mandatory = $true,
                   ParameterSetName = 'Silent-Button')]
        [Parameter(Mandatory = $true,
                   ParameterSetName = 'Sound-Button')]
        [Microsoft.Toolkit.Uwp.Notifications.IToastButton[]] $Button
    )
    
    $TextObjects = @()

    foreach ($Txt in $Text)
    {
        $TextObjects += New-BTText -Text $Txt
    }

    if ($AppLogo)
    {
        $AppLogoImage = New-BTImage -Source $AppLogo -AppLogoOverride -Crop Circle
    }
    else
    {
        $AppLogoImage = New-BTImage -AppLogoOverride -Crop Circle
    }

    if ($Silent)
    {
        $Audio = New-BTAudio -Silent
    }
    else
    {
        if ($Sound -ne 'Default')
        {     
            if ($Sound -like 'Alarm*' -or $Sound -like 'Call*')
            {
                $Audio = New-BTAudio -Source "ms-winsoundevent:Notification.Looping.$Sound" -Loop
                $Long = $True
            }
            else
            {
                $Audio = New-BTAudio -Source "ms-winsoundevent:Notification.$Sound" -Loop
            }
        }
    }

    $Binding = New-BTBinding -Children $TextObjects -AppLogoOverride $AppLogoImage
    $Visual = New-BTVisual -BindingGeneric $Binding

    $ContentSplat = @{'Audio' = $Audio
                      'Visual' = $Visual
    }
    
    if ($Long)
    {
        $ContentSplat.Add('Duration', [Microsoft.Toolkit.Uwp.Notifications.ToastDuration]::Long)
    }
    
    if ($SnoozeAndDismiss)
    {
        $ContentSplat.Add('Actions', (New-BTAction -SnoozeAndDismiss))
    }
    elseif ($Button)
    {
        $ContentSplat.Add('Actions', (New-BTAction -Buttons $Button))
    }
    
    $Content = New-BTContent @ContentSplat

    Submit-BTNotification -Content $Content -AppId $AppId
}

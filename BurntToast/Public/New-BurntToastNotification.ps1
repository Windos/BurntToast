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
        System.String

        You cannot pipe input to this cmdlet.

        .OUTPUTS
        None

        New-BurntToastNotification displays the Toast Notification that is created.
        
        .NOTES
        The New-BurntToastNotification function is classified as: Basic
        
        .EXAMPLE
        New-BurntToastNotification
        
        This command creates and displays a Toast Notification with all default values.
        
        .EXAMPLE
        New-BurntToastNotification -Text 'Example Script', 'The example script has run successfully.'
        
        This command creates and displays a Toast Notification with customized title and display text.

        .EXAMPLE
        New-BurntToastNotification -Text 'WAKE UP!' -Sound 'Alarm2'

        This command creates and displays a Toast Notification which plays a looping alarm sound and lasts longer than a default Toast.
        
        .LINK
        https://github.com/Windos/BurntToast/blob/master/Help/New-BurntToastNotification.md
    #>

    [alias('Toast')]
    [CmdletBinding(DefaultParameterSetName = 'Sound')]
    param
    (
        [ValidateCount(0,3)]
        [String[]] $Text = 'Default Notification',

        #TODO: [ValidateScript({ Test-ToastImage -Path $_ })]
        [String] $AppLogo,

        #TODO: [ValidateScript({ Test-ToastAppId -Id $_ })]
        [String] $AppId = $Script:Config.AppId,

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

        [Parameter(Mandatory = $true,
                   ParameterSetName = 'Silent')]
        [Parameter(Mandatory = $true,
                   ParameterSetName = 'Silent-SnD')]
        [Parameter(Mandatory = $true,
                   ParameterSetName = 'Silent-Button')]
        [Switch] $Silent,

        [Parameter(Mandatory = $true,
                   ParameterSetName = 'SnD')]
        [Parameter(Mandatory = $true,
                   ParameterSetName = 'Silent-SnD')]
        [Parameter(Mandatory = $true,
                   ParameterSetName = 'Sound-SnD')]
        [Switch] $SnoozeAndDismiss,
        
        [Parameter(Mandatory = $true,
                   ParameterSetName = 'Button')]
        [Parameter(Mandatory = $true,
                   ParameterSetName = 'Silent-Button')]
        [Parameter(Mandatory = $true,
                   ParameterSetName = 'Sound-Button')]
        [Microsoft.Toolkit.Uwp.Notifications.ToastButton[]] $Button
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

    if ($SnoozeAndDismiss)
    {
        $SnoozeAction = New-BTAction -SnoozeAndDismiss

        if ($Long)
        {
            $Content = New-BTContent -Audio $Audio -Visual $Visual -Actions $SnoozeAction -Duration Long
        }
        else
        {
            $Content = New-BTContent -Audio $Audio -Visual $Visual -Actions $SnoozeAction
        }
    }
    elseif ($Button)
    {
        $ToastActions = New-BTAction -Buttons $Button
        
        if ($Long)
        {
            $Content = New-BTContent -Audio $Audio -Visual $Visual -Actions $ToastActions -Duration Long
        }
        else
        {
            $Content = New-BTContent -Audio $Audio -Visual $Visual -Actions $ToastActions
        }
    }
    else
    {
        if ($Long)
        {
            $Content = New-BTContent -Audio $Audio -Visual $Visual -Duration Long
        }
        else
        {
            $Content = New-BTContent -Audio $Audio -Visual $Visual
        }
    }

    Submit-BTNotification -Content $Content -AppId $AppId
}

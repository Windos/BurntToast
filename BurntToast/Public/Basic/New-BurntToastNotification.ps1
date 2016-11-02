function New-BurntToastNotification
{
    <#
        .SYNOPSIS
        Creates and displays a Toast Notification.
        
        .DESCRIPTION
        The New-BurntToastNotification cmdlet creates and displays a Toast Notification on Microsoft Windows 8 and Windows 10 operating systems.

        You can specify the text and/or image displayed as well as selecting the sound that is played when the Toast Notification is displayed.

        You can optionally call the New-BurntToastNotification cmdlet with the Toast alias.
        
        .INPUTS
        None

        You cannot pipe input to this cmdlet.

        .OUTPUTS
        None

        New-BurntToastNotification displays the Toast Notification that is created.
        
        .NOTES

        Assume that you have logged into Windows as Example\User01 and have run a PowerShell host as Example\Admin01.

        When you run the New-BurntToastNotification cmdlet a toast would attempt to be displayed using Admin01's notification manager but this does not exist.

        In this situation you should use the Credential parameter to specify Example\User01 as the user for which notifications should be displayed.
        
        .EXAMPLE
        New-BurntToastNotification
        
        This command creates and displays a Toast Notification with all default values.
        
        .EXAMPLE
        New-BurntToastNotification -FirstLine 'Example Script' -SecondLine 'The example script has run successfully.'
        
        This command creates and displays a Toast Notification with customized title and display text, but with the default image.

        .EXAMPLE
        New-BurntToastNotification -Template 'ToastText01' -FirstLine 'The example script has run successfully. This toast has no title.'

        This command creates and displays a Toast Notification using an imageless template and no embolden title.

        .EXAMPLE
        New-BurntToastNotification -FirstLine 'WAKE UP!' -Sound 'Alarm2'

        This command creates and displays a Toast Notification which plays a looping alarm sound and lasts longer than a default Toast.

        .EXAMPLE
        $cred = Get-Credential
        PS C:\>New-BurntToastNotification -FirstLine 'Admin Example Script' -SecondLine 'The administrative example script has run successfully.' -Credential $cred

        This example prompts for a username and password and supplies the resulting object to the New-BurntToastNotification.

        This enables being able to run a script as an admin user while still being able to display a toast notification to the regular user that is logged into Windows.
        
        .LINK
        https://github.com/Windos/BurntToast
    #>
    [alias('Toast')]
    [CmdletBinding(DefaultParameterSetName = 'Sound')]
    param
    (
        [Parameter()]
        [ValidateCount(0,3)]
        [String[]] $Text = 'Default Notification',

        [Parameter()]
        #[ValidateScript({ Test-ToastImage -Path $_ })]
        [String] $AppLogo,

        [Parameter()]
        #[ValidateScript({ Test-ToastAppId -Id $_ })]
        [String] $AppId,

        [Parameter(Mandatory = $false,
                   ParameterSetName = 'Sound')]
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
        [Switch] $Silent,

        [Parameter()]
        [Switch] $SnoozeAndDismiss
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

    Submit-BTNotification -Content $Content
}

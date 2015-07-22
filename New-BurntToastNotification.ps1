#requires -Version 2 
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
        
        .LINK
        https://github.com/Windos/BurntToast
    #>
    [alias('Toast')]
    [CmdletBinding(DefaultParameterSetName = 'Sound')]
    param
    (
        # Specifies the first line of text of the Toast Notification.
        #
        # This could be considered the heading/title of the Toast depending on the selected template.
        [Parameter(Mandatory = $false,
                   Position = 0)]
        [alias('Heading')]
        [String] $FirstLine = 'BurntToast',

        # Specifies the second line of text of the Toast Notification.
        #
        # This could be considered the text/body of the Toast depending on the selected template.
        [Parameter(Mandatory = $false,
                   Position = 1)]
        [alias('Text')]
        [String] $SecondLine,

        # Specifies the third line of text of the Toast Notification.
        #
        # This will only be used if you select a template that includes three lines of text.
        [Parameter(Mandatory = $false,
                   Position = 2)]
        [alias('AdditionalText')]
        [String] $ThirdLine,
        
        # Specifies the template used to build the Toast Notification.
        #
        # A catalog of available templates can be found on MSDN: https://msdn.microsoft.com/en-us/library/windows/apps/Hh761494.aspx
        [Parameter(Mandatory = $false)]
        [ValidateSet('ToastImageAndText01',
                     'ToastImageAndText02',
                     'ToastImageAndText03',
                     'ToastImageAndText04',
                     'ToastText01',
                     'ToastText02',
                     'ToastText03',
                     'ToastText04')]
        [String] $Template = 'ToastImageAndText02',
        
        # Specifies the image displayed on the Toast Notification.
        #
        # The image is only displayed if supported by the selected template.
        #
        # The path to the image must be on a local/mapped disk. Images on a UNC path will not be displayed.
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ToastImage -Path $_ })]
        [String] $Image = ( Join-Path -Path $PSScriptRoot -ChildPath 'BurntToast.png' ),

        # Specifies the AppId used to generate and display the Toast Notification.
        #
        # The AppId needs to be for a shortcut present under 'All Programs' on the Windows Start Screen/Menu.
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ToastAppId -Id $_ })]
        [String] $AppId = ( ((Get-StartApps -Name '*PowerShell*') | Select-Object -First 1).AppId ),

        # Specifies the sound that is played when the Toast Notification is displayed.
        #
        # If an alarm or call sound is chosen, the toast will be displayed for an extended period of time and the sound will loop while the toast is displayed.
        #
        # A catalog of available sounds can be found on MSDN: https://msdn.microsoft.com/en-us/library/windows/apps/hh761492.aspx
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

        # Specifies that the Toast Notification should not play any sound when displayed.
        [Parameter(Mandatory = $true,
                   ParameterSetName = 'Silent')]
        [Switch] $Silent
    )
    
    if ($AppId -ne $null -and $AppId -ne '')
    {
        $null = [Windows.UI.Notifications.ToastNotificationManager, Windows.UI.Notifications, ContentType = WindowsRuntime]
        [xml]$ToastTemplate = ([Windows.UI.Notifications.ToastNotificationManager]::GetTemplateContent(
            [Windows.UI.Notifications.ToastTemplateType]::$Template)).GetXml()

        $TextElements = $ToastTemplate.GetElementsByTagName('text')
        foreach ($TextElement in $TextElements)
        {
            switch ($TextElement.id)
            {
                '1' { $null = $TextElement.AppendChild($ToastTemplate.CreateTextNode($FirstLine)) }
                '2' { $null = $TextElement.AppendChild($ToastTemplate.CreateTextNode($SecondLine)) }
                '3' { $null = $TextElement.AppendChild($ToastTemplate.CreateTextNode($ThirdLine)) }
            }
        }
        
        if ($Template -like '*Image*')
        {
            $ImageElements = $ToastTemplate.GetElementsByTagName('image')
            $ImageElements[0].src = "file:///$Image"
        }

        $ToastNode = $ToastTemplate.SelectSingleNode('/toast')
        if ($Silent)
        {
            $AudioElement = $ToastTemplate.CreateElement('audio')
            $AudioElement.SetAttribute('silent', 'true')

            $null = $ToastNode.AppendChild($AudioElement)
        }
        else
        {
            if ($Sound -ne 'Default')
            {
                $SoundEvent = $Sound
            
                if ($SoundEvent -like 'Alarm*' -or $SoundEvent -like 'Call*')
                {
                    $ToastNode.SetAttribute('duration', 'long')
                    $SoundEvent = 'Looping.' + $SoundEvent
                }

                $AudioElement = $ToastTemplate.CreateElement('audio')
                $AudioElement.SetAttribute('src', "ms-winsoundevent:Notification.$SoundEvent")
            
                if ($SoundEvent -like 'Looping*')
                {
                    $AudioElement.SetAttribute('loop', 'true')
                }

                $null = $ToastNode.AppendChild($AudioElement)
            }
        }
        
        $ToastXml = New-Object -TypeName Windows.Data.Xml.Dom.XmlDocument
        $ToastXml.LoadXml($ToastTemplate.OuterXml)
        
        [Windows.UI.Notifications.ToastNotificationManager]::CreateToastNotifier($AppId).Show($ToastXml)
    }
    else
    {
        throw 'There is no PowerShell shortcut present on the Start Menu/Screen. Please create one or specify another ' +
        'AppId which you can find with the Get-StartApps cmdlet.'
    }
}

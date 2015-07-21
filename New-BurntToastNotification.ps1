function New-BurntToastNotification
{
    <#
        .SYNOPSIS
        Short Description
        .DESCRIPTION
        Detailed Description
        .EXAMPLE
        New-BurntToastNotification
        explains how to use the command
        can be multiple lines
        .EXAMPLE
        New-BurntToastNotification
        another example
        can have as many examples as you like
    #>
    [alias('Toast')]
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory = $false,
                   Position = 0)]
        [alias('Heading')]
        [String] $FirstLine = 'BurntToast',

        [Parameter(Mandatory = $false,
                   Position = 1)]
        [alias('Text')]
        [String] $SecondLine,

        [Parameter(Mandatory = $false,
                   Position = 2)]
        [alias('AdditionalText')]
        [String] $ThirdLine,
        
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
        
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ToastImage -Path $_ })]
        [String] $Image = ( Join-Path -Path $PSScriptRoot -ChildPath 'BurntToast.png' ),

        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ToastAppId -Id $_ })]
        [String] $AppId = ( (Get-StartApps -Name '*PowerShell*')[0].AppId ),

        [Parameter(Mandatory = $false)]
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
        [String] $Sound = 'Default'
    )
    
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
    
    $ImageElements = $ToastTemplate.GetElementsByTagName('image')
    $ImageElements[0].src = "file:///$Image"

    if ($Sound -ne 'Default')
    {
        $SoundEvent = $Sound
        $ToastNode = $ToastTemplate.SelectSingleNode('/toast')
        
        if ($SoundEvent -like 'Alarm*' -or $SoundEvent -like 'Call*')
        {
            $ToastNode.SetAttribute('duration', 'long')
            $SoundEvent = 'Looping.' + $SoundEvent
        }

        $Audio = $ToastTemplate.CreateElement('audio')
        $Audio.SetAttribute('src', "ms-winsoundevent:Notification.$SoundEvent")
        
        if ($SoundEvent -like 'Looping*')
        {
            $Audio.SetAttribute('loop', 'true')
        }

        $null = $ToastNode.AppendChild($Audio)
    }
    
    $ToastXml = New-Object -TypeName Windows.Data.Xml.Dom.XmlDocument
    $ToastXml.LoadXml($ToastTemplate.OuterXml)
    
    [Windows.UI.Notifications.ToastNotificationManager]::CreateToastNotifier($AppId).Show($ToastXml)
}

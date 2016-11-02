

$text1 = New-BTText -Content 'This is a test'
$text2 = New-BTText
$text3 = New-BTText -Content 'This more testing'
$text4 = New-BTText -Text "RAWR"

$image1 = New-BTImage -Source 'C:\Users\King\Documents\GitHub\BurntToast\Media\BurntToast.png'

#$visual1 = New-BTVisual -Element ($text1, $text2, $text3, $image1)

$audio1 = New-BTAudio -Source 'ms-winsoundevent:Notification.Reminder'

$binding1 = New-BTBinding -Children $text1, $text2, $text3, $text4, $image1

$visual1 = New-BTVisual -BindingGeneric $binding1

# $action1 = New-BTAction -SnoozeAndDismiss

#  <input id="snoozeTime" type="selection" defaultInput="10">
#    <selection id="5" content="5 minutes" />
#    <selection id="10" content="10 minutes" />
#    <selection id="20" content="20 minutes" />
#    <selection id="30" content="30 minutes" />
#    <selection id="60" content="1 hour" />
#  </input>
#  <action activationType="system" arguments="snooze" hint-inputId="snoozeTime" content=""/>
#  <action activationType="system" arguments="dismiss" content=""/>

# <toast>
#     <visual>
#         <binding template="ToastGeneric">
#             <text>This is a test</text>
#             <text />
#             <text>This more testing</text>
#             <text>RAWR</text>
#             <image src="C:\Users\King\Documents\GitHub\BurntToast\Media\BurntToast.png" hint-removeMargin="false" />
#         </binding>
#     </visual>
#     <audio src="ms-winsoundevent:Notification.SMS" />
#     <actions>
#         <input id="snoozeTime" type="selection" defaultInput="3">
#             <selection id="1" content="1 Minutes" />
#             <selection id="2" content="2 Minutes" />
#             <selection id="3" content="3 Minutes" />
#             <selection id="4" content="4 Minutes" />
#             <selection id="5" content="5 Minutes" />
#         </input>
#         <action content="" arguments="snooze" activationType="system" />
#         <action content="" arguments="dismiss" activationType="system" />
#     </actions>
# </toast>


# $Select1 = New-BTSelectionBoxItem -Id 1 -Content '1 Minutes'
# $Select2 = New-BTSelectionBoxItem -Id 2 -Content '2 Minutes'
# $Select3 = New-BTSelectionBoxItem -Id 3 -Content '3 Minutes'
# $Select4 = New-BTSelectionBoxItem -Id 4 -Content '4 Minutes'
# $Select5 = New-BTSelectionBoxItem -Id 5 -Content '5 Minutes'
# 
# $Input1 = New-BTInput -Id 'snoozeTime' -DefaultSelectionBoxItemId 3 -Items $Select1, $Select2, $Select3, $Select4, $Select5
# 
# $button1 = New-BTButton -Snooze -Id 'snoozeTime'
# $button2 = New-BTButton -Dismiss
# 
# $action2 = New-BTAction -Buttons $button1, $button2 -Inputs $Input1

$button3 = New-BTButton -Content 'Open LCTV' -Argument 'https://www.livecoding.tv/livestreams/' -ActivationType Protocol
$BurntToastPath = 'C:\Users\King\Documents\GitHub\BurntToast\Media\BurntToast.png'
$button4 = New-BTButton -Content 'Burnt Toast' -Argument $BurntToastPath -ActivationType protocol

$action3 = New-BTAction -Buttons $button3, $button4

$content1 = New-BTContent -Audio $audio1 -Visual $visual1 -Actions $action3

$null = [Windows.Data.Xml.Dom.XmlDocument, Windows.Data.Xml.Dom.XmlDocument, ContentType = WindowsRuntime]

$ToastXml = [Windows.Data.Xml.Dom.XmlDocument]::new()
$ToastXml.LoadXml($content1.GetContent())
$Toast = [Windows.UI.Notifications.ToastNotification]::new($ToastXml)
[Windows.UI.Notifications.ToastNotificationManager]::CreateToastNotifier('BurntToast').Show($Toast)




$action1 = New-BTActionElement -Content 'Open LCTV' -Argument 'https://www.livecoding.tv/livestreams/' -ActivationType protocol

$BurntToastPath = 'C:\Users\King\Documents\GitHub\BurntToast\Media\BurntToast.png'
$action2 = New-BTActionElement -Content 'Burnt Toast' -Argument $BurntToastPath -ActivationType protocol

$actions1 = [Actions]::new()
$actions1.AddElement($action1)
$actions1.AddElement($action2)

#$actions1 = [Actions]::new('SnoozeAndDismiss')
$toast1 = [Toast]::new('default', $visual1, $audio1, $actions1)

$AppId = ( ((Get-StartApps -Name '*PowerShell*') | Where-Object -FilterScript {$_.AppId -like '*.exe'} | Select-Object -First 1).AppId  )

$null = [Windows.UI.Notifications.ToastNotificationManager, Windows.UI.Notifications, ContentType = WindowsRuntime]
$null = [Windows.Data.Xml.Dom.XmlDocument, Windows.Data.Xml.Dom.XmlDocument, ContentType = WindowsRuntime]

[xml]$ToastTemplate = $toast1.GetXML()

$ToastXml = [Windows.Data.Xml.Dom.XmlDocument]::new()
$ToastXml.LoadXml($ToastTemplate.OuterXml)

$Toast = [Windows.UI.Notifications.ToastNotification]::new($ToastXml)

# $Toast.SuppressPopup = $true

[Windows.UI.Notifications.ToastNotificationManager]::CreateToastNotifier($AppId).Show($Toast)

'Default',
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
                     'Call10'


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

    #Different type per parameter set.

    # [OutputType([<TypeLiteral>], ParameterSetName="<Name>")]
    # [OutputType("<TypeNameString>", ParameterSetName="<Name>")]
using module BurntToast.Class

$text1 = New-BTTextElement -Content 'This is a test'
$text2 = New-BTTextElement
$text3 = New-BTTextElement -Content 'This more testing'

$image1 = New-BTImageElement -Source 'C:\Users\King\Documents\GitHub\BurntToast\Media\BurntToast.png' -Placement appLogoOverride -Crop circle 

$visual1 = New-BTVisual -Element ($text1, $text2, $text3, $image1)

$audio1 = New-BTAudioElement -Source Call6

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

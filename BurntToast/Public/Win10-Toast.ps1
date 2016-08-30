#$text1 = [Text]::new('This is a test')
#$text2 = [Text]::new('This more testing')
$text1 = New-BTTextElement -Content 'This is a test'
$text2 = New-BTTextElement
$text3 = New-BTTextElement -Content 'This more testing'

#$image1 = [Image]::new('C:\Users\King\Documents\GitHub\BurntToast\Media\BurntToast.png', [ImagePlacement]::appLogoOverride, [ImageCrop]::circle)
$image1 = New-BTImageElement -Source 'C:\Users\King\Documents\GitHub\BurntToast\Media\BurntToast.png' -Placement appLogoOverride -Crop circle
$binding1 = [Binding]::new()
$binding1.AddElement($text1)
$binding1.AddElement($text2)
$binding1.AddElement($text3)
$binding1.AddElement($image1)
$visual1 = [Visual]::new($binding1)

#$audio1 = [Audio]::new([AudioSource]::SMS)
#$audio1 = New-CrumpetAudioElement -Source Call6
$audio1 = New-BTAudioElement -Path 'D:/song.aac'

$action1 = [ToastAction]::new('Open LCTV','https://www.livecoding.tv/livestreams/',[ActivationType]::protocol)
$BurntToastPath = 'C:\Users\King\Documents\GitHub\BurntToast\Media\BurntToast.png'
$action2 = [ToastAction]::new('Burn Toast',$BurntToastPath,[ActivationType]::protocol)
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

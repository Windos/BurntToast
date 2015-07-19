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
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory = $false,
                   Position = 0)]
        [String] $FirstLine = 'BurntToast',

        [Parameter(Mandatory = $false,
                   Position = 1)]
        [String] $SecondLine,

        [Parameter(Mandatory = $false,
                   Position = 2)]
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
        [ValidateScript({ Test-Path -Path $_ })]
        [String] $Image = ( Join-Path -Path $PSScriptRoot -ChildPath 'BurntToast.png' )
    )
    
    $null = [Windows.UI.Notifications.ToastNotificationManager, Windows.UI.Notifications, ContentType = WindowsRuntime]
    [xml]$ToastTemplate = ([Windows.UI.Notifications.ToastNotificationManager]::GetTemplateContent([Windows.UI.Notifications.ToastTemplateType]::$Template)).GetXml()
    
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
    
    $ToastXml = New-Object -TypeName Windows.Data.Xml.Dom.XmlDocument
    $ToastXml.LoadXml($ToastTemplate.OuterXml)
    
    $AppId = '{1AC14E77-02E7-4E5D-B744-2EB1AE5198B7}\WindowsPowerShell\v1.0\powershell.exe'
    
    [Windows.UI.Notifications.ToastNotificationManager]::CreateToastNotifier($AppId).Show($ToastXml)
}

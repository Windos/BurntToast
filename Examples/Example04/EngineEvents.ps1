Register-EngineEvent -SourceIdentifier Powershell.Exiting -Action {

    $header = New-BTHeader -Id 1 -Title "Automation Done"
    New-BurntToastNotification -Text "Hey there! That script you wrote is finished." -Silent -Header $header

}
$BurntJob = Start-Job -ScriptBlock {Start-Sleep 5;Get-date} -Name "BurntJob"

$BurntEvent = Register-ObjectEvent $BurntJob StateChanged -Action {
    New-BurntToastNotification -Text "Job: $($BurntJob.Name) completed"
    $BurntEvent | Unregister-Event
}
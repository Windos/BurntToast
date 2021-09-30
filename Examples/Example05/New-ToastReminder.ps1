Function New-ToastReminder {
<#
.SYNOPSIS
Schedules a toast reminder for some point in the future

.PARAMETER ReminderTitle
The title of the toast when it appears

.PARAMETER ReminderText
The main text body for the reminder

.PARAMETER Seconds
The number of seconds to wait before showing the reminder.
This parameter is additive with the -Minutes and -Hours parameters

.PARAMETER Minutes
The number of minutes to wait before showing the reminder.
This parameter is additive with the -Seconds and -Hours parameters

.PARAMETER Hours
The number of hours to wait before showing the reminder.
This parameter is additive with the -Seconds and -Minutes parameters

.PARAMETER AppLogo
The logo to be displayed on the toast notification

.PARAMETER PassThru
If this parameter is specified, a reference to the event registration will be written to the pipeline
(e.g. to allow the subscription to be cancelled). By default, this cmdlet produces no output

.EXAMPLE
New-ToastReminder -Hours 1 -Minutes 30 -ReminderTitle "Heads up" -ReminderText "Time to take a break!"
This example sets a reminder for 1h30min from now with the specified title and text

.NOTES
As this cmdlet functions via an event registration, the PowerShell session that launched it must
remain open for the reminder to trigger.
#>
    [CmdletBinding(SupportsShouldProcess = $true)]
    Param(
        [Parameter(Mandatory, Position = 0)]
        [Alias("Title")]
        [ValidateNotNullOrEmpty()]
        [string]
        $ReminderTitle,

        [Parameter(Mandatory, Position = 1)]
        [Alias("Text")]
        [ValidateNotNullOrEmpty()]
        [string]
        $ReminderText,

        [Parameter(Position = 2)]
        [int]
        $Seconds,

        [Parameter(Position = 3)]
        [Int]
        $Minutes,

        [Parameter(Position = 4)]
        [Int]
        $Hours,

        [Parameter(Position = 5)]
        [string]
        $AppLogo,

        [switch]
        $Passthru
    )

    Begin {}

    Process {

        $Timer = [System.Timers.Timer]::new()
        If ($Hours + $Minutes + $Seconds -eq 0)
        {
            $IntervalSpan = New-TimeSpan -Seconds 1
        }
        Else
        {
            $IntervalSpan = [timespan]::Zero
            $Intervalspan = $IntervalSpan.Add([timespan]::FromHours($Hours))
            $Intervalspan = $IntervalSpan.Add([timespan]::FromMinutes($Minutes))
            $Intervalspan = $IntervalSpan.Add([timespan]::FromSeconds($Seconds))
        }
        $Timer.Interval = $IntervalSpan.TotalMilliseconds
        $Timer.AutoReset = $false
        $Data = [pscustomobject]@{
            Title = $ReminderTitle
            Text = $ReminderText
            $AppLogo = $AppLogo
        }
        $ElapsedAction = {
            $Data = $event.MessageData
            $Header = New-BTHeader -ID 1 -Title $Data.Title
            New-BurntToastNotification -Text $Data.Text -Header $Header -AppLogo $Data.$AppLogo -SnoozeAndDismiss
            $Event | Unregister-Event
            $Timer.Dispose()
        }

        $ElapsedObjectEvent = Register-ObjectEvent -InputObject $Timer -EventName "Elapsed" -MaxTriggerCount 1 -Action $ElapsedAction -MessageData $Data

        $Timer.Start()

        if ($Passthru)
        {
            Write-Output $ElapsedObjectEvent
        }
    }

    End {}
}

if($PSCmdlet.ShouldProcess($ReminderTitle)) {
    New-ToastReminder -Minutes 30 -ReminderTitle 'Hey you' -ReminderText 'The coffee is brewed'
}

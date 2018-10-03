Function New-ToastReminder {

    [cmdletBinding()]
    Param(
        [Parameter(Mandatory, Position = 0)]
        [string]
        $ReminderTitle,

        [Parameter(Mandatory, Position = 1)]
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
        $Hours
    )

    Begin {}

    Process {

        Start-Job -ArgumentList $ReminderTitle,$ReminderText,$Seconds,$Minutes,$Hours -ScriptBlock {
            #Countdown reminders
            $watch = New-Object System.Diagnostics.Stopwatch
            $watch.Start()

            Switch ($true) {

                $args[4] { $seconds = $hours * 60 * 60}
                $args[3] {$seconds = $minutes * 60}
                $args[2] { >$null }
            }
            While ($watch.Elapsed.TotalSeconds -lt $args[2]) {

                Out-Null
            }
            $watch.Stop()
            $Head = New-BTHeader -ID 1 -Title $args[0]
            Toast -Text $args[1] -Header $Head -AppLogo $null
        } > $null
    }

    End {}

}
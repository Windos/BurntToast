function Get-BTEvent {
    [CmdletBinding()]
    param(
        [string] $Argument,

        [string] $SourceIdentifier = 'BurntToast_*'
    )

    $EventSubscribers = Get-EventSubscriber -SourceIdentifier $SourceIdentifier

    if ($Argument) {
        $EventSubscribers | Where-Object { $_.Action.Command -like "*Arguments -eq '$($Argument)'*" }
    }
    else {
        $EventSubscribers
    }
}
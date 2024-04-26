function Register-BTEvent {
    <#
        .SYNOPSIS
        Registers an event that executes a specified action when a toast notification is activated.

        .DESCRIPTION
        The Register-BTEvent function registers an event that executes a specified action when a toast notification is activated. The function can optionally save the event data for inspection to assist with developing followup actions.

        .INPUTS
        System.Management.Automation.ScriptBlock. You cannot pipe objects to Register-BTEvent.

        .OUTPUTS
        System.Management.Automation.PSEventJob

        .EXAMPLE
        PS C:\> Register-BTEvent { Write-Host 'Toast notification activated.' }

        This example registers an event that writes a message to the console when a toast notification is activated.

        .EXAMPLE
        PS C:\> Register-BTEvent { Write-Host 'Toast notification activated.' } -SaveEventData -EventDataVariableName 'ToastEvent'

        This example registers an event that saves the event data in a global variable named 'ToastEvent' when a toast notification is activated, accessed via `$Global:ToastEvent`

        .EXAMPLE
        PS C:\> Register-BTEvent { Write-Host 'Toast notification activated.' } -SourceIdentifier 'MySourceIdentifier'

        This example registers an event with the specified source identifier that writes a message to the console when a toast notification is activated.

        .EXAMPLE
        PS C:\> $EventRegistration = Register-BTEvent { Write-Host 'Toast notification activated.' } -PassThru

        This example registers an event that writes a message to the console when a toast notification is activated and returns the event registration object.

        .LINK
        https://docs.toastit.dev/commands/register-btevent
    #>

    [CmdletBinding()]
    param(
        # Specifies the action to execute when the event is triggered.
        [Parameter(Mandatory)]
        [scriptblock] $Action,

        [string] $ArgumentFilter,

        # Indicates whether to save the event data. If this switch is specified,
        # the function saves the event data in a global variable with the specified variable name.
        [switch] $SaveEventData,

        # Specifies the name of the variable to use when saving the event data.
        # This parameter is only used if the SaveEventData switch is specified.
        [string] $EventDataVariableName = 'ToastEvent',

        # Specifies the source identifier to use when registering the event.
        # If this parameter is not specified, the function generates a unique source identifier.
        [string] $SourceIdentifier,

        # Indicates whether to pass through the event registration object.
        # If this switch is specified, the function returns the event registration object.
        [switch] $PassThru
    )

    $SourceID = if ($SourceIdentifier) {
        $SourceIdentifier
    } else {
        'BurntToast_{0}' -f [guid]::NewGuid()
    }

    $MessageData = [PSObject] @{
        SaveEventData = $SaveEventData
        EventDataVariableName = $EventDataVariableName
    }

    $EventScriptString =
@"
if ($Event.MessageData.SaveEventData) {
    New-Variable -Name $Event.MessageData.EventDataVariableName -Value $Event -Scope Global -Force
}

if ($null -eq $ArgumentFilter -or $Event.SourceArgs.Argument -contains $ArgumentFilter) {
    $($Action.ToString())
}
"@

    $CompatToastMgr = [Microsoft.Toolkit.Uwp.Notifications.ToastNotificationManagerCompat]
    $EventRegistration = Register-ObjectEvent -InputObject $CompatToastMgr -EventName OnActivated -SourceIdentifier $SourceID -MessageData $MessageData -Action ([scriptblock]::Create($EventScriptString))

    if ($PassThru) {
        $EventRegistration
    }
}
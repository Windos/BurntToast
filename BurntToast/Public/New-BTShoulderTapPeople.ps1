function New-BTShoulderTapPeople {
    <#
        .SYNOPSIS
        TODO

        .DESCRIPTION
        TODO

        .INPUTS
        TODO

        .OUTPUTS
        TODO

        .EXAMPLE
        TODO

        .LINK
        https://github.com/Windos/BurntToast/blob/master/Help/New-BTShoulderTapPeople.md
    #>

    [CmdletBinding(DefaultParameterSetName = 'Email')]
    [OutputType([Microsoft.Toolkit.Uwp.Notifications.ToastPeople])]

    param (
        [Parameter(ParameterSetName = 'Email',
                   Mandatory)]
        [string] $Email,

        [Parameter(ParameterSetName = 'RemoteId',
                   Mandatory)]
        [string] $RemoteId,

        [Parameter(ParameterSetName = 'PhoneNumber',
                   Mandatory)]
        [string] $PhoneNumber
    )

    $ToastPeople = [Microsoft.Toolkit.Uwp.Notifications.ToastPeople]::new()

    switch ($PSCmdlet.ParameterSetName) {
        Email {$ToastPeople.EmailAddress = $Email}
        RemoteId {$ToastPeople.RemoteId = $RemoteId}
        PhoneNumber {$ToastPeople.PhoneNumber = $PhoneNumber}
    }

    $ToastPeople
}

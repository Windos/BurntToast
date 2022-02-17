function New-BTShoulderTapPeople {
    <#
        .SYNOPSIS
        Creates a new ToastPeople object.

        .DESCRIPTION
        The New-BTShoulderTapPeople function creates a new ToastPeople object. This object identifies a user from the People app which has been pinned to the Windows Taskbar.

        This function is mainly used internally, as it is abstracted away when using New-BurntToastShoulderTap.

        .INPUTS
        STRING

        .OUTPUTS
        ToastPeople

        .EXAMPLE
        $Person = New-BTShoulderTapPeople -Email 'bob@example.com'

        .LINK
        https://github.com/Windos/BurntToast/blob/main/Help/New-BTShoulderTapPeople.md
    #>

    [Obsolete('This cmdlet is being deprecated, it will be removed in v0.9.0')]
    [CmdletBinding(DefaultParameterSetName = 'Email',
                   HelpUri = 'https://github.com/Windos/BurntToast/blob/main/Help/New-BTShoulderTapPeople.md')]
    [OutputType([Microsoft.Toolkit.Uwp.Notifications.ToastPeople])]

    param (
        # The email address which matches a contact in the Contacts app.
        [Parameter(ParameterSetName = 'Email',
                   Mandatory)]
        [string] $Email,

        # The remote identifier which matches a contact in the Contacts app.
        [Parameter(ParameterSetName = 'RemoteId',
                   Mandatory)]
        [string] $RemoteId,

        # The phone number which matches a contact in the Contacts app.
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

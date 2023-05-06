function New-BTContentBuilder {
    <#
        .SYNOPSIS
        Create a toast builder object.

        .DESCRIPTION
        The New-BTContentBuilder function creates a new toast content builder object to construct a complete notification.

        .INPUTS
        None. You cannot pipe objects to New-BTContentBuilder.

        .OUTPUTS
        Microsoft.Toolkit.Uwp.Notifications.ToastContentBuilder

        .EXAMPLE
        PS C:\>$Builder = New-BTContentBuilder

        This example creates a new toast content builder object and storing it in a variable named $Builder.

        .EXAMPLE
        PS C:\>$Builder = Builder

        This example creates a new toast content builder object using the Builder alias and storing it in a variable named $Builder.

        .LINK
        https://docs.toastit.dev/commands/new-btcontentbuilder
    #>

    [Alias('Builder')]
    [CmdletBinding(SupportsShouldProcess = $true)]
    param (
        [ValidateNotNullOrEmpty()]
        [ValidateLength(1, 64)]
        [string] $Group = 'BurntToast',

        [ValidateNotNullOrEmpty()]
        [ValidateLength(1, 64)]
        [string] $Tag = [Guid]::NewGuid().ToString()
    )

    if ($PSCmdlet.ShouldProcess( "Creating instance of a ToastContentBuilder object and returning it.", $env:COMPUTERNAME, 'New-BTContentBuilder' )) {
        $Builder = [Microsoft.Toolkit.Uwp.Notifications.ToastContentBuilder]::new()
        $Builder | Add-Member -MemberType NoteProperty -Name 'Group' -Value $Group
        $Builder | Add-Member -MemberType NoteProperty -Name 'Tag' -Value $Tag
        $Builder | Add-Member -MemberType NoteProperty -Name 'DataBinding' -Value @{}
        $Builder
    }
}
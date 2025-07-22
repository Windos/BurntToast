function Get-BTHeader {
    <#
        .SYNOPSIS
        Shows and filters all toast notification headers in the Action Center.

        .DESCRIPTION
        The Get-BTHeader function returns all the unique toast notification headers currently present in the Action Center (notifications which have not been dismissed by the user).
        You can filter by a specific toast notification identifier, header title, or header id.

        .PARAMETER ToastUniqueIdentifier
        The unique identifier (string) of a toast notification. Only headers belonging to the notification with this identifier will be returned.

        .PARAMETER Title
        Filters headers by a specific title (string).

        .PARAMETER Id
        Filters headers to only those with the specified header id (string).

        .INPUTS
        None. You cannot pipe input to this function.

        .OUTPUTS
        Microsoft.Toolkit.Uwp.Notifications.ToastHeader

        .EXAMPLE
        Get-BTHeader
        Returns all unique toast notification headers in the Action Center.

        .EXAMPLE
        Get-BTHeader -ToastUniqueIdentifier 'Toast001'
        Returns headers for toasts with the specified unique identifier.

        .EXAMPLE
        Get-BTHeader -Title "Stack Overflow Questions"
        Returns headers with a specific title.

        .EXAMPLE
        Get-BTHeader -Id "001"
        Returns the header with the matching id.

        .LINK
        https://github.com/Windos/BurntToast/blob/main/Help/Get-BTHeader.md
    #>

    [cmdletBinding(DefaultParametersetName = 'All',
                   HelpUri='https://github.com/Windos/BurntToast/blob/main/Help/Get-BTHeader.md')]
    param (
        [Parameter(Mandatory,
                   ParametersetName = 'ByToastId')]
        [Alias('ToastId')]
        [string] $ToastUniqueIdentifier,

        [Parameter(Mandatory,
                   ParametersetName = 'ByTitle')]
        [string] $Title,

        [Parameter(Mandatory,
                   ParametersetName = 'ById')]
        [Alias('HeaderId')]
        [string] $Id
    )

    $HistoryParams = @{}
    if ($PSCmdlet.ParameterSetName -eq 'ByToastId') { $HistoryParams['UniqueIdentifier'] = $ToastUniqueIdentifier}

    $HeaderIds = New-Object -TypeName "System.Collections.ArrayList"

    # Union all of the possible Toast Notifications
    Get-BTHistory @HistoryParams | `
    Add-PipelineObject -Process {
        Get-BTHistory @HistoryParams -ScheduledToast
    } | `
    # Only select those that actually have a valid definition
    Where-Object { $null -ne $_.Content } | `
    # Find unique Header nodes in the notifications
    ForEach-Object -Process {
        $HeaderNode = $_.Content.SelectSingleNode('//*/header')
        if ($null -ne $HeaderNode -and $null -ne $HeaderNode.GetAttribute('id') -and $HeaderIds -notcontains $HeaderNode.GetAttribute('id')) {
            $HeaderIds.Add($HeaderNode.GetAttribute('id')) | Out-Null
            $HeaderNode
        }
    } | `
    # Filter header by title, when specified
    Where-Object { $PSCmdlet.ParameterSetName -ne 'ByTitle' -or $_.GetAttribute('title') -eq $Title } | `
    # Filter header by id, when specified
    Where-Object { $PSCmdlet.ParameterSetName -ne 'ById' -or $_.GetAttribute('id') -eq $Id } | `
    # Convert the XML definition into an actual ToastHeader object
    ForEach-Object -Process {
        $Header = [Microsoft.Toolkit.Uwp.Notifications.ToastHeader]::new($HeaderNode.GetAttribute('id'), $HeaderNode.GetAttribute('title'), $HeaderNode.GetAttribute('arguments'))
        $Header.ActivationType = $HeaderNode.GetAttribute('activationType')
        $Header
    }
}

function Get-BTHeader {
    <#
        .SYNOPSIS
        Show all toast headers in the Action Center.

        .DESCRIPTION
        The Get-BTHeader function returns all the unique toast notification headers that are in the Action Center. Toasts that have been dismissed by the user will not be returned.

        .INPUTS
        STRING

        .OUTPUTS
        Microsoft.Toolkit.Uwp.Notifications.ToastHeader

        .EXAMPLE
        Get-BTHeader

        .LINK
        https://github.com/Windos/BurntToast/blob/main/Help/Get-BTHeader.md
    #>

    [cmdletBinding(DefaultParametersetName = 'All',
                   HelpUri='https://github.com/Windos/BurntToast/blob/main/Help/Get-BTHeader.md')]
    param (
        # Specifies the AppId of the 'application' or process that spawned the toast notification.
        [string] $AppId = $Script:Config.AppId,

        # A string that uniquely identifies a toast notification to retrieve the Header for
        [Parameter(Mandatory,
                   ParametersetName = 'ByToastId')]
        [Alias('ToastId')]
        [string] $ToastUniqueIdentifier,

        # The title of the Header to retrieve
        [Parameter(Mandatory,
                   ParametersetName = 'ByTitle')]
        [string] $Title,

        # The title of the Header to retrieve
        [Parameter(Mandatory,
                   ParametersetName = 'ById')]
        [Alias('HeaderId')]
        [string] $Id
    )

    $HistoryParams = @{
        'AppId' = $AppId
    }
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

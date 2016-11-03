function New-BTButton
{
    <#
        .SYNOPSIS

        .DESCRIPTION

        .INPUTS
        None

        .OUTPUTS
        Image
        
        .EXAMPLE

        .EXAMPLE

        .EXAMPLE

        .LINK
        https://github.com/Windos/BurntToast
    #>

    [CmdletBinding(DefaultParametersetName = 'Button')]
    [OutputType([Microsoft.Toolkit.Uwp.Notifications.ToastButton], ParameterSetName = 'Button')]
    [OutputType([Microsoft.Toolkit.Uwp.Notifications.ToastButtonDismiss], ParameterSetName = 'Dismiss')]
    [OutputType([Microsoft.Toolkit.Uwp.Notifications.ToastButtonSnooze], ParameterSetName = 'Snooze')]

    param
    (
        [Parameter(Mandatory,
                   ParameterSetName = 'Snooze')]
        [switch] $Snooze,

        [Parameter(Mandatory,
                   ParameterSetName = 'Dismiss')]
        [switch] $Dismiss,
        
        [Parameter(Mandatory,
                   ParameterSetName = 'Button')]
        [Parameter(ParameterSetName = 'Dismiss')]
        [Parameter(ParameterSetName = 'Snooze')]
        [string] $Content,
        
        [Parameter(Mandatory,
                   ParameterSetName = 'Button')]
        [string] $Arguments,

        [Parameter(ParameterSetName = 'Button')]
        [Microsoft.Toolkit.Uwp.Notifications.ToastActivationType] $ActivationType,

        [Parameter()]
        [string] $ImageUri,

        [Parameter(ParameterSetName = 'Button')]
        [Parameter(ParameterSetName = 'Snooze')]
        [alias('TextBoxId', 'SelectionBoxId')]
        [string] $Id
    )

    switch ($PsCmdlet.ParameterSetName)
    {
        'Button'
        {
            $Button = [Microsoft.Toolkit.Uwp.Notifications.ToastButton]::new($Content, $Arguments)
            
            if ($ActivationType)
            {
                $Button.ActivationType = $ActivationType
            }

            if ($Id)
            {
                $Button.TextBoxId = $Id
            }
        }
        'Snooze'
        {
            $Button = [Microsoft.Toolkit.Uwp.Notifications.ToastButtonSnooze]::new()

            if ($Content)
            {
                $Button.CustomContent = $Id
            }
            
            if ($Id)
            {
                $Button.SelectionBoxId = $Id
            }
        }
        'Dismiss'
        {
            $Button = [Microsoft.Toolkit.Uwp.Notifications.ToastButtonDismiss]::new()

            if ($Content)
            {
                $Button.CustomContent = $Id
            }
        }
    }

    if ($ImageUri)
    {
        $Button.ImageUri = $ImageUri
    }

    $Button
}

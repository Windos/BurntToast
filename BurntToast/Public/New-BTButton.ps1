using namespace Microsoft.Toolkit.Uwp.Notifications

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
    [OutputType([ToastButton], ParameterSetName = 'Button')]
    [OutputType([ToastButtonDismiss], ParameterSetName = 'Dismiss')]
    [OutputType([ToastButtonSnooze], ParameterSetName = 'Snooze')]

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
        [ToastActivationType] $ActivationType,

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
            $Button = [ToastButton]::new($Content, $Arguments)
            
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
            $Button = [ToastButtonSnooze]::new()

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
            $Button = [ToastButtonDismiss]::new()

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

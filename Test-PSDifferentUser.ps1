#requires -Version 2
function Test-PSDifferentUser
{
    <#
        .SYNOPSIS
        Determines if a PowerShell Process was started using 'Run as different user.'

        .DESCRIPTION
        The Test-PSDifferentUser cmdlet determines whether a PowerShell host process was starting as another user using the 'Run as different user' option.

        For example:

            You are logged in as example.com\user and start and the PowerShell ISE as example.com\admin

            You run Test-PSDifferentUser and it returns $true

            You open another PowerShell ISE as your own account and run Test-PSDifferentUser, it returns $false

        This is useful when running scripts which interact with a users desktop manager or similar features.

        .INPUTS
        System.Diagnostics.Process, Microsoft.Management.Infrastructure.CimInstance#root/cimv2/Win32_Process

        You can pipe a Process or Win32_Process object to this cmdlet.

        .OUTPUTS
        System.Boolean

        Test-PSDifferentUser returns a true or false boolean value.

        .EXAMPLE
        Test-PSDifferentUser

        This command returns $true if the process executing the command was starting using 'Run as different user.'

        .EXAMPLE
        Get-Process -Name *powershell* | Test-PSDifferentUser

        This command verifies all running PowerShell processes to determine if they were started using 'Run as different user.'

        .LINK
        https://github.com/Windos/BurntToast

        .LINK
        New-BurntToastNotification
    #>

    [Alias('isDifferentUser')]
    [CmdletBinding()]
    [OutputType([System.Boolean])]
    param (
        [Parameter(Position = 0,
                ValueFromPipeline = $true,
        ValueFromPipelineByPropertyName = $true)]
        [Alias('Id')]
        [ValidateScript({
                    if ((Get-Process -Id $_).ProcessName -like '*powershell*')
                    {
                        $true
                    }
                    else
                    {
                        throw "There is either no process with Id $_ or the specified process is not a PowerShell host."
                    }
        })]
        [Int32[]] $ProcessId = ([System.Diagnostics.Process]::GetCurrentProcess()).Id
    )

    process {
        foreach ($TestId in $ProcessId)
        {
            $ParentProcessId = (Get-CimInstance Win32_Process -Filter "ProcessId = $TestId").ParentProcessId
            $ParentProcess = Get-Process -Id $ParentProcessId -ErrorAction SilentlyContinue

            if ($ParentProcess)
            {
                $false
            }
            else
            {
                $true
            }
        }
    }
}

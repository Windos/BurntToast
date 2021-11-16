. (Join-Path -Path $PSScriptRoot -ChildPath '_envPrep.ps1')

# Helper function needs to be in the global scope so it can be used in mocks
# Note - This may not work in Pester 5+
Function Global:New-MockNotification(
    $HeaderId = (New-GUID).ToString(),
    $HeaderTitle = (New-GUID).ToString(),
    $HeaderArguments = '',
    $HeaderActivation = 'protocol'
    ) {
    $Content = @"
<?xml version="1.0" encoding="UTF-8"?>
<toast>
    <visual>
        <binding template="ToastGeneric">
            <text>Mock Toast</text>
        </binding>
    </visual>
    <actions />
    <header id="$HeaderId" title="$HeaderTitle" arguments="$HeaderArguments" activationType="$HeaderActivation" />
</toast>
"@
    $XMLContent = [Windows.Data.Xml.Dom.XmlDocument]::new()
    $XmlContent.LoadXml($Content)
    [Windows.UI.Notifications.ToastNotification]::new($XMLContent)
}

Describe 'Get-BTHeader' {
    It 'should call Get-BTHistory with and without scheduled information' {
        Mock Get-BTHistory -ModuleName BurntToast -Verifiable -ParameterFilter { $ScheduledToast }
        Mock Get-BTHistory -ModuleName BurntToast -Verifiable -ParameterFilter { -not $ScheduledToast }

        Get-BTHeader

        Assert-VerifiableMock
    }

    Context 'With multiple duplicate notifications' {
        Mock Get-BTHistory -ModuleName BurntToast -Verifiable -ParameterFilter { $ScheduledToast } {
            New-MockNotification -HeaderId 'ID01'
            New-MockNotification -HeaderId 'ID01'
        }

        Mock Get-BTHistory -ModuleName BurntToast -Verifiable -ParameterFilter { -not $ScheduledToast } {
            New-MockNotification -HeaderId 'ID01'
            New-MockNotification -HeaderId 'ID01'
        }

        It 'should ignore duplicate headers' {
            $Headers = Get-BTHeader
            Assert-VerifiableMock
            $Headers.Count | Should -Be 1
            $Headers[0].Id | Should -Be 'ID01'
        }
    }

    Context 'With multiple unique notifications' {
        Mock Get-BTHistory -ModuleName BurntToast -Verifiable -ParameterFilter { $ScheduledToast } {
            New-MockNotification -HeaderId 'ID01' -HeaderTitle 'Title 01'
            New-MockNotification -HeaderId 'ID02' -HeaderTitle 'Title 02'
        }

        Mock Get-BTHistory -ModuleName BurntToast -Verifiable -ParameterFilter { -not $ScheduledToast } {
            New-MockNotification -HeaderId 'ID03' -HeaderTitle 'Title 03'
            New-MockNotification -HeaderId 'ID04'
        }

        It 'should return all headers' {
            $Headers = Get-BTHeader
            Assert-VerifiableMock
            $Headers.Count | Should -Be 4
        }

        It 'should return header by title' {
            $Headers = Get-BTHeader -Title 'Title 01'
            Assert-VerifiableMock
            $Headers.Count | Should -Be 1
            $Headers[0].Id | Should -Be 'ID01'
            $Headers[0].Title | Should -Be 'Title 01'
        }

        It 'should return header by id' {
            $Headers = Get-BTHeader -Id 'ID03'
            Assert-VerifiableMock
            $Headers.Count | Should -Be 1
            $Headers[0].Id | Should -Be 'ID03'
            $Headers[0].Title | Should -Be 'Title 03'
        }

        It 'should return no headers for a missing title' {
            $Headers = Get-BTHeader -Title 'Title MISSING'
            Assert-VerifiableMock
            $Headers.Count | Should -Be 0
        }

        It 'should return no headers for a missing id' {
            $Headers = Get-BTHeader -Id 'IDMISSING'
            Assert-VerifiableMock
            $Headers.Count | Should -Be 0
        }
    }

    Context 'With a single unique notifications' {
        Mock Get-BTHistory -ModuleName BurntToast -Verifiable -ParameterFilter { $ScheduledToast } {
            New-MockNotification -HeaderId 'ID01' -HeaderTitle 'Title 01' -HeaderArguments 'arguments' -HeaderProtocol 'protocol'
        }

        It 'should return all header properties' {
            $Headers = Get-BTHeader
            Assert-VerifiableMock
            $Headers.Count | Should -Be 1
            $Headers.Id | Should -Be 'ID01'
            $Headers.Title | Should -Be 'Title 01'
            $Headers.Arguments | Should -Be 'arguments'
            $Headers.ActivationType.ToString() | Should -Be 'Protocol'
        }
    }
}

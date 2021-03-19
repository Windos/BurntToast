Describe 'New-BTContentBuilder' {
    BeforeAll {
        if (Get-Module -Name 'BurntToast') {
            Remove-Module -Name 'BurntToast'
        }

        Import-Module "$PSScriptRoot/../src/BurntToast.psd1" -Force
    }
    
    Context 'invoke by full function name' {
        BeforeAll {
            $Builder = New-BTContentBuilder
        }

        It 'is a ToastContentBuilder object' {
            $Builder | Should -BeOfType Microsoft.Toolkit.Uwp.Notifications.ToastContentBuilder
        }

        It 'generates next to no XML' {
            $ExpectedXML = '<?xml version="1.0"?><toast/>'
            $Builder.GetXml().GetXml() | Should -BeExactly $ExpectedXML
        }

        It 'should use the default scenario' {
            $Builder.GetToastContent().Scenario | Should -BeExactly 'Default'
        }

        It 'should have a short duration' {
            $Builder.GetToastContent().Duration | Should -BeExactly 'Short'
        }
    }
    Context 'invoke by alias name' {
        BeforeAll {
            $Builder = Builder
        }

        It 'is a ToastContentBuilder object' {
            $Builder | Should -BeOfType Microsoft.Toolkit.Uwp.Notifications.ToastContentBuilder
        }

        It 'generates next to no XML' {
            $ExpectedXML = '<?xml version="1.0"?><toast/>'
            $Builder.GetXml().GetXml() | Should -BeExactly $ExpectedXML
        }

        It 'should use the default scenario' {
            $Builder.GetToastContent().Scenario | Should -BeExactly 'Default'
        }

        It 'should have a short duration' {
            $Builder.GetToastContent().Duration | Should -BeExactly 'Short'
        }
    }
}
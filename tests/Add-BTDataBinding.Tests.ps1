Describe 'Add-BTDataBinding' {
    BeforeAll {
        if (Get-Module -Name 'BurntToast') {
            Remove-Module -Name 'BurntToast'
        }

        if ($ENV:BURNTTOAST_MODULE_ROOT) {
            Import-Module $ENV:BURNTTOAST_MODULE_ROOT -Force
        } else {
            Import-Module "$PSScriptRoot/../src/BurntToast.psd1" -Force
        }
    }

    It 'add bindings one at a time' {
        $Builder = New-BTContentBuilder
        Add-BTText -ContentBuilder $Builder -Text 'Heading' -Bindable
        Add-BTText -ContentBuilder $Builder -Text 'Body' -Bindable
        Add-BTDataBinding -ContentBuilder $Builder -Key 'Heading' -Value 'This is the heading'
        Add-BTDataBinding -ContentBuilder $Builder -Key 'Body' -Value 'This is the body'

        # The resulting XML is as expected
        $ExpectedXML = '<?xml version="1.0"?><toast><visual><binding template="ToastGeneric"><text>{Heading}</text><text>{Body}</text></binding></visual></toast>'
        $Builder.GetXml().GetXml() | Should -BeExactly $ExpectedXML

        # Bindable text is found in the bindings
        $Builder.Content.Visual.BindingGeneric.Children.Text[0].BindingName | Should -BeIn $Builder.DataBinding.Keys
        $Builder.Content.Visual.BindingGeneric.Children.Text[1].BindingName | Should -BeIn $Builder.DataBinding.Keys
    }

    It 'adds a text box via the pipeline' {
        $Builder = New-BTContentBuilder
        Add-BTText -ContentBuilder $Builder -Text 'Heading' -Bindable
        Add-BTText -ContentBuilder $Builder -Text 'Body' -Bindable
        $Binding = @{
            Heading = 'This is the heading'
            Body = 'This is the body'
        }
        Add-BTDataBinding -ContentBuilder $Builder -Hashtable $Binding

        # The resulting XML is as expected
        $ExpectedXML = '<?xml version="1.0"?><toast><visual><binding template="ToastGeneric"><text>{Heading}</text><text>{Body}</text></binding></visual></toast>'
        $Builder.GetXml().GetXml() | Should -BeExactly $ExpectedXML

        # Bindable text is found in the bindings
        $Builder.Content.Visual.BindingGeneric.Children.Text[0].BindingName | Should -BeIn $Builder.DataBinding.Keys
        $Builder.Content.Visual.BindingGeneric.Children.Text[1].BindingName | Should -BeIn $Builder.DataBinding.Keys
    }

    It 'returns a toast content builder to the pipeline when the PassThru switch is supplied' {
        $Builder = New-BTContentBuilder
        Add-BTDataBinding -ContentBuilder $Builder -Key 'Test' -Value 'Example' -PassThru | Should -BeOfType [Microsoft.Toolkit.Uwp.Notifications.ToastContentBuilder]
    }
}

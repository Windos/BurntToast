Describe 'Add-BTInputTextBox' {
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

    It 'adds a text box via a parameter' {
        InModuleScope BurntToast {
            $ImagePath = 'C:\Fake\Images\BurntToast.png'
            Mock Optimize-BTImageSource {return $ImagePath}

            $Builder = New-BTContentBuilder
            Add-BTImage -ContentBuilder $Builder -Source $ImagePath -AppLogo
            Add-BTInputTextBox -ContentBuilder $Builder -Id 'Example 01'


            # The resulting XML is as expected
            $ExpectedXML = '<?xml version="1.0"?><toast><visual><binding template="ToastGeneric"><image src="C:\Fake\Images\BurntToast.png" placement="appLogoOverride"/></binding></visual><actions><input id="Example 01" type="text" title="" placeHolderContent="" defaultInput=""/></actions></toast>'
            $Builder.GetXml().GetXml() | Should -BeExactly $ExpectedXML

            # There are no child elements
            $Builder.GetToastContent().Visual.BindingGeneric.Children | Should -HaveCount 0

            # There is one input
            $Builder.GetToastContent().Actions.Inputs | Should -HaveCount 1

            $Builder.GetToastContent().Actions.Inputs[0].Id                 | Should -BeExactly 'Example 01'
            $Builder.GetToastContent().Actions.Inputs[0].Title              | Should -BeNullOrEmpty
            $Builder.GetToastContent().Actions.Inputs[0].PlaceholderContent | Should -BeNullOrEmpty
            $Builder.GetToastContent().Actions.Inputs[0].DefaultInput       | Should -BeNullOrEmpty
        }
    }

    It 'adds a text box via the pipeline' {
        InModuleScope BurntToast {
            $ImagePath = 'C:\Fake\Images\BurntToast.png'
            Mock Optimize-BTImageSource {return $ImagePath}

            $Builder = New-BTContentBuilder
            $Builder | Add-BTImage -Source $ImagePath -AppLogo
            $Builder | Add-BTInputTextBox -Id 'Example 02'


            # The resulting XML is as expected
            $ExpectedXML = '<?xml version="1.0"?><toast><visual><binding template="ToastGeneric"><image src="C:\Fake\Images\BurntToast.png" placement="appLogoOverride"/></binding></visual><actions><input id="Example 02" type="text" title="" placeHolderContent="" defaultInput=""/></actions></toast>'
            $Builder.GetXml().GetXml() | Should -BeExactly $ExpectedXML

            # There are no child elements
            $Builder.GetToastContent().Visual.BindingGeneric.Children | Should -HaveCount 0

            # There is one input
            $Builder.GetToastContent().Actions.Inputs | Should -HaveCount 1

            $Builder.GetToastContent().Actions.Inputs[0].Id                 | Should -BeExactly 'Example 02'
            $Builder.GetToastContent().Actions.Inputs[0].Title              | Should -BeNullOrEmpty
            $Builder.GetToastContent().Actions.Inputs[0].PlaceholderContent | Should -BeNullOrEmpty
            $Builder.GetToastContent().Actions.Inputs[0].DefaultInput       | Should -BeNullOrEmpty
        }
    }

    It 'adds a text box with a title and placeholder' {
        InModuleScope BurntToast {
            $ImagePath = 'C:\Fake\Images\BurntToast.png'
            Mock Optimize-BTImageSource {return $ImagePath}

            $Builder = New-BTContentBuilder
            $Builder | Add-BTImage -Source $ImagePath -AppLogo
            $Builder | Add-BTInputTextBox -Id 'Example 03' -Title "Enter your name" -PlaceholderContent "John Doe"


            # The resulting XML is as expected
            $ExpectedXML = '<?xml version="1.0"?><toast><visual><binding template="ToastGeneric"><image src="C:\Fake\Images\BurntToast.png" placement="appLogoOverride"/></binding></visual><actions><input id="Example 03" type="text" title="Enter your name" placeHolderContent="John Doe" defaultInput=""/></actions></toast>'
            $Builder.GetXml().GetXml() | Should -BeExactly $ExpectedXML

            # There are no child elements
            $Builder.GetToastContent().Visual.BindingGeneric.Children | Should -HaveCount 0

            # There is one input
            $Builder.GetToastContent().Actions.Inputs | Should -HaveCount 1

            $Builder.GetToastContent().Actions.Inputs[0].Id                 | Should -BeExactly 'Example 03'
            $Builder.GetToastContent().Actions.Inputs[0].Title              | Should -BeExactly 'Enter your name'
            $Builder.GetToastContent().Actions.Inputs[0].PlaceholderContent | Should -BeExactly 'John Doe'
            $Builder.GetToastContent().Actions.Inputs[0].DefaultInput       | Should -BeNullOrEmpty
        }
    }

    It 'adds a text box with a placeholder and default text' {
        InModuleScope BurntToast {
            $ImagePath = 'C:\Fake\Images\BurntToast.png'
            Mock Optimize-BTImageSource {return $ImagePath}

            $Builder = New-BTContentBuilder
            $Builder | Add-BTImage -Source $ImagePath -AppLogo
            $Builder | Add-BTInputTextBox -Id 'Example 04' -PlaceholderContent "Enter your name" -DefaultContent "John Doe"


            # The resulting XML is as expected
            $ExpectedXML = '<?xml version="1.0"?><toast><visual><binding template="ToastGeneric"><image src="C:\Fake\Images\BurntToast.png" placement="appLogoOverride"/></binding></visual><actions><input id="Example 04" type="text" title="" placeHolderContent="Enter your name" defaultInput="John Doe"/></actions></toast>'
            $Builder.GetXml().GetXml() | Should -BeExactly $ExpectedXML

            # There are no child elements
            $Builder.GetToastContent().Visual.BindingGeneric.Children | Should -HaveCount 0

            # There is one input
            $Builder.GetToastContent().Actions.Inputs | Should -HaveCount 1

            $Builder.GetToastContent().Actions.Inputs[0].Id                 | Should -BeExactly 'Example 04'
            $Builder.GetToastContent().Actions.Inputs[0].Title              | Should -BeNullOrEmpty
            $Builder.GetToastContent().Actions.Inputs[0].PlaceholderContent | Should -BeExactly 'Enter your name'
            $Builder.GetToastContent().Actions.Inputs[0].DefaultInput       | Should -BeExactly 'John Doe'
        }
    }

    It 'adds a text box with a placeholder and default text' {
        $ImagePath = 'C:\Fake\Images\BurntToast.png'
        Mock Optimize-BTImageSource -ModuleName BurntToast {return $ImagePath}

        $Builder = New-BTContentBuilder
        $Builder | Add-BTImage -Source $ImagePath -AppLogo
        $Builder | Add-BTInputTextBox -Id 'Example 05 - First Name' -Title 'Set your name' -PlaceholderContent "Enter your first name" -DefaultContent "John"
        $Builder | Add-BTInputTextBox -Id 'Example 05 - Last Name' -PlaceholderContent "Enter your last name" -DefaultContent "Doe"


        # The resulting XML is as expected
        $ExpectedXML = '<?xml version="1.0"?><toast><visual><binding template="ToastGeneric"><image src="C:\Fake\Images\BurntToast.png" placement="appLogoOverride"/></binding></visual><actions><input id="Example 05 - First Name" type="text" title="Set your name" placeHolderContent="Enter your first name" defaultInput="John"/><input id="Example 05 - Last Name" type="text" title="" placeHolderContent="Enter your last name" defaultInput="Doe"/></actions></toast>'
        $Builder.GetXml().GetXml() | Should -BeExactly $ExpectedXML

        # There are no child elements
        $Builder.GetToastContent().Visual.BindingGeneric.Children | Should -HaveCount 0

        # There are two inputs
        $Builder.GetToastContent().Actions.Inputs | Should -HaveCount 2

        $Builder.GetToastContent().Actions.Inputs[0].Id                 | Should -BeExactly 'Example 05 - First Name'
        $Builder.GetToastContent().Actions.Inputs[0].Title              | Should -BeExactly 'Set your name'
        $Builder.GetToastContent().Actions.Inputs[0].PlaceholderContent | Should -BeExactly 'Enter your first name'
        $Builder.GetToastContent().Actions.Inputs[0].DefaultInput       | Should -BeExactly 'John'

        $Builder.GetToastContent().Actions.Inputs[1].Id                 | Should -BeExactly 'Example 05 - Last Name'
        $Builder.GetToastContent().Actions.Inputs[1].Title              | Should -BeNullOrEmpty
        $Builder.GetToastContent().Actions.Inputs[1].PlaceholderContent | Should -BeExactly 'Enter your last name'
        $Builder.GetToastContent().Actions.Inputs[1].DefaultInput       | Should -BeExactly 'Doe'
    }

    It 'writes a warning when too many text input boxes are added to a toast notification' {
        $ImagePath = 'C:\Fake\Images\BurntToast.png'
        Mock Optimize-BTImageSource -ModuleName BurntToast {return $ImagePath}
        Mock Write-Warning -ModuleName BurntToast {}

        $Builder = New-BTContentBuilder
        $Builder | Add-BTImage -Source $ImagePath -AppLogo
        $Builder | Add-BTInputTextBox -Id 'Box 1'
        $Builder | Add-BTInputTextBox -Id 'Box 2'
        $Builder | Add-BTInputTextBox -Id 'Box 3'
        $Builder | Add-BTInputTextBox -Id 'Box 4'
        $Builder | Add-BTInputTextBox -Id 'Box 5'
        $Builder | Add-BTInputTextBox -Id 'Box 6'

        Assert-MockCalled Write-Warning -ModuleName BurntToast -Times 1 -ParameterFilter {
            $Message -eq 'The max number of text and selection boxes (5) on the toast notification has been reached. You cannot add any more input boxes.'
        }

        # There are no child elements
        $Builder.GetToastContent().Visual.BindingGeneric.Children | Should -HaveCount 0

        # There are five inputs (the sixth was not added)
        $Builder.GetToastContent().Actions.Inputs | Should -HaveCount 5
    }

    It 'returns a toast content builder to the pipeline when the PassThru switch is supplied' {
        $Builder = New-BTContentBuilder
        $Builder | Add-BTInputTextBox -Id 'Box 1' -PassThru | Should -BeOfType [Microsoft.Toolkit.Uwp.Notifications.ToastContentBuilder]
    }
}

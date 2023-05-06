Describe 'Add-BTImage (Adaptive)' {
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

    It 'handles local image basic' {
        InModuleScope BurntToast {
            $ImagePath = 'C:\Fake\Images\BurntToast.png'

            Mock Optimize-BTImageSource {return $ImagePath}
            $Builder = New-BTContentBuilder
            $Builder | Add-BTImage -Source $ImagePath

            # The image path was past to the private function Optimize-BTImageSource
            Assert-MockCalled Optimize-BTImageSource -Times 1

            # The resulting XML is as expected
            $ExpectedXML = '<?xml version="1.0"?><toast><visual><binding template="ToastGeneric"><image src="C:\Fake\Images\BurntToast.png"/></binding></visual></toast>'
            $Builder.GetXml().GetXml() | Should -BeExactly $ExpectedXML

            # There is one child element
            $Builder.GetToastContent().Visual.BindingGeneric.Children | Should -HaveCount 1

            # The AppLogo:
            # + Has the correct source
            # + Does not have alt text
            # + Does not have Image Query marked
            # + Has the default crop setting
            $Builder.GetToastContent().Visual.BindingGeneric.Children[0].Source           | Should -BeExactly $ImagePath
            $Builder.GetToastContent().Visual.BindingGeneric.Children[0].AlternateText    | Should -BeNullOrEmpty
            $Builder.GetToastContent().Visual.BindingGeneric.Children[0].AddImageQuery    | Should -BeNullOrEmpty
            $Builder.GetToastContent().Visual.BindingGeneric.Children[0].HintRemoveMargin | Should -BeNullOrEmpty
            $Builder.GetToastContent().Visual.BindingGeneric.Children[0].HintCrop         | Should -BeExactly 'Default'
            $Builder.GetToastContent().Visual.BindingGeneric.Children[0].HintAlign        | Should -BeExactly 'Default'
        }
    }

    It 'handles network share image' {
        InModuleScope BurntToast {
            $ImageSrc = '\\FS01\Images$\NetworkImage.gif'
            $ImageDst = "$Env:TEMP\--FS01-Images$-NetworkImage.gif"

            Mock Optimize-BTImageSource {return $ImageDst}
            $Builder = New-BTContentBuilder
            $Builder | Add-BTImage -Source $ImageSrc

            # The image path was past to the private function Optimize-BTImageSource
            Assert-MockCalled Optimize-BTImageSource -Times 1

            # The resulting XML is as expected
            $ExpectedXML = '<?xml version="1.0"?><toast><visual><binding template="ToastGeneric"><image src="{0}"/></binding></visual></toast>' -f $ImageDst
            $Builder.GetXml().GetXml() | Should -BeExactly $ExpectedXML

            # There is one child element
            $Builder.GetToastContent().Visual.BindingGeneric.Children | Should -HaveCount 1

            # The AppLogo:
            # + Has the correct source
            # + Does not have alt text
            # + Does not have Image Query marked
            # + Has the default crop setting
            $Builder.GetToastContent().Visual.BindingGeneric.Children[0].Source           | Should -BeExactly $ImageDst
            $Builder.GetToastContent().Visual.BindingGeneric.Children[0].AlternateText    | Should -BeNullOrEmpty
            $Builder.GetToastContent().Visual.BindingGeneric.Children[0].AddImageQuery    | Should -BeNullOrEmpty
            $Builder.GetToastContent().Visual.BindingGeneric.Children[0].HintRemoveMargin | Should -BeNullOrEmpty
            $Builder.GetToastContent().Visual.BindingGeneric.Children[0].HintCrop         | Should -BeExactly 'Default'
            $Builder.GetToastContent().Visual.BindingGeneric.Children[0].HintAlign        | Should -BeExactly 'Default'
        }
    }

    It 'handles online image' {
        InModuleScope BurntToast {
            $ImageSrc = 'https://example.com/OnlineImage.jpeg'
            $ImageDst = "$Env:TEMP\https---example.com-OnlineImage.jpeg"

            Mock Optimize-BTImageSource {return $ImageDst}
            $Builder = New-BTContentBuilder
            $Builder | Add-BTImage -Source $ImageSrc

            # The image path was past to the private function Optimize-BTImageSource
            Assert-MockCalled Optimize-BTImageSource -Times 1

            # The resulting XML is as expected
            $ExpectedXML = '<?xml version="1.0"?><toast><visual><binding template="ToastGeneric"><image src="{0}"/></binding></visual></toast>' -f $ImageDst
            $Builder.GetXml().GetXml() | Should -BeExactly $ExpectedXML

            # There is one child element
            $Builder.GetToastContent().Visual.BindingGeneric.Children | Should -HaveCount 1

            # The AppLogo:
            # + Has the correct source
            # + Does not have alt text
            # + Does not have Image Query marked
            # + Has the default crop setting
            $Builder.GetToastContent().Visual.BindingGeneric.Children[0].Source           | Should -BeExactly $ImageDst
            $Builder.GetToastContent().Visual.BindingGeneric.Children[0].AlternateText    | Should -BeNullOrEmpty
            $Builder.GetToastContent().Visual.BindingGeneric.Children[0].AddImageQuery    | Should -BeNullOrEmpty
            $Builder.GetToastContent().Visual.BindingGeneric.Children[0].HintRemoveMargin | Should -BeNullOrEmpty
            $Builder.GetToastContent().Visual.BindingGeneric.Children[0].HintCrop         | Should -BeExactly 'Default'
            $Builder.GetToastContent().Visual.BindingGeneric.Children[0].HintAlign        | Should -BeExactly 'Default'
        }
    }

    It 'handles online image without cache' {
        InModuleScope BurntToast {
            $ImageSrc = 'https://example.com/OnlineImage.jpeg'
            $ImageDst = "$Env:TEMP\https---example.com-OnlineImage.jpeg"

            Mock Optimize-BTImageSource {return $ImageDst}
            $Builder = New-BTContentBuilder
            $Builder | Add-BTImage -Source $ImageSrc -IgnoreCache

            # The image path was past to the private function Optimize-BTImageSource with the ForceRefresh switch
            Assert-MockCalled Optimize-BTImageSource -Times 1 -ParameterFilter {$ForceRefresh -eq $true}

            # The resulting XML is as expected
            $ExpectedXML = '<?xml version="1.0"?><toast><visual><binding template="ToastGeneric"><image src="{0}"/></binding></visual></toast>' -f $ImageDst
            $Builder.GetXml().GetXml() | Should -BeExactly $ExpectedXML

            # There is one child element
            $Builder.GetToastContent().Visual.BindingGeneric.Children | Should -HaveCount 1

            # The AppLogo:
            # + Has the correct source
            # + Does not have alt text
            # + Does not have Image Query marked
            # + Has the default crop setting
            $Builder.GetToastContent().Visual.BindingGeneric.Children[0].Source           | Should -BeExactly $ImageDst
            $Builder.GetToastContent().Visual.BindingGeneric.Children[0].AlternateText    | Should -BeNullOrEmpty
            $Builder.GetToastContent().Visual.BindingGeneric.Children[0].AddImageQuery    | Should -BeNullOrEmpty
            $Builder.GetToastContent().Visual.BindingGeneric.Children[0].HintRemoveMargin | Should -BeNullOrEmpty
            $Builder.GetToastContent().Visual.BindingGeneric.Children[0].HintCrop         | Should -BeExactly 'Default'
            $Builder.GetToastContent().Visual.BindingGeneric.Children[0].HintAlign        | Should -BeExactly 'Default'
        }
    }

    It 'handles alternate text' {
        InModuleScope BurntToast {
            $ImagePath = 'C:\Fake\Images\BurntToast.png'

            Mock Optimize-BTImageSource {return $ImagePath}
            $Builder = New-BTContentBuilder
            $Builder | Add-BTImage -Source $ImagePath -AlternateText 'Picture of burnt toast, popped out of a toaster'

            # The image path was past to the private function Optimize-BTImageSource with the ForceRefresh switch
            Assert-MockCalled Optimize-BTImageSource -Times 1

            # The resulting XML is as expected
            $ExpectedXML = '<?xml version="1.0"?><toast><visual><binding template="ToastGeneric"><image src="{0}" alt="Picture of burnt toast, popped out of a toaster"/></binding></visual></toast>' -f $ImagePath
            $Builder.GetXml().GetXml() | Should -BeExactly $ExpectedXML

            # There is one child element
            $Builder.GetToastContent().Visual.BindingGeneric.Children | Should -HaveCount 1

            # The AppLogo:
            # + Has the correct source
            # + Has the correct alt text
            # + Does not have Image Query marked
            # + Has the default crop setting
            $Builder.GetToastContent().Visual.BindingGeneric.Children[0].Source           | Should -BeExactly $ImagePath
            $Builder.GetToastContent().Visual.BindingGeneric.Children[0].AlternateText    | Should -BeExactly 'Picture of burnt toast, popped out of a toaster'
            $Builder.GetToastContent().Visual.BindingGeneric.Children[0].AddImageQuery    | Should -BeNullOrEmpty
            $Builder.GetToastContent().Visual.BindingGeneric.Children[0].HintRemoveMargin | Should -BeNullOrEmpty
            $Builder.GetToastContent().Visual.BindingGeneric.Children[0].HintCrop         | Should -BeExactly 'Default'
            $Builder.GetToastContent().Visual.BindingGeneric.Children[0].HintAlign        | Should -BeExactly 'Default'
        }
    }

    It 'handles crop shape override' {
        InModuleScope BurntToast {
            $ImagePath = 'C:\Fake\Images\BurntToast.png'

            Mock Optimize-BTImageSource {return $ImagePath}
            $Builder = New-BTContentBuilder
            $Builder | Add-BTImage -Source $ImagePath -Crop Circle

            # The image path was past to the private function Optimize-BTImageSource with the ForceRefresh switch
            Assert-MockCalled Optimize-BTImageSource -Times 1

            # The resulting XML is as expected
            $ExpectedXML = '<?xml version="1.0"?><toast><visual><binding template="ToastGeneric"><image src="{0}" hint-crop="circle"/></binding></visual></toast>' -f $ImagePath
            $Builder.GetXml().GetXml() | Should -BeExactly $ExpectedXML

            # There is one child element
            $Builder.GetToastContent().Visual.BindingGeneric.Children | Should -HaveCount 1

            # The AppLogo:
            # + Has the correct source
            # + Has correct alt text
            # + Does not have Image Query marked
            # + Has the circle crop setting
            $Builder.GetToastContent().Visual.BindingGeneric.Children[0].Source           | Should -BeExactly $ImagePath
            $Builder.GetToastContent().Visual.BindingGeneric.Children[0].AlternateText    | Should -BeNullOrEmpty
            $Builder.GetToastContent().Visual.BindingGeneric.Children[0].AddImageQuery    | Should -BeNullOrEmpty
            $Builder.GetToastContent().Visual.BindingGeneric.Children[0].HintRemoveMargin | Should -BeNullOrEmpty
            $Builder.GetToastContent().Visual.BindingGeneric.Children[0].HintCrop         | Should -BeExactly 'Circle'
            $Builder.GetToastContent().Visual.BindingGeneric.Children[0].HintAlign        | Should -BeExactly 'Default'
        }
    }

    It 'handles crop shape override and alt text' {
        InModuleScope BurntToast {
            $ImagePath = 'C:\Fake\Images\BurntToast.png'

            Mock Optimize-BTImageSource {return $ImagePath}
            $Builder = New-BTContentBuilder
            $Builder | Add-BTImage -Source $ImagePath -Crop Circle -AlternateText 'Picture of burnt toast, popped out of a toaster'

            # The image path was past to the private function Optimize-BTImageSource with the ForceRefresh switch
            Assert-MockCalled Optimize-BTImageSource -Times 1

            # The resulting XML is as expected
            $ExpectedXML = '<?xml version="1.0"?><toast><visual><binding template="ToastGeneric"><image src="{0}" alt="Picture of burnt toast, popped out of a toaster" hint-crop="circle"/></binding></visual></toast>' -f $ImagePath
            $Builder.GetXml().GetXml() | Should -BeExactly $ExpectedXML

            # There is one child element
            $Builder.GetToastContent().Visual.BindingGeneric.Children | Should -HaveCount 1

            # The AppLogo:
            # + Has the correct source
            # + Has no alt text
            # + Does not have Image Query marked
            # + Has the circle crop setting
            $Builder.GetToastContent().Visual.BindingGeneric.Children[0].Source           | Should -BeExactly $ImagePath
            $Builder.GetToastContent().Visual.BindingGeneric.Children[0].AlternateText    | Should -BeExactly 'Picture of burnt toast, popped out of a toaster'
            $Builder.GetToastContent().Visual.BindingGeneric.Children[0].AddImageQuery    | Should -BeNullOrEmpty
            $Builder.GetToastContent().Visual.BindingGeneric.Children[0].HintRemoveMargin | Should -BeNullOrEmpty
            $Builder.GetToastContent().Visual.BindingGeneric.Children[0].HintCrop         | Should -BeExactly 'Circle'
            $Builder.GetToastContent().Visual.BindingGeneric.Children[0].HintAlign        | Should -BeExactly 'Default'
        }
    }

    It 'handles child elements and pass through pipelines' {
        InModuleScope BurntToast {
            $ImagePath = 'C:\Fake\Images\BurntToast.png'

            Mock Optimize-BTImageSource {return $ImagePath}
            $Builder = New-BTContentBuilder
            $Builder | Add-BTImage -Source $ImagePath -PassThru |
				       Add-BTText -Text 'First Line of Text' -PassThru |
				       Add-BTText -Text 'Second Line of Text'

            # The image path was past to the private function Optimize-BTImageSource with the ForceRefresh switch
            Assert-MockCalled Optimize-BTImageSource -Times 1

            # The resulting XML is as expected
            $ExpectedXML = '<?xml version="1.0"?><toast><visual><binding template="ToastGeneric"><image src="{0}"/><text>First Line of Text</text><text>Second Line of Text</text></binding></visual></toast>' -f $ImagePath
            $Builder.GetXml().GetXml() | Should -BeExactly $ExpectedXML

            # There are three child elements
            $Builder.GetToastContent().Visual.BindingGeneric.Children | Should -HaveCount 3

            # The AppLogo:
            # + Has the correct source
            # + Has no alt text
            # + Does not have Image Query marked
            # + Has the circle crop setting
            $Builder.GetToastContent().Visual.BindingGeneric.Children[0].Source           | Should -BeExactly $ImagePath
            $Builder.GetToastContent().Visual.BindingGeneric.Children[0].AlternateText    | Should -BeNullOrEmpty
            $Builder.GetToastContent().Visual.BindingGeneric.Children[0].AddImageQuery    | Should -BeNullOrEmpty
            $Builder.GetToastContent().Visual.BindingGeneric.Children[0].HintRemoveMargin | Should -BeNullOrEmpty
            $Builder.GetToastContent().Visual.BindingGeneric.Children[0].HintCrop         | Should -BeExactly 'Default'
            $Builder.GetToastContent().Visual.BindingGeneric.Children[0].HintAlign        | Should -BeExactly 'Default'
        }
    }

    It 'handles multiple images' {
        InModuleScope BurntToast {
            $ImagePath1 = 'C:\Fake\Images\BurntToast-First.png'
            $ImagePath2 = 'C:\Fake\Images\BurntToast-Second.png'

            Mock Optimize-BTImageSource {return $ImagePath1} -ParameterFilter { $Source -eq $ImagePath1 }
            Mock Optimize-BTImageSource {return $ImagePath2} -ParameterFilter { $Source -eq $ImagePath2 }
            $Builder = New-BTContentBuilder
            $Builder | Add-BTImage -Source $ImagePath1
            $Builder | Add-BTImage -Source $ImagePath2

            # The image path was past to the private function Optimize-BTImageSource
            Assert-MockCalled Optimize-BTImageSource -Times 1

            # The resulting XML is as expected
            $ExpectedXML = '<?xml version="1.0"?><toast><visual><binding template="ToastGeneric"><image src="C:\Fake\Images\BurntToast-First.png"/><image src="C:\Fake\Images\BurntToast-Second.png"/></binding></visual></toast>'
            $Builder.GetXml().GetXml() | Should -BeExactly $ExpectedXML

            # There is one child element
            $Builder.GetToastContent().Visual.BindingGeneric.Children | Should -HaveCount 2

            # The AppLogo:
            # + Has the correct source
            # + Does not have alt text
            # + Does not have Image Query marked
            # + Has the default crop setting
            $Builder.GetToastContent().Visual.BindingGeneric.Children[0].Source           | Should -BeExactly $ImagePath1
            $Builder.GetToastContent().Visual.BindingGeneric.Children[0].AlternateText    | Should -BeNullOrEmpty
            $Builder.GetToastContent().Visual.BindingGeneric.Children[0].AddImageQuery    | Should -BeNullOrEmpty
            $Builder.GetToastContent().Visual.BindingGeneric.Children[0].HintRemoveMargin | Should -BeNullOrEmpty
            $Builder.GetToastContent().Visual.BindingGeneric.Children[0].HintCrop         | Should -BeExactly 'Default'
            $Builder.GetToastContent().Visual.BindingGeneric.Children[0].HintAlign        | Should -BeExactly 'Default'

            $Builder.GetToastContent().Visual.BindingGeneric.Children[1].Source           | Should -BeExactly $ImagePath2
            $Builder.GetToastContent().Visual.BindingGeneric.Children[1].AlternateText    | Should -BeNullOrEmpty
            $Builder.GetToastContent().Visual.BindingGeneric.Children[1].AddImageQuery    | Should -BeNullOrEmpty
            $Builder.GetToastContent().Visual.BindingGeneric.Children[1].HintRemoveMargin | Should -BeNullOrEmpty
            $Builder.GetToastContent().Visual.BindingGeneric.Children[1].HintCrop         | Should -BeExactly 'Default'
            $Builder.GetToastContent().Visual.BindingGeneric.Children[1].HintAlign        | Should -BeExactly 'Default'
        }
    }
}

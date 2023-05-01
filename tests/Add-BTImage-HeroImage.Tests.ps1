Describe 'Add-BTImage (HeroImage)' {
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
            $Builder | Add-BTImage -Source $ImagePath -HeroImage

            # The image path was past to the private function Optimize-BTImageSource
            Assert-MockCalled Optimize-BTImageSource -Times 1

            # The resulting XML is as expected
            $ExpectedXML = '<?xml version="1.0"?><toast><visual><binding template="ToastGeneric"><image src="C:\Fake\Images\BurntToast.png" placement="hero"/></binding></visual></toast>'
            $Builder.GetXml().GetXml() | Should -BeExactly $ExpectedXML

            # There are no child elements
            $Builder.GetToastContent().Visual.BindingGeneric.Children | Should -HaveCount 0

            # The AppLogo:
            # + Has the correct source
            # + Does not have alt text
            # + Does not have Image Query marked
            # + Has the default crop setting
            $Builder.GetToastContent().Visual.BindingGeneric.HeroImage.Source        | Should -BeExactly $ImagePath
            $Builder.GetToastContent().Visual.BindingGeneric.HeroImage.AlternateText | Should -BeNullOrEmpty
            $Builder.GetToastContent().Visual.BindingGeneric.HeroImage.AddImageQuery | Should -BeNullOrEmpty
        }
    }

    It 'handles network share image' {
        InModuleScope BurntToast {
            $ImageSrc = '\\FS01\Images$\NetworkImage.gif'
            $ImageDst = "$Env:TEMP\--FS01-Images$-NetworkImage.gif"

            Mock Optimize-BTImageSource {return $ImageDst}
            $Builder = New-BTContentBuilder
            $Builder | Add-BTImage -Source $ImageSrc -HeroImage

            # The image path was past to the private function Optimize-BTImageSource
            Assert-MockCalled Optimize-BTImageSource -Times 1

            # The resulting XML is as expected
            $ExpectedXML = '<?xml version="1.0"?><toast><visual><binding template="ToastGeneric"><image src="{0}" placement="hero"/></binding></visual></toast>' -f $ImageDst
            $Builder.GetXml().GetXml() | Should -BeExactly $ExpectedXML

            # There are no child elements
            $Builder.GetToastContent().Visual.BindingGeneric.Children | Should -HaveCount 0

            # The AppLogo:
            # + Has the correct source
            # + Does not have alt text
            # + Does not have Image Query marked
            # + Has the default crop setting
            $Builder.GetToastContent().Visual.BindingGeneric.HeroImage.Source        | Should -BeExactly $ImageDst
            $Builder.GetToastContent().Visual.BindingGeneric.HeroImage.AlternateText | Should -BeNullOrEmpty
            $Builder.GetToastContent().Visual.BindingGeneric.HeroImage.AddImageQuery | Should -BeNullOrEmpty
        }
    }

    It 'handles online image' {
        InModuleScope BurntToast {
            $ImageSrc = 'https://example.com/OnlineImage.jpeg'
            $ImageDst = "$Env:TEMP\https---example.com-OnlineImage.jpeg"

            Mock Optimize-BTImageSource {return $ImageDst}
            $Builder = New-BTContentBuilder
            $Builder | Add-BTImage -Source $ImageSrc -HeroImage

            # The image path was past to the private function Optimize-BTImageSource
            Assert-MockCalled Optimize-BTImageSource -Times 1

            # The resulting XML is as expected
            $ExpectedXML = '<?xml version="1.0"?><toast><visual><binding template="ToastGeneric"><image src="{0}" placement="hero"/></binding></visual></toast>' -f $ImageDst
            $Builder.GetXml().GetXml() | Should -BeExactly $ExpectedXML

            # There are no child elements
            $Builder.GetToastContent().Visual.BindingGeneric.Children | Should -HaveCount 0

            # The AppLogo:
            # + Has the correct source
            # + Does not have alt text
            # + Does not have Image Query marked
            # + Has the default crop setting
            $Builder.GetToastContent().Visual.BindingGeneric.HeroImage.Source        | Should -BeExactly $ImageDst
            $Builder.GetToastContent().Visual.BindingGeneric.HeroImage.AlternateText | Should -BeNullOrEmpty
            $Builder.GetToastContent().Visual.BindingGeneric.HeroImage.AddImageQuery | Should -BeNullOrEmpty
        }
    }

    It 'handles online image without cache' {
        InModuleScope BurntToast {
            $ImageSrc = 'https://example.com/OnlineImage.jpeg'
            $ImageDst = "$Env:TEMP\https---example.com-OnlineImage.jpeg"

            Mock Optimize-BTImageSource {return $ImageDst}
            $Builder = New-BTContentBuilder
            $Builder | Add-BTImage -Source $ImageSrc -IgnoreCache -HeroImage

            # The image path was past to the private function Optimize-BTImageSource with the ForceRefresh switch
            Assert-MockCalled Optimize-BTImageSource -Times 1 -ParameterFilter {$ForceRefresh -eq $true}

            # The resulting XML is as expected
            $ExpectedXML = '<?xml version="1.0"?><toast><visual><binding template="ToastGeneric"><image src="{0}" placement="hero"/></binding></visual></toast>' -f $ImageDst
            $Builder.GetXml().GetXml() | Should -BeExactly $ExpectedXML

            # There are no child elements
            $Builder.GetToastContent().Visual.BindingGeneric.Children | Should -HaveCount 0

            # The AppLogo:
            # + Has the correct source
            # + Does not have alt text
            # + Does not have Image Query marked
            # + Has the default crop setting
            $Builder.GetToastContent().Visual.BindingGeneric.HeroImage.Source        | Should -BeExactly $ImageDst
            $Builder.GetToastContent().Visual.BindingGeneric.HeroImage.AlternateText | Should -BeNullOrEmpty
            $Builder.GetToastContent().Visual.BindingGeneric.HeroImage.AddImageQuery | Should -BeNullOrEmpty
        }
    }

    It 'handles alternate text' {
        InModuleScope BurntToast {
            $ImagePath = 'C:\Fake\Images\BurntToast.png'

            Mock Optimize-BTImageSource {return $ImagePath}
            $Builder = New-BTContentBuilder
            $Builder | Add-BTImage -Source $ImagePath -AlternateText 'Picture of burnt toast, popped out of a toaster' -HeroImage

            # The image path was past to the private function Optimize-BTImageSource with the ForceRefresh switch
            Assert-MockCalled Optimize-BTImageSource -Times 1

            # The resulting XML is as expected
            $ExpectedXML = '<?xml version="1.0"?><toast><visual><binding template="ToastGeneric"><image src="{0}" alt="Picture of burnt toast, popped out of a toaster" placement="hero"/></binding></visual></toast>' -f $ImagePath
            $Builder.GetXml().GetXml() | Should -BeExactly $ExpectedXML

            # There are no child elements
            $Builder.GetToastContent().Visual.BindingGeneric.Children | Should -HaveCount 0

            # The AppLogo:
            # + Has the correct source
            # + Has the correct alt text
            # + Does not have Image Query marked
            # + Has the default crop setting
            $Builder.GetToastContent().Visual.BindingGeneric.HeroImage.Source        | Should -BeExactly $ImagePath
            $Builder.GetToastContent().Visual.BindingGeneric.HeroImage.AlternateText | Should -BeExactly 'Picture of burnt toast, popped out of a toaster'
            $Builder.GetToastContent().Visual.BindingGeneric.HeroImage.AddImageQuery | Should -BeNullOrEmpty
        }
    }

    It 'handles child elements and pass through pipelines' {
        InModuleScope BurntToast {
            $ImagePath = 'C:\Fake\Images\BurntToast.png'

            Mock Optimize-BTImageSource {return $ImagePath}
            $Builder = New-BTContentBuilder
            $Builder | Add-BTImage -Source $ImagePath -PassThru -HeroImage |
				       Add-BTText -Text 'First Line of Text' -PassThru |
				       Add-BTText -Text 'Second Line of Text'

            # The image path was past to the private function Optimize-BTImageSource with the ForceRefresh switch
            Assert-MockCalled Optimize-BTImageSource -Times 1

            # The resulting XML is as expected
            $ExpectedXML = '<?xml version="1.0"?><toast><visual><binding template="ToastGeneric"><text>First Line of Text</text><text>Second Line of Text</text><image src="{0}" placement="hero"/></binding></visual></toast>' -f $ImagePath
            $Builder.GetXml().GetXml() | Should -BeExactly $ExpectedXML

            # There are two child elements
            $Builder.GetToastContent().Visual.BindingGeneric.Children | Should -HaveCount 2

            # The AppLogo:
            # + Has the correct source
            # + Has no alt text
            # + Does not have Image Query marked
            # + Has the circle crop setting
            $Builder.GetToastContent().Visual.BindingGeneric.HeroImage.Source        | Should -BeExactly $ImagePath
            $Builder.GetToastContent().Visual.BindingGeneric.HeroImage.AlternateText | Should -BeNullOrEmpty
            $Builder.GetToastContent().Visual.BindingGeneric.HeroImage.AddImageQuery | Should -BeNullOrEmpty
        }
    }
}

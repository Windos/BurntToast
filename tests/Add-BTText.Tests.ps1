Describe 'Add-BTText' {
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

    Context 'add one text element by parameter' {
        BeforeAll {
            $Builder = New-BTContentBuilder
            Add-BTText -ContentBuilder $Builder -Text 'First Line of Text'
        }

        It 'generates the expected XML' {
            $ExpectedXML = '<?xml version="1.0"?><toast><visual><binding template="ToastGeneric"><text>First Line of Text</text></binding></visual></toast>'
            $Builder.GetXml().GetXml() | Should -BeExactly $ExpectedXML
        }
        It 'has one text element' {
            $Builder.GetToastContent().Visual.BindingGeneric.Children | Should -HaveCount 1
        }
        It 'has no defined max line count' {
            $Builder.GetToastContent().Visual.BindingGeneric.Children[0].HintMaxLines | Should -BeNullOrEmpty
        }
    }

    Context 'add one text element by pipeline' {
        BeforeAll {
            $Builder = New-BTContentBuilder
            $Builder | Add-BTText -Text 'First Line of Text'
        }

        It 'generates the expected XML' {
            $ExpectedXML = '<?xml version="1.0"?><toast><visual><binding template="ToastGeneric"><text>First Line of Text</text></binding></visual></toast>'
            $Builder.GetXml().GetXml() | Should -BeExactly $ExpectedXML
        }
        It 'has one text element' {
            $Builder.GetToastContent().Visual.BindingGeneric.Children | Should -HaveCount 1
        }
        It 'has no defined max line count' {
            $Builder.GetToastContent().Visual.BindingGeneric.Children[0].HintMaxLines | Should -BeNullOrEmpty
        }
    }

    Context 'add two text elements with one function call' {
        BeforeAll {
            $Builder = New-BTContentBuilder
            $Builder | Add-BTText -Text 'First Line of Text', 'Second Line of Text'
        }

        It 'generates the expected XML' {
            $ExpectedXML = '<?xml version="1.0"?><toast><visual><binding template="ToastGeneric"><text>First Line of Text</text><text>Second Line of Text</text></binding></visual></toast>'
            $Builder.GetXml().GetXml() | Should -BeExactly $ExpectedXML
        }
        It 'has two text elements' {
            $Builder.GetToastContent().Visual.BindingGeneric.Children | Should -HaveCount 2
        }
        It 'neither element has defined max line count' {
            $Builder.GetToastContent().Visual.BindingGeneric.Children[0].HintMaxLines | Should -BeNullOrEmpty
            $Builder.GetToastContent().Visual.BindingGeneric.Children[1].HintMaxLines | Should -BeNullOrEmpty
        }
    }

    Context 'add two text elements with two function calls' {
        BeforeAll {
            $Builder = New-BTContentBuilder
            $Builder | Add-BTText -Text 'First Line of Text'
            $Builder | Add-BTText -Text 'Second Line of Text'
        }

        It 'generates the expected XML' {
            $ExpectedXML = '<?xml version="1.0"?><toast><visual><binding template="ToastGeneric"><text>First Line of Text</text><text>Second Line of Text</text></binding></visual></toast>'
            $Builder.GetXml().GetXml() | Should -BeExactly $ExpectedXML
        }
        It 'has two text elements' {
            $Builder.GetToastContent().Visual.BindingGeneric.Children | Should -HaveCount 2
        }
        It 'neither element has defined max line count' {
            $Builder.GetToastContent().Visual.BindingGeneric.Children[0].HintMaxLines | Should -BeNullOrEmpty
            $Builder.GetToastContent().Visual.BindingGeneric.Children[1].HintMaxLines | Should -BeNullOrEmpty
        }
    }

    Context 'add three text elements with three function calls piped together with PassThru parameter' {
        BeforeAll {
            $Builder = New-BTContentBuilder
            $Builder | Add-BTText -Text 'First Line of Text' -PassThru |
                       Add-BTText -Text 'Second Line of Text' -PassThru |
                       Add-BTText -Text 'Third Line of Text'
        }

        It 'generates the expected XML' {
            $ExpectedXML = '<?xml version="1.0"?><toast><visual><binding template="ToastGeneric"><text>First Line of Text</text><text>Second Line of Text</text><text>Third Line of Text</text></binding></visual></toast>'
            $Builder.GetXml().GetXml() | Should -BeExactly $ExpectedXML
        }
        It 'has three text elements' {
            $Builder.GetToastContent().Visual.BindingGeneric.Children | Should -HaveCount 3
        }
        It 'neither element has defined max line count' {
            $Builder.GetToastContent().Visual.BindingGeneric.Children[0].HintMaxLines | Should -BeNullOrEmpty
            $Builder.GetToastContent().Visual.BindingGeneric.Children[1].HintMaxLines | Should -BeNullOrEmpty
            $Builder.GetToastContent().Visual.BindingGeneric.Children[2].HintMaxLines | Should -BeNullOrEmpty
        }
    }

    Context 'attempting to add too many lines of text to a single toast' {
        It 'generates a warning and only ends up with three text elements' {
            $CaptureFile = "$PSScriptRoot\WarningContent-Text_Add-BTText_$((New-Guid).Guid).txt"
            $ExpectedWarning = 'The max lines of text \(4\) on the toast notification has been reached, extra lines have been ignored.'

            $Builder = New-BTContentBuilder
            $Builder | Add-BTText -Text 'First Line of Text'
            $Builder | Add-BTText -Text 'Second Line of Text'
            $Builder | Add-BTText -Text 'Third Line of Text'
            $Builder | Add-BTText -Text 'Fourth Line of Text' 3> $CaptureFile
            $CaptureFile | Should -FileContentMatchMultiline $ExpectedWarning

            Remove-Item $CaptureFile -Force

            $Builder.GetToastContent().Visual.BindingGeneric.Children | Should -HaveCount 3
        }
    }

    Context 'set first text element to maxlines 1, then add three more text elements' {
        BeforeAll {
            $Builder = New-BTContentBuilder
            $Builder | Add-BTText -Text 'First Line of Text' -MaxLines 1
            $Builder | Add-BTText -Text 'Second Line of Text',
                                        'Third Line of Text',
                                        'Fourth Line of Text'
        }

        It 'generates the expected XML' {
            $ExpectedXML = '<?xml version="1.0"?><toast><visual><binding template="ToastGeneric"><text hint-maxLines="1">First Line of Text</text><text>Second Line of Text</text><text>Third Line of Text</text><text>Fourth Line of Text</text></binding></visual></toast>'
            $Builder.GetXml().GetXml() | Should -BeExactly $ExpectedXML
        }
        It 'has four text elements' {
            $Builder.GetToastContent().Visual.BindingGeneric.Children | Should -HaveCount 4
        }
        It 'the first text element has a maxline of 1 set, another elements have defined max line count' {
            $Builder.GetToastContent().Visual.BindingGeneric.Children[0].HintMaxLines | Should -Be 1
            $Builder.GetToastContent().Visual.BindingGeneric.Children[1].HintMaxLines | Should -BeNullOrEmpty
            $Builder.GetToastContent().Visual.BindingGeneric.Children[2].HintMaxLines | Should -BeNullOrEmpty
            $Builder.GetToastContent().Visual.BindingGeneric.Children[3].HintMaxLines | Should -BeNullOrEmpty
        }
    }

    Context 'specify langauge' {
        BeforeAll {
            $Builder = New-BTContentBuilder
            $Builder | Add-BTText -Text 'First Line of Text' -Language 'en-NZ'
        }

        It 'picks up the specified language tag' {
            $Builder.Content.Visual.BindingGeneric.Children[0].Language | Should -BeExactly 'en-NZ'
        }
        It 'generates the expected XML' {
            $ExpectedXML = '<?xml version="1.0"?><toast><visual><binding template="ToastGeneric"><text lang="en-NZ">First Line of Text</text></binding></visual></toast>'
            $Builder.GetXml().GetXml() | Should -BeExactly $ExpectedXML
        }
    }

    Context 'attribution text' {
        BeforeAll {
            $Builder = New-BTContentBuilder
            $Builder | Add-BTText -Text 'Example Toast Source' -Attribution
        }

        It 'adds the attribution text' {
            $Builder.Content.Visual.BindingGeneric.Attribution.Text | Should -BeExactly 'Example Toast Source'
        }
        It 'generates the expected XML' {
            $ExpectedXML = '<?xml version="1.0"?><toast><visual><binding template="ToastGeneric"><text placement="attribution">Example Toast Source</text></binding></visual></toast>'
            $Builder.GetXml().GetXml() | Should -BeExactly $ExpectedXML
        }
        It 'writes a warning when overwriting attribution text' {
            $CaptureFile = New-TemporaryFile
            $ExpectedWarning = 'Attribution text can only be set once per toast notification. The existing attribution text will be overwritten.'

            $Builder | Add-BTText -Text 'New Example Toast Source' -Attribution 3> $CaptureFile
            $CaptureFile | Should -FileContentMatchExactly $ExpectedWarning

            Remove-Item $CaptureFile -Force
        }
        It 'writes a warning when providing two strings as attribution text' {
            $CaptureFile = New-TemporaryFile
            $ExpectedWarning = 'Attribution text can only contain a single string and more than one was provided. Only the first string will be used.'

            $Builder = New-BTContentBuilder
            $Builder | Add-BTText -Text 'Example Toast Source', 'New Example Toast Source' -Attribution 3> $CaptureFile
            $CaptureFile | Should -FileContentMatchExactly $ExpectedWarning

            Remove-Item $CaptureFile -Force
        }
        It 'generates the expected XML when adding a language hint' {
            $Builder | Add-BTText -Text 'Example Toast Source' -Attribution -Language 'en-NZ' 3> $null
            $ExpectedXML = '<?xml version="1.0"?><toast><visual><binding template="ToastGeneric"><text lang="en-NZ" placement="attribution">Example Toast Source</text></binding></visual></toast>'
            $Builder.GetXml().GetXml() | Should -BeExactly $ExpectedXML
        }
    }

    Context 'bindable string' {
        BeforeAll {
            $Builder = New-BTContentBuilder
            $Builder | Add-BTText -Text 'Placeholder String' -Bindable
        }

        It 'generates the expected XML' {
            $ExpectedXML = '<?xml version="1.0"?><toast><visual><binding template="ToastGeneric"><text>{Placeholder String}</text></binding></visual></toast>'
            $Builder.GetXml().GetXml() | Should -BeExactly $ExpectedXML
        }
        It 'has one text element' {
            $Builder.GetToastContent().Visual.BindingGeneric.Children | Should -HaveCount 1
        }
        It 'has no defined max line count' {
            $Builder.GetToastContent().Visual.BindingGeneric.Children[0].HintMaxLines | Should -BeNullOrEmpty
        }
    }

    Context 'bindable string with options' {
        BeforeAll {
            $Builder = New-BTContentBuilder
            $Builder | Add-BTText -Text 'First Placeholder String' -Bindable
            $Builder | Add-BTText -Text 'Second Placeholder String' -Bindable -MaxLines 1 -Language 'en-NZ'
        }

        It 'generates the expected XML' {
            $ExpectedXML = '<?xml version="1.0"?><toast><visual><binding template="ToastGeneric"><text>{First Placeholder String}</text><text lang="en-NZ" hint-maxLines="1">{Second Placeholder String}</text></binding></visual></toast>'
            $Builder.GetXml().GetXml() | Should -BeExactly $ExpectedXML
        }
        It 'has two text elements' {
            $Builder.GetToastContent().Visual.BindingGeneric.Children | Should -HaveCount 2
        }
        It 'the second text element has a maxline of 1 set, another elements have defined max line count' {
            $Builder.GetToastContent().Visual.BindingGeneric.Children[2].HintMaxLines | Should -BeNullOrEmpty
            $Builder.GetToastContent().Visual.BindingGeneric.Children[1].HintMaxLines | Should -Be 1
        }
    }

    Context 'bindable string with regular text' {
        BeforeAll {
            $Builder = New-BTContentBuilder
            $Builder | Add-BTText -Text 'First Line of Text'
            $Builder | Add-BTText -Text 'Placeholder String' -Bindable
        }

        It 'generates the expected XML' {
            $ExpectedXML = '<?xml version="1.0"?><toast><visual><binding template="ToastGeneric"><text>First Line of Text</text><text>{Placeholder String}</text></binding></visual></toast>'
            $Builder.GetXml().GetXml() | Should -BeExactly $ExpectedXML
        }
        It 'has two text elements' {
            $Builder.GetToastContent().Visual.BindingGeneric.Children | Should -HaveCount 2
        }
        It 'neither line has a defined max line count' {
            $Builder.GetToastContent().Visual.BindingGeneric.Children[0].HintMaxLines | Should -BeNullOrEmpty
            $Builder.GetToastContent().Visual.BindingGeneric.Children[1].HintMaxLines | Should -BeNullOrEmpty
        }
    }

    Context 'attempting to add too many lines of text to a single toast with mixed content' {
        It 'generates a warning and only ends up with three text elements' {
            $CaptureFile = "$PSScriptRoot\WarningContent-Text_Add-BTText_$((New-Guid).Guid).txt"
            $ExpectedWarning = 'The max lines of text \(4\) on the toast notification has been reached, extra lines have been ignored.'

            $Builder = New-BTContentBuilder
            $Builder | Add-BTText -Text 'First Line of Text'
            $Builder | Add-BTText -Text 'Second Line of Text'
            $Builder | Add-BTText -Text 'Third Line of Text' -Bindable
            $Builder | Add-BTText -Text 'Fourth Line of Text' -Bindable 3> $CaptureFile
            $CaptureFile | Should -FileContentMatchMultiline $ExpectedWarning

            Remove-Item $CaptureFile -Force

            $Builder.GetToastContent().Visual.BindingGeneric.Children | Should -HaveCount 3
        }
    }

    Context 'attempting to add too many lines of text to a single toast with only bindable strings' {
        It 'generates a warning and only ends up with three text elements' {
            $CaptureFile = "$PSScriptRoot\WarningContent-Text_Add-BTText_$((New-Guid).Guid).txt"
            $ExpectedWarning = 'The max lines of text \(4\) on the toast notification has been reached, extra lines have been ignored.'

            $Builder = New-BTContentBuilder
            $Builder | Add-BTText -Text 'First Line of Text' -Bindable
            $Builder | Add-BTText -Text 'Second Line of Text' -Bindable
            $Builder | Add-BTText -Text 'Third Line of Text' -Bindable
            $Builder | Add-BTText -Text 'Fourth Line of Text' -Bindable 3> $CaptureFile
            $CaptureFile | Should -FileContentMatchMultiline $ExpectedWarning

            Remove-Item $CaptureFile -Force

            $Builder.GetToastContent().Visual.BindingGeneric.Children | Should -HaveCount 3
        }
    }
}

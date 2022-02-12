Describe 'Optimize-BTImageSource' -Tag 'Private' {
    BeforeAll {
        . "$PSScriptRoot/../src/Private/Optimize-BTImageSource.ps1"
    }

    Context 'local files' {
        It 'accepts valid local file' {
            $ImagePath = Join-Path -Path (Get-Module BurntToast)[0].ModuleBase -ChildPath 'Images\BurntToast.png'
            Optimize-BTImageSource -Source $ImagePath | Should -BeExactly $ImagePath
        }

        It 'feedback about invalid local file' {
            $ImagePath = 'C:\Fake\Images\BurntToast.png'
            $CaptureFile = "$PSScriptRoot\WarningContent_Optimize-BTImageSource_$((New-Guid).Guid).txt"
            $ExpectedWarning = ("The image source '{0}' doesn't exist, failed back to icon." -f $ImagePath).Replace('\', '\\')

            Optimize-BTImageSource -Source $ImagePath 3> $CaptureFile

            $CaptureFile | Should -FileContentMatchMultiline $ExpectedWarning

            Remove-Item $CaptureFile -Force
        }
    }

    Context 'network files' {
        BeforeAll {
            Mock Copy-Item {}

            $ImageSrc = '\\FS01\Images$\NetworkImage.gif'
            $ImageDst = "$Env:TEMP\--FS01-Images$-NetworkImage.gif"
        }

        It 'copies the file if it is not currently cached' {
            Mock Test-Path {return $false}
            $Result = Optimize-BTImageSource -Source $ImageSrc

            $Result | Should -BeExactly $ImageDst
            Assert-MockCalled 'Test-Path' -Times 1 -Scope It
            Assert-MockCalled 'Copy-Item' -Times 1 -Scope It
        }

        It 'skips to output if it is already cached' {
            Mock Test-Path {return $true}
            $Result = Optimize-BTImageSource -Source $ImageSrc

            $Result | Should -BeExactly $ImageDst
            Assert-MockCalled 'Test-Path' -Times 1 -Scope It
            Assert-MockCalled 'Copy-Item' -Times 0 -Scope It
        }

        It 'overwrites the file if it is already cached but ForceRefresh switch is provided' {
            Mock Test-Path {return $true}
            $Result = Optimize-BTImageSource -Source $ImageSrc -ForceRefresh

            $Result | Should -BeExactly $ImageDst
            Assert-MockCalled 'Test-Path' -Times 1 -Scope It
            Assert-MockCalled 'Copy-Item' -Times 1 -Scope It
        }
    }

    Context 'online files' {
        BeforeAll {
            Mock Invoke-WebRequest {}

            $ImageSrc = 'https://example.com/OnlineImage.jpeg'
            $ImageDst = "$Env:TEMP\https---example.com-OnlineImage.jpeg"
        }

        It 'downloads the file if it is not currently cached' {
            Mock Test-Path {return $false}
            $Result = Optimize-BTImageSource -Source $ImageSrc

            $Result | Should -BeExactly $ImageDst
            Assert-MockCalled 'Test-Path' -Times 1 -Scope It
            Assert-MockCalled 'Invoke-WebRequest' -Times 1 -Scope It
        }

        It 'skips to output if it is already cached' {
            Mock Test-Path {return $true}
            $Result = Optimize-BTImageSource -Source $ImageSrc

            $Result | Should -BeExactly $ImageDst
            Assert-MockCalled 'Test-Path' -Times 1 -Scope It
            Assert-MockCalled 'Invoke-WebRequest' -Times 0 -Scope It
        }

        It 'overwrites the file if it is already cached but ForceRefresh switch is provided' {
            Mock Test-Path {return $true}
            $Result = Optimize-BTImageSource -Source $ImageSrc -ForceRefresh

            $Result | Should -BeExactly $ImageDst
            Assert-MockCalled 'Test-Path' -Times 1 -Scope It
            Assert-MockCalled 'Invoke-WebRequest' -Times 1 -Scope It
        }
    }
}

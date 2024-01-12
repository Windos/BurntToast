BeforeAll {
    if (Get-Module -Name 'BurntToast') {
        Remove-Module -Name 'BurntToast'
    }

    if ($ENV:BURNTTOAST_MODULE_ROOT) {
        Import-Module $ENV:BURNTTOAST_MODULE_ROOT -Force
    } else {
        Import-Module "$PSScriptRoot/../src/BurntToast.psd1" -Force
    }

    $ModuleRoot = (Get-Item (Get-Module 'BurntToast').Path).Directory.FullName
    $ImagePath = Resolve-Path -Path (Join-Path $ModuleRoot 'Images\BurntToast.png')
}

Describe 'New-BTImage' {
    Context 'standard image' {
        BeforeAll {
            Start-Transcript tmp.log
            try {
                New-BTImage -Source $ImagePath -WhatIf
            }
            finally {
                Stop-Transcript
                $Log = (Get-Content tmp.log).Where({ $_ -match "What if: " })
                Remove-Item tmp.log
            }
        }

        It 'has consitent WhatIf response' {
            $Expected = "What if: Performing the operation ""New-BTImage"" on target ""returning: [AdaptiveImage]:Source=$($ImagePath):AlternateText=:HintCrop=Default:HintRemoveMargin=False:HintAlign=Default:AddImageQuery=""."
            $Log | Should -Be $Expected
        }
    }

    Context 'application logo override' {
        BeforeAll {
            Start-Transcript tmp.log
            try {
                New-BTImage -Source $ImagePath -AppLogoOverride -Crop Circle -WhatIf
            }
            finally {
                Stop-Transcript
                $Log = (Get-Content tmp.log).Where({ $_ -match "What if: " })
                Remove-Item tmp.log
            }
        }

        It 'has consitent WhatIf response' {
            $Expected = "What if: Performing the operation ""New-BTImage"" on target ""returning: [ToastGenericAppLogo]:Source=$($ImagePath):AlternateText=:HintCrop=Circle:AddImageQuery=""."
            $Log | Should -Be $Expected
        }
    }

    Context 'hero image' {
        BeforeAll {
            Start-Transcript tmp.log
            try {
                New-BTImage -Source $ImagePath -HeroImage -WhatIf
            }
            finally {
                Stop-Transcript
                $Log = (Get-Content tmp.log).Where({ $_ -match "What if: " })
                Remove-Item tmp.log
            }
        }

        It 'has consitent WhatIf response' {
            $Expected = "What if: Performing the operation ""New-BTImage"" on target ""returning: [ToastGenericHeroImage]:Source=$($ImagePath):AlternateText=:AddImageQuery=""."
            $Log | Should -Be $Expected
        }
    }

    Context 'web based image' {
        BeforeAll {
            Start-Transcript tmp.log
            try {
                New-BTImage -Source https://raw.githubusercontent.com/Windos/BurntToast/main/Media/BurntToast.png -WhatIf
            }
            finally {
                Stop-Transcript
                $Log = (Get-Content tmp.log).Where({ $_ -match "What if: " })
                Remove-Item tmp.log
            }
        }

        It 'has consitent WhatIf response' {
            $Expected = "What if: Performing the operation ""New-BTImage"" on target ""returning: [AdaptiveImage]:Source=$($env:TEMP)\https---raw.githubusercontent.com-Windos-BurntToast-main-Media-BurntToast.png:AlternateText=:HintCrop=Default:HintRemoveMargin=False:HintAlign=Default:AddImageQuery=""."
            $Log | Should -Be $Expected
        }
    }
}

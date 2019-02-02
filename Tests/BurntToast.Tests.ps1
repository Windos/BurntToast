Import-Module "$PSScriptRoot/../BurntToast/BurntToast.psd1" -Force

Describe 'New-BurntToastNotification' {
    Context 'running without arguments' {
        It 'runs without errors' {
            { New-BurntToastNotification } | Should Not Throw
        }

        It 'does not return anything' {
            New-BurntToastNotification | Should BeNullOrEmpty
        }
    }
    Context 'running with arguments (Image)' {
        It 'runs without errors' {
            { New-BurntToastNotification -AppLogo 'https://raw.githubusercontent.com/Windos/BurntToast/master/Media/BurntToast-Logo.png' } | Should Not Throw
        }

        It 'does not return anything' {
            New-BurntToastNotification -AppLogo 'https://raw.githubusercontent.com/Windos/BurntToast/master/Media/BurntToast-Logo.png' | Should BeNullOrEmpty
        }
    }
}

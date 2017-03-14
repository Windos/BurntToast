Import-Module BurntToast

Describe 'Get-BTFunctionLevel' {
    Context 'running without arguments (Get-BTFunctionLevel)' {
        It 'runs without errors' {
            { Get-BTFunctionLevel } | Should Not Throw
        }
        
        It 'returns a string object' {
            Get-BTFunctionLevel | Should BeOfType System.String
        }
        
        It 'returns a valid string' {
            'Basic', 'Advanced' -contains (Get-BTFunctionLevel) | Should Be $true
        }
    }
}

Describe 'Set-BTFunctionLevel' {
    Mock Out-File {}
    Mock Write-Warning {}
    
    Context 'running without arguments (Set-BTFunctionLevel)' {
        It 'runs without errors' {
            { Set-BTFunctionLevel } | Should Not Throw
        }
        
        It 'does not return anything' {            Set-BTFunctionLevel | Should BeNullOrEmpty         }
        
        Set-BTFunctionLevel -FunctionLevel Basic
        
        It 'does not write changes to disk, when function level is already set to is Basic.' {            Set-BTFunctionLevel            Assert-MockCalled Out-File -Exactly 0 -Scope It        }
        
        Set-BTFunctionLevel -FunctionLevel Advanced
        
        It 'writes changes to disk, when function level is currently set to is Advanced.' {            Set-BTFunctionLevel            Assert-MockCalled Out-File -Exactly 1 -Scope It        }
    }
    
    Context 'running with basic function level specified (Set-BTFunctionLevel -FunctionLevel Basic)' {
        It 'runs without errors' {
            { Set-BTFunctionLevel -FunctionLevel Basic } | Should Not Throw
        }
        
        It 'does not return anything' {            Set-BTFunctionLevel -FunctionLevel Basic | Should BeNullOrEmpty         }
        
        Set-BTFunctionLevel -FunctionLevel Basic
        
        It 'does not write changes to disk, when function level is already set to is Basic.' {            Set-BTFunctionLevel -FunctionLevel Basic            Assert-MockCalled Out-File -Exactly 0 -Scope It        }
        
        Set-BTFunctionLevel -FunctionLevel Advanced
        
        It 'writes changes to disk, when function level is currently set to is Advanced.' {            Set-BTFunctionLevel -FunctionLevel Basic            Assert-MockCalled Out-File -Exactly 1 -Scope It        }
    }
    
    Context 'running with advanced function level specified (Set-BTFunctionLevel -FunctionLevel Advanced)' {
        It 'runs without errors' {
            { Set-BTFunctionLevel -FunctionLevel Advanced } | Should Not Throw
        }
        
        It 'does not return anything' {            Set-BTFunctionLevel -FunctionLevel Advanced | Should BeNullOrEmpty         }
        
        Set-BTFunctionLevel -FunctionLevel Advanced
        
        It 'does not write changes to disk, when function level is already set to is Advanced.' {            Set-BTFunctionLevel -FunctionLevel Advanced            Assert-MockCalled Out-File -Exactly 0 -Scope It        }
        
        Set-BTFunctionLevel -FunctionLevel Basic
        
        It 'writes changes to disk, when function level is currently set to is Basic.' {            Set-BTFunctionLevel -FunctionLevel Advanced            Assert-MockCalled Out-File -Exactly 1 -Scope It        }
    }
}

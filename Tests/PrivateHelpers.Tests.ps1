BeforeAll {
    # Import the module and dot-source private files directly
    $modulePath = "$PSScriptRoot/../src/BurntToast.psd1"
    if (Get-Module -Name 'BurntToast') {
        Remove-Module -Name 'BurntToast'
    }
    Import-Module $modulePath -Force

    . "$PSScriptRoot/../src/Private/Add-PipelineObject.ps1"
    . "$PSScriptRoot/../src/Private/Optimize-BTImageSource.ps1"
    . "$PSScriptRoot/../src/Private/Get-BTScriptBlockHash.ps1"
}

Describe 'Add-PipelineObject' {
    It 'passes objects and invokes process scriptblock' {
        $output = 1..3 | Add-PipelineObject -Process { return "done" }
        $output | Should -Contain 1
        $output | Should -Contain 2
        $output | Should -Contain 3
    }
}

Describe 'Optimize-BTImageSource' {
    Context 'with a valid local file' {
        It 'returns the correct FullName' {
            $tempFile = [System.IO.Path]::GetTempFileName()
            try {
                Optimize-BTImageSource -Source $tempFile | Should -Be $tempFile
            } finally {
                Remove-Item $tempFile -ErrorAction SilentlyContinue
            }
        }
    }
    Context 'with a non-existent file' {
        It 'warns and returns nothing' {
            $file = [System.IO.Path]::Combine($env:TEMP, [System.Guid]::NewGuid().ToString() + ".x")
            $result = Optimize-BTImageSource -Source $file
            $result | Should -BeNullOrEmpty
        }
    }
    Context 'with UNC and HTTP/HTTPS sources' {
        It 'would return a path containing the original remote reference' {
            # Mock Copy-Item/Invoke-WebRequest for safety and determinism
            Mock -CommandName Copy-Item
            Mock -CommandName Invoke-WebRequest
            # Pretend it's a UNC
            $unc = "\\server\share\img.png"
            $result = Optimize-BTImageSource -Source $unc
            $result | Should -Not -BeNullOrEmpty
            $result | Should -BeLike "$env:TEMP*"
            $result | Should -BeLike "*img.png"
            # Pretend it's HTTP
            $http = "http://example.com/img.png"
            $result2 = Optimize-BTImageSource -Source $http
            $result2 | Should -Not -BeNullOrEmpty
            $result2 | Should -BeLike "$env:TEMP*"
            $result2 | Should -BeLike "*img.png"
        }
    }
    Context 'with ForceRefresh' {
        It 'attempts to fetch even if file exists' {
            Mock -CommandName Copy-Item
            $unc = "\\server\share\img2.png"
            $existsPath = '{0}\{1}' -f $env:TEMP, ($unc -replace '/|:|\\', '-')
            Set-Content $existsPath "test"
            try {
                Optimize-BTImageSource -Source $unc -ForceRefresh | Should -Be $existsPath
            } finally {
                Remove-Item $existsPath -ErrorAction SilentlyContinue
            }
        }
    }
}
Describe 'Get-BTScriptBlockHash' {
    It 'returns a consistent hash for identical scriptblocks' {
        $sb1 = { Write-Host 'foo'; "bar" }
        $sb2 = { Write-Host 'foo'; "bar" }
        $hash1 = Get-BTScriptBlockHash $sb1
        $hash2 = Get-BTScriptBlockHash $sb2
        $hash1 | Should -BeExactly $hash2
    }
    It 'is whitespace-agnostic for logically identical scriptblocks' {
        $sb1 = {Write-Host    'foo';  "bar"}
        $sb2 = {
            Write-Host
                'foo'
            ;"bar"
        }
        $hash1 = Get-BTScriptBlockHash $sb1
        $hash2 = Get-BTScriptBlockHash $sb2
        $hash1 | Should -BeExactly $hash2
    }
    It 'distinguishes truly different scriptblocks' {
        $sb1 = { Write-Host 'foo' }
        $sb2 = { Write-Host 'bar' }
        Get-BTScriptBlockHash $sb1 | Should -Not -BeExactly (Get-BTScriptBlockHash $sb2)
    }
    It 'hashes scriptblocks containing only whitespace the same as empty' {
        $sb1 = { }
        $sb2 = {    }
        Get-BTScriptBlockHash $sb1 | Should -BeExactly (Get-BTScriptBlockHash $sb2)
    }
}
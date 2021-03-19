$moduleRoot = (Resolve-Path "$PSScriptRoot\..\..").Path

. "$PSScriptRoot\FileIntegrity.Exceptions.ps1"

Describe "Verifying integrity of module files" {
	Context "Validating PS1 Script files" {
		$allFiles = Get-ChildItem -Path $moduleRoot -Recurse -Filter "*.ps1" | Where-Object FullName -NotLike "$moduleRoot\tests\*"

		foreach ($file in $allFiles)
		{
			$name = $file.FullName.Replace("$moduleRoot\", '')

			It "[$name] Should have no trailing space" {
				($file | Select-String "\s$" | Where-Object { $_.Line.Trim().Length -gt 0} | Measure-Object).Count | Should Be 0
			}

			$tokens = $null
			$parseErrors = $null
			$ast = [System.Management.Automation.Language.Parser]::ParseFile($file.FullName, [ref]$tokens, [ref]$parseErrors)

			It "[$name] Should have no syntax errors" {
				$parseErrors | Should Be $Null
			}

			foreach ($command in $global:BannedCommands)
			{
				if ($global:MayContainCommand["$command"] -notcontains $file.Name)
				{
					It "[$name] Should not use $command" {
						$tokens | Where-Object Text -EQ $command | Should Be $null
					}
				}
			}

			It "[$name] Should not contain aliases" {
				$tokens | Where-Object TokenFlags -eq CommandName | Where-Object { Test-Path "alias:\$($_.Text)" } | Measure-Object | Select-Object -ExpandProperty Count | Should Be 0
			}
		}
	}

	Context "Validating help.txt help files" {
		$allFiles = Get-ChildItem -Path $moduleRoot -Recurse -Filter "*.help.txt" | Where-Object FullName -NotLike "$moduleRoot\tests\*"

		foreach ($file in $allFiles)
		{
			$name = $file.FullName.Replace("$moduleRoot\", '')

			It "[$name] Should have no trailing space" {
				($file | Select-String "\s$" | Where-Object { $_.Line.Trim().Length -gt 0 } | Measure-Object).Count | Should Be 0
			}
		}
	}
}
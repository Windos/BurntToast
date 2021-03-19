Describe "Validating the module manifest" {
	$moduleRoot = (Resolve-Path "$PSScriptRoot\..\..\src").Path
	$manifest = ((Get-Content "$moduleRoot\BurntToast.psd1") -join "`n") | Invoke-Expression

	Context "Basic resources validation" {
		It "Exports all functions in the public folder" {
			$files = Get-ChildItem "$moduleRoot\Public" -Recurse -File -Filter "*.ps1"
			$count = (Compare-Object -ReferenceObject $files.BaseName -DifferenceObject $manifest.FunctionsToExport).Count
			$count | Should be 0
		}

		It "Exports none of its internal functions" {
			$files = Get-ChildItem "$moduleRoot\Private" -Recurse -File -Filter "*.ps1"
			$files | Where-Object BaseName -In $manifest.FunctionsToExport | Should Be $null
		}
	}

	Context "Individual file validation" {
		It "The root module file exists" {
			Test-Path "$moduleRoot\$($manifest.RootModule)" | Should Be $true
		}

		foreach ($format in $manifest.FormatsToProcess)
		{
			It "The file $format should exist" {
				Test-Path "$moduleRoot\$format" | Should Be $true
			}
		}

		foreach ($type in $manifest.TypesToProcess)
		{
			It "The file $type should exist" {
				Test-Path "$moduleRoot\$type" | Should Be $true
			}
		}

		foreach ($assembly in $manifest.RequiredAssemblies)
		{
			It "The file $assembly should exist" {
				Test-Path "$moduleRoot\$assembly" | Should Be $true
			}
		}
	}
}
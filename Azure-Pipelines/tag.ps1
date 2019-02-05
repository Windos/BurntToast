$ReleaseVersion = Get-Content -Path $PSScriptRoot\..\Azure-Pipelines\release-version.txt
Write-Host "##vso[task.setvariable variable=RELEASETAG]$ReleaseVersion"
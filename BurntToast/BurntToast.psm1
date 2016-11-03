$PublicBasic  = @( Get-ChildItem -Path $PSScriptRoot\Public\Basic\*.ps1 -ErrorAction SilentlyContinue )
$PublicAdvanced  = @( Get-ChildItem -Path $PSScriptRoot\Public\Advanced\*.ps1 -ErrorAction SilentlyContinue )
$Private = @( Get-ChildItem -Path $PSScriptRoot\Private\*.ps1 -ErrorAction SilentlyContinue )
$Library = @( Get-ChildItem -Path $PSScriptRoot\lib\*.dll -Recurse -ErrorAction SilentlyContinue )

$Script:Config = Get-Content -Path $PSScriptRoot\config.json -ErrorAction SilentlyContinue | ConvertFrom-Json
$Script:DefaultImage = "$PSScriptRoot$($Script:Config.AppLogo)"

Foreach($Import in @($PublicBasic + $PublicAdvanced + $Private))
{
    Try
    {
        . $Import.FullName
    }
    Catch
    {
        Write-Error -Message "Failed to import function $($Import.FullName): $_"
    }
}

Foreach($Type in $Library)
{
    Try
    {
        Add-Type -Path $Type.FullName
    }
    Catch
    {
        Write-Error -Message "Failed to load library $($Type.FullName): $_"
    }
}

$ModuleMembers = $PublicBasic.BaseName

if ($Script:Config.FunctionLevel -eq 'Advanced')
{
    $ModuleMembers = $ModuleMembers + $PublicAdvanced.BaseName
}

Export-ModuleMember -Function $ModuleMembers

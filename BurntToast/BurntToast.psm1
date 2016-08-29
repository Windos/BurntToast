$Public  = @( Get-ChildItem -Path $PSScriptRoot\Public\*.ps1 -ErrorAction SilentlyContinue )
$Private = @( Get-ChildItem -Path $PSScriptRoot\Private\*.ps1 -ErrorAction SilentlyContinue )
$Library = @( Get-ChildItem -Path $PSScriptRoot\lib\*.ps1 -ErrorAction SilentlyContinue )

Foreach($Import in @($Public + $Private + $Library))
{
    Try
    {
        . $Import.fullname
    }
    Catch
    {
        Write-Error -Message "Failed to import function $($Import.FullName): $_"
    }
}

Export-ModuleMember -Function $Public.Basename

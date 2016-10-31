$Public  = @( Get-ChildItem -Path $PSScriptRoot\Public\*.ps1 -ErrorAction SilentlyContinue )
$Private = @( Get-ChildItem -Path $PSScriptRoot\Private\*.ps1 -ErrorAction SilentlyContinue )
$Library = @( Get-ChildItem -Path $PSScriptRoot\lib\ -Filter *.dll -Recurse -ErrorAction SilentlyContinue )

Foreach($Import in @($Public + $Private))
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

Export-ModuleMember -Function @($Public.BaseName)

$WinMajorVersion = (Get-CimInstance -ClassName Win32_OperatingSystem -Property Version).Version.Split('.')[0]

if ($WinMajorVersion -ge 10)
{
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
}
else
{
    throw 'This version of BurntToast will only work on Windows 10. If you would like to use BurntToast on Windows 8, please use version 0.4'
}  

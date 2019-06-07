Import-Module BurntToast

# check if chocolatey is installed and the commands are executeable
if (!(Get-Command choco -ErrorAction SilentlyContinue)) { 
    New-BurntToastNotification -Text "choco not available!"
    throw "choco.exe is required to run this script!"
}

# get a list of chocolatey packages that can be updated
$pkgs = choco outdated --ignore-pinned --ignore-unfound -r
$total = $pkgs.Count

if ($total -eq 0) {
  New-BurntToastNotification -Text "All Chocolatey packages are up-to-date!"
}
else {
    $pkgText = ""
    foreach ($package in $pkgs)
    {
        $pkgText += "$($package -split "\|" | Select-Object -First 1), "
    }
    
    # cut the list of entries after 103, else the New-BurntToastNotification will throw an MethodInvocationException
    if ($pkgText.Length -gt 103) {
        $pkgText = $pkgText.Substring(0, 100)
        $pkgText += "..."
    }
    New-BurntToastNotification -Text "There are $total package updates available:", $pkgText
}
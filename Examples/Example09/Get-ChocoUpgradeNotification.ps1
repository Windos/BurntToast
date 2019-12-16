Import-Module BurntToast

if (!(Get-Command choco -ErrorAction SilentlyContinue)) { 
  New-BurntToastNotification -Text "choco not available!"
  throw "choco.exe is required to run this script!"
}

$pkgs = choco outdated --ignore-pinned --ignore-unfound -r
$total = $pkgs.Count

if ($total.Count -eq 0) {
  New-BurntToastNotification -Text "all Chocolatey packages are up-to-date!"
}
else {
  $pkgText = ""
  $pkgs | % { $pkgText += "$($_ -split "\|" | Select-Object -First 1), " } 
  if ($pkgText.Length -gt 103) {
    $pkgText = $pkgText.Substring(0, 100)
    $pkgText += "..."
  }
  New-BurntToastNotification -Text "there are $total package updates available", $pkgText
}

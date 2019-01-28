$Destination = "8.8.8.8"
$ScriptBlock = {
	$TimesLooped = 0
	while ( $Duration -le $TimesLooped) {
		if ( Test-Connection -ComputerName $using:Destination -Count 1 -Quiet ) {
			New-BurntToastNotification -Text ($using:Destination + " is online"), ("Last checked :" + (Get-Date).ToString()) -UniqueIdentifier $using:Destination
		}#if
		else {
			New-BurntToastNotification -Text ($using:Destination + " is offline"), ("Last checked :" + (Get-Date).ToString()) -UniqueIdentifier $using:Destination
		}#else
		Start-Sleep -Seconds 5
		$TimesLooped++
	}#while
}#Scriptblock
Start-Job -Name $Destination -ScriptBlock $ScriptBlock
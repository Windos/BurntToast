#######################################################
# .Info
# Shows how to configure an (unsecured) http listener
# in the background to wait for and display as a toast
# a message received via an http call
#
#######################################################

$JobScript = {
    Import-Module BurntToast
    
    $Listener = [System.Net.HttpListener]::new()
    
    $Listener.Prefixes.Add("http://localhost:9000/")
    $Listener.Start()
    
    While ($True)
    {
        $context = $Listener.GetContext()
        $Reader = [System.IO.StreamReader]::new($context.Request.InputStream)
        $ReadObject = $Reader.ReadToEnd() | ConvertFrom-Json
        New-BurntToastNotification @ReadObject
        $context.Response.Close()
    }
}

$ToastJob = Start-Job -Name ToastJob -ScriptBlock $JobScript

$Body = @{
    Text = "Hello from API call!"
}

Invoke-RestMethod -Method Post -Body ($Body | ConvertTo-Json) -Uri "http://localhost:9000/"

$ToastJob | Stop-job

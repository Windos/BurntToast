#######################################################
# .Info
# Shows how to configure an (unsecured) http listener
# in the background to wait for and display as a toast
# a message received via an http call
#
#######################################################

$JobScript = {
    try
    {
    Import-Module BurntToast

    $Listener = [System.Net.HttpListener]::new()

    $Listener.Prefixes.Add("http://localhost:9000/")
    $Listener.Start()

    While ($True)
    {
        $context = $Listener.GetContext()
        $Reader = [System.IO.StreamReader]::new($context.Request.InputStream)
        $ReadJson = $Reader.ReadToEnd()
        if ($ReadJson -eq "Exit") {break}
        $ReadObject = $ReadJson | ConvertFrom-Json
        New-BurntToastNotification -Text $ReadObject.Text
        $context.Response.Close()
    }
    }
    catch
    {
        Write-Error $_
    }
    finally
    {
        $Listener.Stop()
        $Listener.Prefixes.Clear()
        $Listener.Close()
    }
}

$ToastJob = Start-Job -Name ToastJob -ScriptBlock $JobScript

$Body = @{
    Text = "Hello from API call!"
}

Invoke-RestMethod -Method Post -Body ($Body | ConvertTo-Json) -Uri "http://localhost:9000/"

# Causes shutdown of the listener
Invoke-RestMethod -Method Post -Body "Exit" -Uri "http://localhost:9000/"



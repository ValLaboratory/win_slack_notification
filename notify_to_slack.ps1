$scriptPath = $MyInvocation.MyCommand.Path
$s_path_parent = Split-Path -Parent $scriptPath
$content = Import-Csv "$s_path_parent\config\config.csv"
$config = $content | Group-Object -AsHashTable -AsString -Property Key

$notificationPayload = @{
    text = $args[0];
    username = "PowerShell BOT"; 
    #icon_url = "https://"
}


$bytes = [System.Text.Encoding]::UTF8.GetBytes((ConvertTo-Json $notificationPayload))
Invoke-RestMethod -Uri $config.slack_incoming_webhook_url.Value -Method Post -Body $bytes

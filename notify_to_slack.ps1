$notificationPayload = @{
    text = $args[0];
    username = "PowerShell BOT"; 
    #icon_url = "https://"
}


$bytes = [System.Text.Encoding]::UTF8.GetBytes((ConvertTo-Json $notificationPayload))
Invoke-RestMethod -Uri "https://hooks.slack.com/services/xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx" -Method Post -Body $bytes

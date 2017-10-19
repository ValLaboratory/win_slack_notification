Param(
  [string] $message,
  [string] $mention,
  [string] $sender="WinSlackNotification",
  [switch] $an_don,
  [switch] $emergency
)

$scriptPath = $MyInvocation.MyCommand.Path
$s_path_parent = Split-Path -Parent $scriptPath
$content = Import-Csv "$s_path_parent\config\config.csv"
$config = $content | Group-Object -AsHashTable -AsString -Property Key


$text=""
if( [String]::IsNullOrEmpty($mention) -eq $False) {
  $text += "<@"+$mention+">"
}
$text+=$message

$notificationPayload = @{
    text = $text;
    username = $sender; 
    #icon_url = "https://"
}

$bytes = [System.Text.Encoding]::UTF8.GetBytes((ConvertTo-Json $notificationPayload))
Invoke-RestMethod -Uri $config.slack_incoming_webhook_url.Value -Method Post -Body $bytes

# an_don




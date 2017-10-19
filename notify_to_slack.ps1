Param(
  [string] $message,
  [string] $mention,
  [string] $sender="WinSlackNotification",
  [switch] $andon,
  [switch] $emergency
)

begin
{
  function SendSlack
  {
    Param(
      [string] $text,
      [string] $sender
    )

    begin {}
    process
    {
      $notificationPayload = @{
          text = $text;
          username = $sender; 
          #icon_url = "https://";
      }
      $bytes = [System.Text.Encoding]::UTF8.GetBytes((ConvertTo-Json $notificationPayload))
      Invoke-RestMethod -Uri $config.slack_incoming_webhook_url.Value -Method Post -Body $bytes
    }
    end {

    }
  }

  $rc=0 
  $scriptPath = $MyInvocation.MyCommand.Path
  $s_path_parent = Split-Path -Parent $scriptPath
  $content = Import-Csv "$s_path_parent\config\config.csv"
  $config = $content | Group-Object -AsHashTable -AsString -Property Key
}

process
{
  #�o���f�[�V����
  if( [String]::IsNullOrEmpty($message) )
  {
    Write-Host "-message [���b�Z�[�W] ���w�肳��Ă��܂���B"
    $rc=1
    return
  }

  $text=""
  if(-Not [String]::IsNullOrEmpty($mention) )
  {
    $text += "<@"+$mention+">"
  }
  $text+=$message

  SendSlack -text $text -sender $sender

  # gasco: ����ǂ� ���g���ēd���f���Ƀ��b�Z�[�W�𗬂�
  if($andon)
  {
    $andon_text = "gasco: andon"
    if($emergency) {
      $andon_text += " �ً}"
    }  
    $andon_text += " "
    $andon_text += $message

    SendSlack -text $andon_text -sender $sender
  }
}

end
{
  exit $rc
}




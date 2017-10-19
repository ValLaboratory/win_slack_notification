REM powershell /c ./notify_to_slack.ps1 "煩"
powershell /c ./notify_to_slack.ps1 -mention "nayamo" -message "このメッセージはテスト投稿されています" -sender "TestBot"
REM powershell /c ./notify_to_slack.ps1 -mention "nayamo" -message "このメッセージはテスト投稿されています" -sender "TestBot" -andon -emergency

# win_slack_notification

## 必要環境
PowerShell 

以下のバージョンで動作確認
```PowerShell
C:\WINDOWS\system32> $HOST.version

Major  Minor  Build  Revision
-----  -----  -----  --------
5      1      15063  674
```

## 事前準備
Incoming Webhooks を使って通知したいSlackチャンネルの Webhook URL を取得する必要があります。
https://api.slack.com/incoming-webhooks  
[google検索](https://www.google.co.jp/search?q=slack+incoming+webhooks)

## インストール

 * 当リポジトリをクローンする
 * config/config.csv.def を config/config.csv にコピー
 * config/config.csv の `slack_incoming_webhook_url` の値を Webhook URL に書き換える

```CSV
Key,Value
slack_incoming_webhook_url,http://hogehoge
```
⬇️⬇️⬇️
```CSV
Key,Value
slack_incoming_webhook_url,https://hooks.slack.com/services/XXXXXXX/XXXXXXX/XXXXXXXXXXXXXXXXXXXXX
```

## メッセージを通知
```PowerShell
> .¥notify_to_slack.ps1 -message テスト
```

該当のチャンネルに`テスト` と表示されれば成功


## 通知オプション
 * `mention` `＠ユーザー名` を付加してメッセージを送信します
```PowerShell
> .¥notify_to_slack.ps1 -message テスト -mention [Slackユーザー名]
```
 * `sender` 通知者の名称を変更します。指定がない場合 "WinSlackNotification" となります。
```PowerShell
> .¥notify_to_slack.ps1 -message テスト -sender WindowsBot
``` 

 * `andon` 開発部のアンドン電光掲示板にメッセージを表示します
```PowerShell
> .¥notify_to_slack.ps1 -message テスト -andon
```

 * `andon` + `emergency` アンドン電光掲示板に`緊急`状態でメッセージを表示します
```PowerShell
> .¥notify_to_slack.ps1 -message テスト -andon -emergency
```

 








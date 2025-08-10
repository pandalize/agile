# Agile Development Setup Guide

## 🚀 Quick Start

### 1. 基本セットアップ

```bash
# 1. このディレクトリをGitリポジトリとして初期化
git init
git add .
git commit -m "Initial agile development setup"

# 2. GitHubリポジトリ作成・プッシュ
gh repo create pandalize/agile --private
git remote add origin https://github.com/pandalize/agile.git
git push -u origin main

# 3. GitHub Pages有効化（Settings > Pages > Deploy from a branch > main > /docs）
```

### 2. ラベル設定

リポジトリに以下のラベルを作成：

```bash
# 優先度
gh label create "priority/high" --color "d73a4a" --description "高優先度"
gh label create "priority/medium" --color "fbca04" --description "中優先度"  
gh label create "priority/low" --color "0e8a16" --description "低優先度"

# タイプ
gh label create "type/feature" --color "a2eeef" --description "新機能"
gh label create "type/bug" --color "d73a4a" --description "バグ修正"
gh label create "type/task" --color "7057ff" --description "作業・改善"
gh label create "type/epic" --color "3e4b9e" --description "大型機能"

# 見積もり
gh label create "estimate/1" --color "c5f015" --description "1ポイント"
gh label create "estimate/2" --color "c5f015" --description "2ポイント"
gh label create "estimate/3" --color "c5f015" --description "3ポイント"
gh label create "estimate/5" --color "c5f015" --description "5ポイント"
gh label create "estimate/8" --color "c5f015" --description "8ポイント"
gh label create "estimate/13" --color "c5f015" --description "13ポイント"

# ステータス  
gh label create "status/backlog" --color "ededed" --description "バックログ"
gh label create "status/todo" --color "fbca04" --description "TODO"
gh label create "status/in-progress" --color "0052cc" --description "進行中"
gh label create "status/review" --color "5319e7" --description "レビュー中"
gh label create "status/done" --color "0e8a16" --description "完了"
```

### 3. マイルストーン作成

```bash
# スプリント1作成（2週間後を期限に設定）
gh milestone create "Sprint 1" --due-date "2025-08-24" --description "First sprint - Setup and basic features"
```

### 4. プロジェクトボード作成

1. GitHubリポジトリ → Projects タブ → New project
2. Board view選択
3. カラム設定：Backlog, Todo, In Progress, Review, Done

### 5. Discord通知設定（オプション）

```bash
# Discord webhookをSecretに設定
gh secret set DISCORD_WEBHOOK_URL --body "https://discord.com/api/webhooks/YOUR_WEBHOOK_URL"
```

---

## 📋 日常の使い方

### Issue作成
1. New Issue → テンプレート選択（User Story/Bug Report/Task）
2. 必要な情報を入力（見積もりポイント必須）
3. 適切なラベル・マイルストーン・担当者を設定

### Sprint Planning
1. Backlogから次スプリントのIssueを選択
2. Milestoneを設定
3. Project Boardの"Todo"カラムに移動

### Daily Standup
1. Project Boardでタスクの進捗を更新
2. Issue statusラベルを実際の状況に合わせて変更
3. 新しく判明したタスクはIssue化

### Sprint Review
1. 完了したIssueをcloseして"Done"カラムに移動
2. 未完了Issueは次スプリントのMilestoneに移動
3. Burndown chartで振り返り

---

## 📊 バーンダウンチャート

### 自動実行
- **毎平日朝9時**: 自動でデータ収集・チャート更新
- **URL**: `https://pandalize.github.io/agile/burndown/`

### 手動実行
```bash
# 特定のマイルストーンのデータ更新
gh workflow run burndown.yml -f milestone_number=1
```

### データ構造
```json
{
  "milestone": {
    "number": 1,
    "title": "Sprint 1", 
    "due_on": "2025-08-24T00:00:00Z"
  },
  "daily_data": [
    {
      "date": "2025-08-10",
      "total_points": 21,
      "remaining_points": 18,
      "completed_points": 3
    }
  ]
}
```

---

## 🔧 カスタマイズ

### 見積もりポイントの変更
`.github/workflows/burndown.yml` の中で `estimate/` ラベルから数値を抽出している部分を編集

### 通知のカスタマイズ
Discord webhook部分を編集してSlackに変更、メッセージ内容をカスタマイズ

### チャートの見た目変更
`docs/burndown/index.html` のChart.js設定を編集

---

## 🚨 トラブルシューティング

### Actions が実行されない
- Repository Settings → Actions → General → "Allow all actions" に設定
- Contents: Write権限が設定されていることを確認

### チャートが表示されない
- GitHub Pages が有効化されていることを確認
- `docs/burndown/` フォルダにデータファイルが存在することを確認

### Discord通知が来ない
- Secret `DISCORD_WEBHOOK_URL` が正しく設定されていることを確認
- Discord server設定でWebhook URLが有効であることを確認

---

## 🎯 成功指標

- **スプリント計画精度**: 80%以上
- **バーンダウン可視化**: 毎日自動更新
- **チーム満足度**: 4.0/5.0以上（定期アンケート）
- **運用工数**: 週5時間以下

---

## 📚 参考リンク

- [GitHub Projects Documentation](https://docs.github.com/en/issues/planning-and-tracking-with-projects)
- [GitHub Actions Documentation](https://docs.github.com/en/actions)
- [Chart.js Documentation](https://www.chartjs.org/docs/)
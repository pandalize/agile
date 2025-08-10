# 🚀 Agile Development Management System

pandaizeチーム向けのGitHubベースアジャイル開発管理システム

## ✨ Features

- 📋 **Issue Templates**: User Story, Bug Report, Task用の構造化テンプレート
- 📊 **Burndown Charts**: GitHub Actionsによる自動バーンダウンチャート生成
- 🏃‍♂️ **Sprint Management**: Milestone + Project Boardでのスプリント管理
- 🔔 **Discord Notifications**: 進捗の自動通知
- 📈 **Velocity Tracking**: スプリント別のベロシティ計測

## 🎯 Recommended Tools

| Tool | Purpose | Cost | Learning Curve |
|------|---------|------|----------------|
| **GitHub Projects v2** | カンバン・スプリント管理 | 無料 | ⭐⭐⭐⭐ |
| **GitHub Actions** | 自動集計・レポート生成 | $0-10/月 | ⭐⭐ |
| **GitHub API** | カスタムダッシュボード | $5-30/月 | ⭐ |
| **Discord** | チーム通知・進捗共有 | 無料 | ⭐⭐⭐⭐⭐ |

## 🚀 Quick Start

詳細なセットアップ手順は [setup-guide.md](setup-guide.md) を参照してください。

```bash
# 1. リポジトリ初期化
git init
git add .
git commit -m "Initial agile setup"

# 2. GitHub リポジトリ作成
gh repo create pandalize/agile --private
git push -u origin main

# 3. ラベル・マイルストーン・プロジェクトボード作成
# (setup-guide.md参照)
```

## 📊 Burndown Chart

自動生成されるバーンダウンチャートは以下で確認できます：

**URL**: `https://pandalize.github.io/agile/burndown/`

- 毎平日朝9時に自動更新
- スプリント別の進捗可視化
- 理想線との比較表示

## 📋 Issue Management

### テンプレート種類
- **User Story** (`📋`): 機能開発用
- **Bug Report** (`🐛`): バグ修正用  
- **Task** (`⚙️`): 技術的作業用

### ラベル体系
```
優先度: priority/high, priority/medium, priority/low
種類: type/feature, type/bug, type/task, type/epic
見積もり: estimate/1, estimate/2, estimate/3, estimate/5, estimate/8
状態: status/backlog, status/todo, status/in-progress, status/review, status/done
```

## 🏃‍♂️ Sprint Workflow

### Sprint Planning
1. Backlog Grooming
2. Story Point見積もり
3. Sprint Goal設定
4. Milestone作成・Issue割り当て

### Daily Standup
1. Project Board確認
2. Issue status更新
3. Blocker特定・解決

### Sprint Review & Retrospective
1. Demo実施
2. Velocity測定
3. Burndown分析
4. Improvement Action決定

## 📈 Metrics & KPIs

- **Sprint計画精度**: 80%以上目標
- **Velocity安定性**: スプリント間変動±20%以内
- **Burndown健全性**: 理想線±10%以内での完了
- **Issue完了率**: スプリント内95%以上

## 🔧 Customization

システムは段階的にカスタマイズ可能：

### Phase 1: Basic (0-2週間)
- GitHub Projects v2 + Issue Templates
- 基本的なカンバン運用

### Phase 2: Automation (3-4週間)  
- GitHub Actions バーンダウン自動化
- Discord通知連携

### Phase 3: Advanced (2-3ヶ月)
- カスタムダッシュボード
- 予測分析・レポート機能

## 📚 Documentation

- [Detailed Tool Comparison](agile-tools-comparison.md)
- [Setup Guide](setup-guide.md)
- [GitHub Projects Best Practices](https://docs.github.com/en/issues/planning-and-tracking-with-projects/learning-about-projects/best-practices-for-projects)

## 🤝 Contributing

1. Issue作成（Bug報告・機能提案）
2. Fork & Pull Request
3. Discussion参加

## 📄 License

MIT License - 自由に使用・改変可能

---

**pandalize team** で効率的なアジャイル開発を実現しましょう！ 🎯
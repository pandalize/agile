# 🚀 アジャイル GitHub スイート

GitHub エコシステムで構築された完全なアジャイル開発管理システム

[![GitHub Pages](https://img.shields.io/badge/GitHub%20Pages-Live%20Demo-green)](https://pandalize.github.io/agile/)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

## ✨ Features

- 📋 **Issue Templates**: User Story, Bug Report, Task用の構造化テンプレート
- 📊 **Advanced Burndown Charts**: ベロシティ・完了予測付きインタラクティブチャート
- 👥 **Team Dashboard**: リアルタイムチーム状況・メトリクス・進捗概要
- 🏃‍♂️ **Sprint Management**: Milestone + Project Boardでのスプリント管理
- 🔔 **Discord Notifications**: 進捗の自動通知
- 📈 **Team Metrics**: 担当者別統計・週別進捗・自動メトリクス収集
- 🛠️ **One-Click Setup**: 自動化スクリプトで瞬時環境構築

## 🎯 Recommended Tools

| Tool | Purpose | Cost | Learning Curve |
|------|---------|------|----------------|
| **GitHub Projects v2** | カンバン・スプリント管理 | 無料 | ⭐⭐⭐⭐ |
| **GitHub Actions** | 自動集計・レポート生成 | $0-10/月 | ⭐⭐ |
| **GitHub API** | カスタムダッシュボード | $5-30/月 | ⭐ |
| **Discord** | チーム通知・進捗共有 | 無料 | ⭐⭐⭐⭐⭐ |

## 🚀 Quick Start

### 🆕 NPMパッケージ統合（推奨 - 自動更新対応）
```bash
# 1. あなたの開発プロジェクトで
cd your-project-directory

# 2. パッケージをインストール
npm install @pandalize/agile-github-suite

# 3. セットアップウィザード
npm run agile:wizard

# 4. または対話的セットアップ
npm run agile:setup

# 5. 更新時（自動）
npm run agile:update
```

**🎯 メリット:**
- ✅ **自動更新対応** - 最新機能を自動取得
- ✅ **バージョン管理** - semver準拠の安全な更新
- ✅ **設定保持** - カスタマイズを自動バックアップ・復元
- ✅ **簡単導入** - 1コマンドでセットアップ完了

### 🧙‍♂️ セットアップウィザード（GUI）
GUI で対話的にセットアップ：
```bash
# ブラウザでウィザードを開く
open docs/setup-wizard/index.html
```

### 🛠️ その他の統合方法

<details>
<summary>📁 ファイルコピー方式</summary>

```bash
# 既存プロジェクトに統合
cd your-project
git clone https://github.com/pandalize/agile.git agile-temp
cp -r agile-temp/.github ./
cp -r agile-temp/docs ./
rm -rf agile-temp

# セットアップ実行
./scripts/setup.sh -r your-org/your-repo -s "Sprint 1" -d 14
```

**デメリット:** 手動更新が必要
</details>

<details>
<summary>🔗 Git Submodule</summary>

```bash
cd your-project
git submodule add https://github.com/pandalize/agile.git agile-tools
git submodule update --init --recursive
./agile-tools/scripts/setup.sh -r your-org/your-repo -s "Sprint 1" -d 14

# 更新時
git submodule update --remote
```

**デメリット:** 操作が複雑
</details>

<details>
<summary>🍴 Fork & Standalone</summary>

```bash
# GitHubでフォーク後
git clone https://github.com/YOUR_USERNAME/agile.git
cd agile
./scripts/setup.sh -r your-org/your-repo -s "Sprint 1" -d 14
git remote add upstream https://github.com/pandalize/agile.git

# 更新時
git fetch upstream
git merge upstream/main
```

**デメリット:** 上流の更新が困難
</details>

## 💻 技術構成・設計思想

### 🎯 Core Technologies

| Layer | Technology | Purpose |
|-------|-----------|---------|
| **Frontend** | Vanilla JS + HTML5 + CSS3 | ダッシュボード・UI制御 |
| **Visualization** | Chart.js | バーンダウン・メトリクス可視化 |
| **Automation** | GitHub Actions (YAML) | データ収集・自動化 |
| **Setup** | Bash Scripts | ワンクリック環境構築 |
| **Data** | JSON + GitHub API | メトリクス・進捗データ |

### 🌟 なぜこの構成？

#### **✅ Web Standards First**
- **フレームワーク依存なし**: React・Vue等の重いライブラリ不使用
- **軽量・高速**: 最小限の依存関係、瞬時読み込み
- **長期保守性**: Web標準技術で10年後も動作保証

#### **🚀 GitHub Complete Integration**
- **追加インフラ不要**: サーバー・DB・ホスティング費用 $0
- **統合セキュリティ**: GitHub認証・権限管理を活用
- **CI/CD標準**: Actions で完全自動化

#### **🌍 Universal Compatibility**  
- **ブラウザ対応**: モダンブラウザすべてでネイティブ動作
- **学習コスト最小**: Web開発者なら即座に理解・カスタマイズ
- **OSS貢献**: 技術的障壁なし、誰でも参加可能

#### **📈 Enterprise Ready**
- **スケーラブル**: 小規模チーム〜大企業まで対応
- **カスタマイズ容易**: プラグイン・テーマ対応可能
- **セキュア**: GitHub Enterprise・SSO対応

### 🎯 競合比較

| 項目 | Agile GitHub Suite | Jira | Linear |
|------|-------------------|------|--------|
| **コスト** | $0 | $7-14/user/month | $8-16/user/month |
| **学習コスト** | ⭐⭐⭐⭐⭐ | ⭐⭐ | ⭐⭐⭐ |
| **技術依存** | Web標準のみ | Java・複雑 | React・Node.js |
| **保守性** | ⭐⭐⭐⭐⭐ | ⭐⭐ | ⭐⭐⭐ |
| **カスタマイズ** | ⭐⭐⭐⭐⭐ | ⭐⭐ | ⭐⭐⭐ |

## 📊 Burndown Chart

自動生成されるバーンダウンチャートは以下で確認できます：

**URL**: `https://pandalize.github.io/agile/burndown/`

- 毎平日朝9時に自動更新
- スプリント別の進捗可視化  
- 理想線との比較表示
- ベロシティ・完了予測計算

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

- [📊 Project Status & Strategy](project-status-and-strategy.md) - 現状、使い方、OSS戦略
- [🔧 Setup Guide](setup-guide.md) - 詳細セットアップ手順
- [⚖️ Tool Comparison](agile-tools-comparison.md) - ツール比較分析
- [📋 GitHub Projects Best Practices](https://docs.github.com/en/issues/planning-and-tracking-with-projects/learning-about-projects/best-practices-for-projects)

## 🚀 OSS Roadmap

このプロジェクトは **agile-github-suite** としてOSS化を予定：

### 🎯 Vision
GitHub完結・$0コストのフルアジャイル管理ツールとして、世界中の開発チームの生産性向上を支援

### 📅 Timeline
- **Phase 1** (4週間): MVP Release・Community Building
- **Phase 2** (8週間): GitHub Marketplace・Plugin Ecosystem  
- **Phase 3** (12週間): Enterprise Features・Global Expansion

詳細は [📊 Project Status & Strategy](project-status-and-strategy.md) を参照

## 🤝 Contributing

1. Issue作成（Bug報告・機能提案）
2. Fork & Pull Request  
3. Discussion参加
4. OSS化への貢献歓迎！

## 📄 License

MIT License - 自由に使用・改変・商用利用可能

---

**From pandalize team to global developers** - 効率的なアジャイル開発を世界へ！ 🌟
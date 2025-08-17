# 🤝 Contributing to Agile GitHub Suite

まず、このプロジェクトへの貢献に興味を持っていただき、ありがとうございます！  
あなたの貢献がこのツールを世界中の開発チームにとってより良いものにします。

## 🌟 貢献方法

### バグ報告
- [Issues](https://github.com/pandalize/agile/issues) でバグを報告
- 再現手順・期待する動作・実際の動作を詳細に記載
- 可能であればスクリーンショットも添付

### 機能提案
- [Issues](https://github.com/pandalize/agile/issues) で機能提案を作成
- なぜその機能が必要か、どう実装すべきかを説明
- 既存の類似機能との違いを明確化

### コード貢献
1. このリポジトリをフォーク
2. 新しいブランチを作成: `git checkout -b feature/amazing-feature`
3. 変更をコミット: `git commit -m 'Add amazing feature'`
4. ブランチにプッシュ: `git push origin feature/amazing-feature`
5. Pull Request を作成

## 📋 開発ガイドライン

### 🛠️ 技術スタック
- **Frontend**: Vanilla JavaScript (ES6+)、HTML5、CSS3
- **Build**: GitHub Actions、GitHub Pages
- **Package**: NPM、Node.js 14+
- **Style**: [Web Standards](https://www.w3.org/) 準拠

### 📁 プロジェクト構造
```
agile/
├── docs/                   # GitHub Pages content
│   ├── assets/
│   │   ├── css/           # Shared stylesheets
│   │   └── js/            # Shared JavaScript modules
│   ├── burndown/          # Burndown chart dashboard
│   ├── team-dashboard/    # Team metrics dashboard
│   └── setup-wizard/      # Setup wizard GUI
├── scripts/               # Automation & setup tools
├── cli/                   # NPM package CLI tools
├── .github/
│   ├── workflows/         # GitHub Actions
│   └── ISSUE_TEMPLATE/    # Issue templates
└── package.json          # NPM package configuration
```

### ✅ コーディング標準

#### JavaScript
- **ESLint**: [Airbnb Style Guide](https://github.com/airbnb/javascript) ベース
- **命名**: camelCase for variables/functions、PascalCase for classes
- **モジュール**: ES6 modules (`import`/`export`)
- **非同期**: `async`/`await` を `Promise.then()` より優先
- **コメント**: JSDoc形式で関数・クラスを文書化

```javascript
/**
 * Calculate team velocity based on completed story points
 * @param {Array<Issue>} issues - Array of completed issues
 * @param {number} sprintDays - Sprint duration in days
 * @returns {number} Velocity points per day
 */
function calculateVelocity(issues, sprintDays) {
    const totalPoints = issues.reduce((sum, issue) => sum + issue.points, 0);
    return totalPoints / sprintDays;
}
```

#### CSS
- **BEM methodology**: Block Element Modifier
- **CSS Grid/Flexbox**: モダンレイアウト手法
- **CSS Custom Properties**: 変数活用
- **Mobile First**: レスポンシブデザイン

```css
.dashboard {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
    gap: var(--spacing-lg);
}

.dashboard__card {
    padding: var(--spacing-md);
    border-radius: var(--radius-md);
}

.dashboard__card--featured {
    border: 2px solid var(--color-primary);
}
```

#### HTML
- **セマンティック HTML**: `<section>`, `<article>`, `<nav>`, `<main>`
- **アクセシビリティ**: ARIA labels、適切な heading hierarchy
- **Progressive Enhancement**: JavaScript無効でも基本機能動作

### 🧪 テスト

#### 単体テスト
- **フレームワーク**: Jest
- **カバレッジ**: 80%以上を目標
- **ファイル命名**: `*.test.js`

```bash
# テスト実行
npm test

# カバレッジ確認
npm run test:coverage
```

#### E2Eテスト
- **フレームワーク**: Playwright
- **テストシナリオ**: 主要ユーザーフロー

```bash
# E2Eテスト実行
npm run test:e2e
```

### 📚 ドキュメント

#### README更新
- 新機能追加時は README.md を更新
- スクリーンショット・使用例を含める
- 日本語・英語両方で記載

#### API ドキュメント
- 新しい関数・クラスは JSDoc で文書化
- 使用例とパラメータ説明を含める

#### 変更ログ
- 重要な変更は CHANGELOG.md に記録
- [Keep a Changelog](https://keepachangelog.com/) 形式

## 🚀 開発環境セットアップ

### 必要な環境
- Node.js 14+ & npm
- Git
- モダンブラウザ (Chrome, Firefox, Safari, Edge)

### セットアップ手順
```bash
# 1. リポジトリをフォーク・クローン
git clone https://github.com/your-username/agile.git
cd agile

# 2. 依存関係をインストール
npm install

# 3. 開発サーバー起動
npm run dev

# 4. テスト実行
npm test

# 5. 本番ビルド確認
npm run build
```

### 便利な NPM Scripts
```bash
npm run dev          # 開発サーバー起動
npm run build        # 本番ビルド
npm run test         # テスト実行
npm run test:watch   # テスト監視モード
npm run lint         # ESLint実行
npm run lint:fix     # ESLint自動修正
npm run format       # Prettier実行
```

## 🎯 Pull Request ガイドライン

### PR作成前チェックリスト
- [ ] テストがすべて通過
- [ ] ESLintエラーなし
- [ ] ドキュメント更新 (必要な場合)
- [ ] 変更内容が軽微でない場合はIssueで事前相談

### PR説明テンプレート
```markdown
## 📋 変更概要
何を変更したかを簡潔に説明

## 🎯 変更理由
なぜこの変更が必要かを説明

## ✅ テスト
- [ ] 単体テスト追加/更新
- [ ] 手動テスト実施
- [ ] E2Eテスト確認

## 📸 スクリーンショット
UI変更がある場合は Before/After を添付

## 🔗 関連Issue
Fixes #123
```

### レビュープロセス
1. **自動チェック**: CI/CD pipeline (tests, linting)
2. **コードレビュー**: メンテナーによるレビュー
3. **変更要求**: 必要に応じて修正依頼
4. **承認・マージ**: 問題なければメンテナーがマージ

## 👥 コミュニティ

### 💬 コミュニケーション
- **GitHub Issues**: バグ報告・機能提案
- **GitHub Discussions**: 質問・アイデア交換
- **Discord**: リアルタイム会話 ([招待リンク](https://discord.gg/agile-github-suite))
- **Twitter**: [@AgileGitHubSuite](https://twitter.com/AgileGitHubSuite)

### 🏆 貢献者認定
定期的に貢献してくださる方には以下の認定を行います：
- **Contributor**: コードまたはドキュメント貢献
- **Reviewer**: PRレビュー・品質管理
- **Maintainer**: プロジェクト運営・リリース管理
- **Champion**: コミュニティ活動・普及貢献

## 📜 行動規範

### 🤝 私たちの約束
すべての参加者が安全で協力的な環境で活動できるよう努めます。

### ✅ 推奨される行動
- 建設的なフィードバック
- 異なる意見の尊重
- 初心者への親切な指導
- プロジェクトの目標に焦点

### ❌ 禁止される行動
- ハラスメント・差別
- 個人攻撃・侮辱
- 公序良俗に反する内容
- スパム・宣伝

### 🚨 違反報告
行動規範違反を発見した場合は [conduct@agile-github-suite.com](mailto:conduct@agile-github-suite.com) まで報告してください。すべての報告は機密に扱われます。

## 🎉 はじめての貢献

初めて OSS に貢献する方向けの簡単な Issues には `good first issue` ラベルを付けています。

### おすすめの第一歩
1. **翻訳**: 他言語への翻訳
2. **ドキュメント改善**: typo修正・説明追加
3. **テスト追加**: 既存機能のテストカバレッジ向上
4. **UI/UX改善**: 小さな使いやすさ改善

### 質問がある場合
気軽に [Discussions](https://github.com/pandalize/agile/discussions) で質問してください。経験豊富なコントリビューターがサポートします。

---

## 📞 サポート

技術的な質問やサポートが必要な場合：
- [GitHub Discussions](https://github.com/pandalize/agile/discussions)
- [Discord Community](https://discord.gg/agile-github-suite)
- Email: [support@agile-github-suite.com](mailto:support@agile-github-suite.com)

あなたの貢献がオープンソースコミュニティをより良いものにします。  
ありがとうございます！ 🚀

---

*このドキュメントは [All Contributors](https://github.com/all-contributors/all-contributors) specification に準拠しています。*
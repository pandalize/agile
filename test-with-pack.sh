#!/bin/bash

echo "📦 npm packを使ったテスト"
echo "========================"
echo ""

# パッケージを作成
echo "1. パッケージをビルド..."
npm pack

# テスト用ディレクトリの作成
TEST_DIR=~/test-agile-pack
echo "2. テストディレクトリを作成: $TEST_DIR"
rm -rf $TEST_DIR
mkdir -p $TEST_DIR
cd $TEST_DIR

# package.jsonの初期化
echo "3. テストプロジェクトを初期化..."
npm init -y > /dev/null 2>&1

# ローカルパッケージをインストール
echo "4. ローカルパッケージをインストール..."
npm install ~/workspace/agile/pandalize-agile-github-suite-*.tgz

# テストファイルの作成と実行
echo "5. テストを実行..."
cat > test.js << 'EOF'
const agile = require('@pandalize/agile-github-suite');
console.log('✅ Package loaded successfully!');
console.log('📦 Package info:', agile);
EOF

node test.js

# クリーンアップ
echo ""
echo "6. クリーンアップ..."
cd ~/workspace/agile
rm -f pandalize-agile-github-suite-*.tgz
echo "✨ テスト完了!"
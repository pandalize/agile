#!/bin/bash

# 🚀 Agile GitHub Suite - One-Click Setup Script
# このスクリプトでラベル・マイルストーン・プロジェクトを一括作成

set -e  # エラー時に停止

# カラー出力定義
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# ヘルプ表示
show_help() {
    echo -e "${CYAN}🚀 Agile GitHub Suite Setup Script${NC}"
    echo ""
    echo "Usage: $0 [OPTIONS]"
    echo ""
    echo "Options:"
    echo "  -r, --repo REPO     GitHub repository (format: owner/repo)"
    echo "  -s, --sprint NAME   Sprint name (default: Sprint 1)"
    echo "  -d, --days DAYS     Sprint duration in days (default: 14)"
    echo "  -h, --help          Show this help message"
    echo ""
    echo "Example:"
    echo "  $0 -r pandalize/agile -s \"Sprint 1\" -d 14"
    echo ""
}

# デフォルト値
REPO=""
SPRINT_NAME="Sprint 1"
SPRINT_DAYS=14

# 引数解析
while [[ $# -gt 0 ]]; do
    case $1 in
        -r|--repo)
            REPO="$2"
            shift 2
            ;;
        -s|--sprint)
            SPRINT_NAME="$2"
            shift 2
            ;;
        -d|--days)
            SPRINT_DAYS="$2"
            shift 2
            ;;
        -h|--help)
            show_help
            exit 0
            ;;
        *)
            echo -e "${RED}❌ Unknown option: $1${NC}"
            show_help
            exit 1
            ;;
    esac
done

# リポジトリチェック
if [ -z "$REPO" ]; then
    echo -e "${RED}❌ Repository is required. Use -r option.${NC}"
    show_help
    exit 1
fi

# GitHub CLI認証チェック
if ! gh auth status >/dev/null 2>&1; then
    echo -e "${RED}❌ GitHub CLI is not authenticated. Please run 'gh auth login' first.${NC}"
    exit 1
fi

# 期限日計算
DUE_DATE=$(date -d "+${SPRINT_DAYS} days" +"%Y-%m-%d" 2>/dev/null || date -v +${SPRINT_DAYS}d +"%Y-%m-%d" 2>/dev/null || echo "")

echo -e "${CYAN}🚀 Setting up Agile GitHub Suite...${NC}"
echo -e "${BLUE}📁 Repository: ${REPO}${NC}"
echo -e "${BLUE}📅 Sprint: ${SPRINT_NAME}${NC}"
echo -e "${BLUE}⏰ Duration: ${SPRINT_DAYS} days${NC}"
echo -e "${BLUE}📍 Due Date: ${DUE_DATE}${NC}"
echo ""

# 1. ラベル作成
echo -e "${YELLOW}🏷️  Creating labels...${NC}"

# 優先度ラベル
gh label create "priority/high" --color "d73a4a" --description "高優先度" --repo "$REPO" 2>/dev/null && echo -e "${GREEN}✓${NC} priority/high" || echo -e "${YELLOW}⚠${NC} priority/high (already exists)"
gh label create "priority/medium" --color "fbca04" --description "中優先度" --repo "$REPO" 2>/dev/null && echo -e "${GREEN}✓${NC} priority/medium" || echo -e "${YELLOW}⚠${NC} priority/medium (already exists)"
gh label create "priority/low" --color "0e8a16" --description "低優先度" --repo "$REPO" 2>/dev/null && echo -e "${GREEN}✓${NC} priority/low" || echo -e "${YELLOW}⚠${NC} priority/low (already exists)"

# タイプラベル
gh label create "type/feature" --color "a2eeef" --description "新機能" --repo "$REPO" 2>/dev/null && echo -e "${GREEN}✓${NC} type/feature" || echo -e "${YELLOW}⚠${NC} type/feature (already exists)"
gh label create "type/bug" --color "d73a4a" --description "バグ修正" --repo "$REPO" 2>/dev/null && echo -e "${GREEN}✓${NC} type/bug" || echo -e "${YELLOW}⚠${NC} type/bug (already exists)"
gh label create "type/task" --color "7057ff" --description "作業・改善" --repo "$REPO" 2>/dev/null && echo -e "${GREEN}✓${NC} type/task" || echo -e "${YELLOW}⚠${NC} type/task (already exists)"
gh label create "type/epic" --color "3e4b9e" --description "大型機能" --repo "$REPO" 2>/dev/null && echo -e "${GREEN}✓${NC} type/epic" || echo -e "${YELLOW}⚠${NC} type/epic (already exists)"

# 見積もりラベル
gh label create "estimate/1" --color "c5f015" --description "1ポイント" --repo "$REPO" 2>/dev/null && echo -e "${GREEN}✓${NC} estimate/1" || echo -e "${YELLOW}⚠${NC} estimate/1 (already exists)"
gh label create "estimate/2" --color "c5f015" --description "2ポイント" --repo "$REPO" 2>/dev/null && echo -e "${GREEN}✓${NC} estimate/2" || echo -e "${YELLOW}⚠${NC} estimate/2 (already exists)"
gh label create "estimate/3" --color "c5f015" --description "3ポイント" --repo "$REPO" 2>/dev/null && echo -e "${GREEN}✓${NC} estimate/3" || echo -e "${YELLOW}⚠${NC} estimate/3 (already exists)"
gh label create "estimate/5" --color "c5f015" --description "5ポイント" --repo "$REPO" 2>/dev/null && echo -e "${GREEN}✓${NC} estimate/5" || echo -e "${YELLOW}⚠${NC} estimate/5 (already exists)"
gh label create "estimate/8" --color "c5f015" --description "8ポイント" --repo "$REPO" 2>/dev/null && echo -e "${GREEN}✓${NC} estimate/8" || echo -e "${YELLOW}⚠${NC} estimate/8 (already exists)"
gh label create "estimate/13" --color "c5f015" --description "13ポイント" --repo "$REPO" 2>/dev/null && echo -e "${GREEN}✓${NC} estimate/13" || echo -e "${YELLOW}⚠${NC} estimate/13 (already exists)"

# ステータスラベル
gh label create "status/backlog" --color "ededed" --description "バックログ" --repo "$REPO" 2>/dev/null && echo -e "${GREEN}✓${NC} status/backlog" || echo -e "${YELLOW}⚠${NC} status/backlog (already exists)"
gh label create "status/todo" --color "fbca04" --description "TODO" --repo "$REPO" 2>/dev/null && echo -e "${GREEN}✓${NC} status/todo" || echo -e "${YELLOW}⚠${NC} status/todo (already exists)"
gh label create "status/in-progress" --color "0052cc" --description "進行中" --repo "$REPO" 2>/dev/null && echo -e "${GREEN}✓${NC} status/in-progress" || echo -e "${YELLOW}⚠${NC} status/in-progress (already exists)"
gh label create "status/review" --color "5319e7" --description "レビュー中" --repo "$REPO" 2>/dev/null && echo -e "${GREEN}✓${NC} status/review" || echo -e "${YELLOW}⚠${NC} status/review (already exists)"
gh label create "status/done" --color "0e8a16" --description "完了" --repo "$REPO" 2>/dev/null && echo -e "${GREEN}✓${NC} status/done" || echo -e "${YELLOW}⚠${NC} status/done (already exists)"

echo ""

# 2. マイルストーン作成
echo -e "${YELLOW}🎯 Creating milestone...${NC}"

MILESTONE_DESC="Sprint for agile development - Setup and initial implementation"
if [ -n "$DUE_DATE" ]; then
    gh milestone create "$SPRINT_NAME" --due-date "$DUE_DATE" --description "$MILESTONE_DESC" --repo "$REPO" 2>/dev/null && echo -e "${GREEN}✓${NC} Milestone: $SPRINT_NAME (due: $DUE_DATE)" || echo -e "${YELLOW}⚠${NC} Milestone already exists"
else
    gh milestone create "$SPRINT_NAME" --description "$MILESTONE_DESC" --repo "$REPO" 2>/dev/null && echo -e "${GREEN}✓${NC} Milestone: $SPRINT_NAME" || echo -e "${YELLOW}⚠${NC} Milestone already exists"
fi

echo ""

# 3. サンプルIssue作成
echo -e "${YELLOW}📋 Creating sample issues...${NC}"

# User Story サンプル
STORY_BODY="**User Story**: As a team member, I want to see our sprint progress visually so that I can track velocity and identify blockers early.

**Acceptance Criteria**:
- [ ] Burndown chart displays current sprint data
- [ ] Chart updates daily automatically via GitHub Actions
- [ ] Team can access via GitHub Pages URL
- [ ] Historical sprint data is preserved for retrospectives
- [ ] Velocity and completion prediction are calculated

**Story Points**: 5

**Technical Notes**:
- Uses Chart.js for visualization
- GitHub Actions for data collection
- JSON storage for historical data"

gh issue create --title "[Story] Setup automated burndown dashboard" \
    --body "$STORY_BODY" \
    --label "type/feature,estimate/5,priority/high,status/backlog" \
    --milestone "$SPRINT_NAME" \
    --repo "$REPO" >/dev/null 2>&1 && echo -e "${GREEN}✓${NC} Sample User Story created"

# Task サンプル  
TASK_BODY="**Description**: Configure GitHub repository with proper labels, milestones, and project board for effective agile development workflow.

**Acceptance Criteria**:
- [ ] All required labels created (priority, type, estimate, status)
- [ ] Sprint milestone configured with proper due date
- [ ] Project board set up with kanban columns
- [ ] Team members added as collaborators
- [ ] GitHub Pages enabled for burndown charts

**Technical Notes**:
- Use setup script for automation
- Verify GitHub Actions permissions
- Test burndown chart generation"

gh issue create --title "[Task] Repository setup and configuration" \
    --body "$TASK_BODY" \
    --label "type/task,estimate/2,priority/high,status/backlog" \
    --milestone "$SPRINT_NAME" \
    --repo "$REPO" >/dev/null 2>&1 && echo -e "${GREEN}✓${NC} Sample Task created"

# Bug Report サンプル
BUG_BODY="**Bug Description**: Burndown chart may not display correctly on mobile devices due to responsive design issues.

**Steps to Reproduce**:
1. Open burndown chart on mobile browser
2. Navigate to chart section
3. Observe layout issues

**Expected Behavior**: Chart should be fully visible and interactive on mobile

**Actual Behavior**: Chart may be cut off or difficult to interact with

**Environment**:
- Device: Mobile phone
- Browser: Safari/Chrome mobile
- Screen size: < 768px"

gh issue create --title "[Bug] Mobile responsive issues in burndown chart" \
    --body "$BUG_BODY" \
    --label "type/bug,estimate/3,priority/medium,status/backlog" \
    --milestone "$SPRINT_NAME" \
    --repo "$REPO" >/dev/null 2>&1 && echo -e "${GREEN}✓${NC} Sample Bug Report created"

echo ""

# 4. 次のステップ案内
echo -e "${GREEN}🎉 Setup completed successfully!${NC}"
echo ""
echo -e "${CYAN}📋 Next Steps:${NC}"
echo -e "${BLUE}1.${NC} Create Project Board:"
echo -e "   ${PURPLE}→${NC} Go to: https://github.com/$REPO/projects"
echo -e "   ${PURPLE}→${NC} Click 'New project' → Board view"
echo -e "   ${PURPLE}→${NC} Add columns: Backlog, Todo, In Progress, Review, Done"
echo ""
echo -e "${BLUE}2.${NC} Enable GitHub Pages:"
echo -e "   ${PURPLE}→${NC} Go to: https://github.com/$REPO/settings/pages"
echo -e "   ${PURPLE}→${NC} Source: Deploy from a branch"
echo -e "   ${PURPLE}→${NC} Branch: main, Folder: /docs"
echo ""
echo -e "${BLUE}3.${NC} Configure Discord (optional):"
echo -e "   ${PURPLE}→${NC} Create webhook in Discord server"
echo -e "   ${PURPLE}→${NC} Add as secret: gh secret set DISCORD_WEBHOOK_URL"
echo ""
echo -e "${BLUE}4.${NC} Start your first sprint:"
echo -e "   ${PURPLE}→${NC} Move issues from Backlog to Todo"
echo -e "   ${PURPLE}→${NC} Run GitHub Action: gh workflow run burndown.yml"
echo -e "   ${PURPLE}→${NC} View burndown: https://$(echo $REPO | cut -d'/' -f1).github.io/$(echo $REPO | cut -d'/' -f2)/burndown/"
echo ""
echo -e "${GREEN}🚀 Happy Agile Development!${NC}"
#!/bin/bash

# 🚀 Quick Start Script for Agile GitHub Suite
# Simple one-liner setup for new projects

set -euo pipefail

# Colors
readonly GREEN='\033[0;32m'
readonly BLUE='\033[0;34m'
readonly YELLOW='\033[1;33m'
readonly NC='\033[0m'

# Quick start banner
echo -e "${BLUE}"
cat << 'EOF'
╔══════════════════════════════════════════════╗
║        🚀 Agile GitHub Suite               ║
║         Quick Start Setup                   ║
╚══════════════════════════════════════════════╝
EOF
echo -e "${NC}\n"

# Interactive setup
echo -e "${YELLOW}Welcome! Let's set up your agile environment in 3 steps.${NC}\n"

# Step 1: Repository
echo -e "${BLUE}Step 1/3: Repository Information${NC}"
read -p "GitHub repository (owner/repo): " REPO

if [[ -z "$REPO" ]]; then
    echo "❌ Repository is required"
    exit 1
fi

# Step 2: Sprint
echo -e "\n${BLUE}Step 2/3: Sprint Settings${NC}"
read -p "Sprint name (default: Sprint 1): " SPRINT_NAME
SPRINT_NAME=${SPRINT_NAME:-"Sprint 1"}

read -p "Sprint duration in days (default: 14): " SPRINT_DAYS
SPRINT_DAYS=${SPRINT_DAYS:-14}

# Step 3: Features
echo -e "\n${BLUE}Step 3/3: Feature Selection${NC}"
echo "Select features to install:"
echo "1. All features (recommended)"
echo "2. Basic only (labels + templates)"
echo "3. Custom selection"

read -p "Choose option (1-3, default: 1): " FEATURES_OPTION
FEATURES_OPTION=${FEATURES_OPTION:-1}

# Build command
SETUP_CMD="./scripts/setup-enhanced.sh -r \"$REPO\" -s \"$SPRINT_NAME\" -d $SPRINT_DAYS"

case $FEATURES_OPTION in
    2)
        SETUP_CMD="$SETUP_CMD --skip-issues"
        ;;
    3)
        echo "Available features:"
        echo "- labels: Priority/Type/Estimate labels"
        echo "- templates: Issue templates"
        echo "- milestones: Sprint milestones"
        echo "- issues: Sample issues"
        
        read -p "Skip labels? (y/N): " SKIP_LABELS
        [[ "$SKIP_LABELS" =~ ^[Yy] ]] && SETUP_CMD="$SETUP_CMD --skip-labels"
        
        read -p "Skip milestones? (y/N): " SKIP_MILESTONES
        [[ "$SKIP_MILESTONES" =~ ^[Yy] ]] && SETUP_CMD="$SETUP_CMD --skip-milestone"
        
        read -p "Skip sample issues? (y/N): " SKIP_ISSUES
        [[ "$SKIP_ISSUES" =~ ^[Yy] ]] && SETUP_CMD="$SETUP_CMD --skip-issues"
        ;;
esac

# Confirm and execute
echo -e "\n${YELLOW}Setup Summary:${NC}"
echo "Repository: $REPO"
echo "Sprint: $SPRINT_NAME ($SPRINT_DAYS days)"
echo "Command: $SETUP_CMD"
echo ""

read -p "Proceed with setup? (Y/n): " CONFIRM
if [[ "$CONFIRM" =~ ^[Nn] ]]; then
    echo "Setup cancelled."
    exit 0
fi

# Execute setup
echo -e "\n${GREEN}🚀 Starting setup...${NC}\n"

if eval "$SETUP_CMD"; then
    echo -e "\n${GREEN}✅ Setup completed successfully!${NC}"
    echo ""
    echo "Next steps:"
    echo "1. Enable GitHub Pages: Settings → Pages → Deploy from branch (main, /docs)"
    echo "2. View your dashboard: https://$(echo $REPO | cut -d'/' -f1).github.io/$(echo $REPO | cut -d'/' -f2)/"
    echo "3. Create your first issues using the templates"
    echo ""
    echo "🎉 Happy agile development!"
else
    echo -e "\n${RED}❌ Setup failed. Please check the error messages above.${NC}"
    exit 1
fi
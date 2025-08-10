# Suggested Commands for Development

## Setup and Initialization

### One-Click Project Setup
```bash
# Run the automated setup script
./scripts/setup.sh -r your-org/your-repo -s "Sprint 1" -d 14

# Options:
#   -r, --repo REPO     GitHub repository (format: owner/repo)
#   -s, --sprint NAME   Sprint name (default: Sprint 1)  
#   -d, --days DAYS     Sprint duration in days (default: 14)
```

### Manual GitHub Setup
```bash
# Initialize git repository
git init
git add .
git commit -m "Initial agile setup"

# Create GitHub repository
gh repo create pandalize/agile --private
git push -u origin main

# Create labels
gh label create "priority: high" --color "FF0000"
gh label create "priority: medium" --color "FFA500"
gh label create "priority: low" --color "008000"
gh label create "type: user-story" --color "0052CC"
gh label create "type: task" --color "7057FF"
gh label create "type: bug" --color "D73A4A"

# Create milestone
gh milestone create "Sprint 1" --due-date "2024-01-31"

# Create sample issues
gh issue create --title "User Story: Dashboard Implementation" \
  --label "type: user-story,priority: high,estimate: 5" \
  --milestone "Sprint 1"
```

## Development Commands

### View Dashboards Locally
```bash
# Open burndown chart
open docs/burndown/index.html

# Open team dashboard  
open docs/team-dashboard/index.html

# Or start a local server
python3 -m http.server 8000 --directory docs
# Then visit http://localhost:8000
```

### GitHub Actions Management
```bash
# List workflows
gh workflow list

# View workflow runs
gh run list --workflow=burndown.yml

# Manually trigger workflow
gh workflow run burndown.yml

# View workflow logs
gh run view [run-id] --log
```

## Git Commands

```bash
# Check status
git status

# Stage changes
git add .

# Commit with message
git commit -m "feat: add new dashboard feature"

# Push to GitHub
git push origin main

# Create feature branch
git checkout -b feature/new-dashboard

# Merge branch
git checkout main
git merge feature/new-dashboard
```

## System Utilities (macOS/Darwin)

```bash
# List files
ls -la

# Find files
find . -name "*.html"

# Search in files (macOS uses BSD grep)
grep -r "TODO" .

# Watch file changes
fswatch -o docs/ | xargs -n1 -I{} echo "Files changed"

# Open in default browser
open docs/index.html

# Copy to clipboard
echo "text" | pbcopy

# Get from clipboard  
pbpaste
```

## GitHub CLI Commands

```bash
# View issues
gh issue list

# Create PR
gh pr create --title "Feature: Add metrics" --body "Description"

# View PR status
gh pr status

# Check CI status
gh status
```

## Notes
- This project has NO npm/yarn/build commands since it uses vanilla web technologies
- All dashboards are static HTML/CSS/JS served via GitHub Pages
- Data collection happens automatically via GitHub Actions
- No testing framework is configured (vanilla JS project)
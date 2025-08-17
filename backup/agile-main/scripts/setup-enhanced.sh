#!/bin/bash

# 🚀 Agile GitHub Suite - Enhanced Setup Script
# Modular, robust, and extensible setup for agile development

set -euo pipefail
IFS=$'\n\t'

# ============================================================================
# Configuration
# ============================================================================

readonly SCRIPT_NAME="$(basename "$0")"
readonly SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
readonly VERSION="2.0.0"

# Color definitions
readonly RED='\033[0;31m'
readonly GREEN='\033[0;32m'
readonly YELLOW='\033[1;33m'
readonly BLUE='\033[0;34m'
readonly PURPLE='\033[0;35m'
readonly CYAN='\033[0;36m'
readonly NC='\033[0m'

# Default values
DEFAULT_SPRINT_NAME="Sprint 1"
DEFAULT_SPRINT_DAYS=14
DEFAULT_LABELS_FILE="${SCRIPT_DIR}/labels.json"

# ============================================================================
# Utility Functions
# ============================================================================

log_info() {
    echo -e "${BLUE}ℹ️  ${1}${NC}"
}

log_success() {
    echo -e "${GREEN}✓ ${1}${NC}"
}

log_warning() {
    echo -e "${YELLOW}⚠️  ${1}${NC}"
}

log_error() {
    echo -e "${RED}❌ ${1}${NC}" >&2
}

log_step() {
    echo -e "\n${CYAN}▶ ${1}${NC}"
}

show_header() {
    echo -e "${CYAN}"
    echo "╔════════════════════════════════════════════════════════╗"
    echo "║     🚀 Agile GitHub Suite Setup Script v${VERSION}     ║"
    echo "╚════════════════════════════════════════════════════════╝"
    echo -e "${NC}\n"
}

show_help() {
    cat << EOF
Usage: ${SCRIPT_NAME} [OPTIONS]

Setup GitHub repository for agile development with labels, milestones, and sample issues.

OPTIONS:
    -r, --repo REPO        GitHub repository (format: owner/repo) [REQUIRED]
    -s, --sprint NAME      Sprint name (default: ${DEFAULT_SPRINT_NAME})
    -d, --days DAYS        Sprint duration in days (default: ${DEFAULT_SPRINT_DAYS})
    -l, --labels FILE      Custom labels JSON file
    --skip-labels          Skip label creation
    --skip-milestone       Skip milestone creation
    --skip-issues          Skip sample issue creation
    --dry-run             Show what would be done without making changes
    -v, --verbose         Enable verbose output
    -h, --help            Show this help message
    --version             Show version information

EXAMPLES:
    ${SCRIPT_NAME} -r owner/repo
    ${SCRIPT_NAME} -r owner/repo -s "Sprint 2" -d 7
    ${SCRIPT_NAME} -r owner/repo --skip-issues --verbose

REQUIREMENTS:
    - GitHub CLI (gh) must be installed and authenticated
    - Repository must exist and you must have write access

EOF
}

# ============================================================================
# Validation Functions
# ============================================================================

check_dependencies() {
    local deps=("gh" "date" "jq")
    local missing=()
    
    for dep in "${deps[@]}"; do
        if ! command -v "$dep" &> /dev/null; then
            missing+=("$dep")
        fi
    done
    
    if [[ ${#missing[@]} -gt 0 ]]; then
        log_error "Missing required dependencies: ${missing[*]}"
        log_info "Please install missing dependencies and try again"
        exit 1
    fi
}

check_gh_auth() {
    if ! gh auth status &>/dev/null; then
        log_error "GitHub CLI is not authenticated"
        log_info "Please run: gh auth login"
        exit 1
    fi
}

validate_repo() {
    local repo="$1"
    
    if [[ ! "$repo" =~ ^[a-zA-Z0-9_-]+/[a-zA-Z0-9_-]+$ ]]; then
        log_error "Invalid repository format: $repo"
        log_info "Expected format: owner/repo"
        return 1
    fi
    
    if ! gh repo view "$repo" &>/dev/null; then
        log_error "Cannot access repository: $repo"
        log_info "Please check repository exists and you have access"
        return 1
    fi
    
    return 0
}

# ============================================================================
# Label Management
# ============================================================================

get_default_labels() {
    cat << 'EOF'
{
  "priority": [
    {"name": "priority/critical", "color": "b60205", "description": "Critical priority - immediate action required"},
    {"name": "priority/high", "color": "d73a4a", "description": "High priority"},
    {"name": "priority/medium", "color": "fbca04", "description": "Medium priority"},
    {"name": "priority/low", "color": "0e8a16", "description": "Low priority"}
  ],
  "type": [
    {"name": "type/feature", "color": "a2eeef", "description": "New feature or enhancement"},
    {"name": "type/bug", "color": "d73a4a", "description": "Bug fix"},
    {"name": "type/task", "color": "7057ff", "description": "Task or chore"},
    {"name": "type/epic", "color": "3e4b9e", "description": "Epic - large feature"},
    {"name": "type/story", "color": "0052cc", "description": "User story"}
  ],
  "estimate": [
    {"name": "estimate/1", "color": "c5f015", "description": "1 story point"},
    {"name": "estimate/2", "color": "c5f015", "description": "2 story points"},
    {"name": "estimate/3", "color": "c5f015", "description": "3 story points"},
    {"name": "estimate/5", "color": "c5f015", "description": "5 story points"},
    {"name": "estimate/8", "color": "c5f015", "description": "8 story points"},
    {"name": "estimate/13", "color": "c5f015", "description": "13 story points"},
    {"name": "estimate/21", "color": "c5f015", "description": "21 story points"}
  ],
  "status": [
    {"name": "status/backlog", "color": "ededed", "description": "In backlog"},
    {"name": "status/todo", "color": "fbca04", "description": "Ready to work on"},
    {"name": "status/in-progress", "color": "0052cc", "description": "Currently being worked on"},
    {"name": "status/review", "color": "5319e7", "description": "In review"},
    {"name": "status/done", "color": "0e8a16", "description": "Completed"},
    {"name": "status/blocked", "color": "d73a4a", "description": "Blocked"}
  ]
}
EOF
}

create_label() {
    local repo="$1"
    local name="$2"
    local color="$3"
    local description="$4"
    local dry_run="$5"
    
    if [[ "$dry_run" == "true" ]]; then
        log_info "[DRY RUN] Would create label: $name"
        return 0
    fi
    
    if gh label create "$name" \
        --color "$color" \
        --description "$description" \
        --repo "$repo" 2>/dev/null; then
        log_success "Created label: $name"
    else
        log_warning "Label already exists: $name"
    fi
}

create_labels() {
    local repo="$1"
    local labels_json="$2"
    local dry_run="$3"
    
    log_step "Creating labels..."
    
    for category in $(echo "$labels_json" | jq -r 'keys[]'); do
        log_info "Creating $category labels:"
        
        echo "$labels_json" | jq -r ".${category}[] | @base64" | while read -r label_data; do
            local name=$(echo "$label_data" | base64 -d | jq -r '.name')
            local color=$(echo "$label_data" | base64 -d | jq -r '.color')
            local description=$(echo "$label_data" | base64 -d | jq -r '.description')
            
            create_label "$repo" "$name" "$color" "$description" "$dry_run"
        done
    done
}

# ============================================================================
# Milestone Management
# ============================================================================

calculate_due_date() {
    local days="$1"
    
    # Try GNU date first, then BSD date
    if date --version &>/dev/null; then
        date -d "+${days} days" +"%Y-%m-%d"
    else
        date -v +${days}d +"%Y-%m-%d"
    fi
}

create_milestone() {
    local repo="$1"
    local name="$2"
    local days="$3"
    local dry_run="$4"
    
    log_step "Creating milestone..."
    
    local due_date=$(calculate_due_date "$days")
    local description="Sprint milestone for agile development"
    
    if [[ "$dry_run" == "true" ]]; then
        log_info "[DRY RUN] Would create milestone: $name (due: $due_date)"
        return 0
    fi
    
    if gh milestone create "$name" \
        --due-date "$due_date" \
        --description "$description" \
        --repo "$repo" 2>/dev/null; then
        log_success "Created milestone: $name (due: $due_date)"
    else
        log_warning "Milestone already exists: $name"
    fi
}

# ============================================================================
# Issue Management
# ============================================================================

create_sample_issues() {
    local repo="$1"
    local sprint="$2"
    local dry_run="$3"
    
    log_step "Creating sample issues..."
    
    if [[ "$dry_run" == "true" ]]; then
        log_info "[DRY RUN] Would create 3 sample issues"
        return 0
    fi
    
    # User Story
    local story_body="**User Story**: As a team member, I want to see our sprint progress visually so that I can track velocity and identify blockers early.

**Acceptance Criteria**:
- [ ] Burndown chart displays current sprint data
- [ ] Chart updates daily automatically
- [ ] Team can access via GitHub Pages
- [ ] Historical data is preserved
- [ ] Velocity is calculated

**Story Points**: 5"
    
    if gh issue create \
        --title "[Story] Setup automated burndown dashboard" \
        --body "$story_body" \
        --label "type/story,estimate/5,priority/high,status/backlog" \
        --milestone "$sprint" \
        --repo "$repo" &>/dev/null; then
        log_success "Created sample User Story"
    fi
    
    # Task
    local task_body="**Description**: Configure GitHub repository with proper labels and milestones.

**Checklist**:
- [ ] Create priority labels
- [ ] Create type labels
- [ ] Create estimate labels
- [ ] Create status labels
- [ ] Setup milestone
- [ ] Configure project board"
    
    if gh issue create \
        --title "[Task] Repository setup and configuration" \
        --body "$task_body" \
        --label "type/task,estimate/2,priority/high,status/todo" \
        --milestone "$sprint" \
        --repo "$repo" &>/dev/null; then
        log_success "Created sample Task"
    fi
    
    # Bug Report
    local bug_body="**Bug Description**: Chart display issues on mobile devices.

**Steps to Reproduce**:
1. Open chart on mobile
2. Observe layout issues

**Expected**: Chart should be responsive
**Actual**: Chart is cut off"
    
    if gh issue create \
        --title "[Bug] Mobile responsive issues" \
        --body "$bug_body" \
        --label "type/bug,estimate/3,priority/medium,status/backlog" \
        --milestone "$sprint" \
        --repo "$repo" &>/dev/null; then
        log_success "Created sample Bug Report"
    fi
}

# ============================================================================
# Next Steps
# ============================================================================

show_next_steps() {
    local repo="$1"
    local owner="${repo%%/*}"
    local name="${repo##*/}"
    
    echo -e "\n${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${GREEN}🎉 Setup completed successfully!${NC}"
    echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}\n"
    
    echo -e "${CYAN}📋 Next Steps:${NC}\n"
    
    echo -e "${BLUE}1. Create Project Board:${NC}"
    echo -e "   ${PURPLE}→${NC} https://github.com/${repo}/projects"
    echo -e "   ${PURPLE}→${NC} Create columns: Backlog | Todo | In Progress | Review | Done\n"
    
    echo -e "${BLUE}2. Enable GitHub Pages:${NC}"
    echo -e "   ${PURPLE}→${NC} https://github.com/${repo}/settings/pages"
    echo -e "   ${PURPLE}→${NC} Source: Deploy from branch (main, /docs)\n"
    
    echo -e "${BLUE}3. View Dashboards:${NC}"
    echo -e "   ${PURPLE}→${NC} Burndown: https://${owner}.github.io/${name}/burndown/"
    echo -e "   ${PURPLE}→${NC} Team: https://${owner}.github.io/${name}/team-dashboard/\n"
    
    echo -e "${BLUE}4. Configure Automation:${NC}"
    echo -e "   ${PURPLE}→${NC} Review: .github/workflows/"
    echo -e "   ${PURPLE}→${NC} Run: gh workflow run burndown.yml\n"
    
    echo -e "${GREEN}🚀 Happy Agile Development!${NC}"
}

# ============================================================================
# Main Function
# ============================================================================

main() {
    local repo=""
    local sprint_name="$DEFAULT_SPRINT_NAME"
    local sprint_days="$DEFAULT_SPRINT_DAYS"
    local labels_file=""
    local skip_labels=false
    local skip_milestone=false
    local skip_issues=false
    local dry_run=false
    local verbose=false
    
    # Parse arguments
    while [[ $# -gt 0 ]]; do
        case "$1" in
            -r|--repo)
                repo="$2"
                shift 2
                ;;
            -s|--sprint)
                sprint_name="$2"
                shift 2
                ;;
            -d|--days)
                sprint_days="$2"
                shift 2
                ;;
            -l|--labels)
                labels_file="$2"
                shift 2
                ;;
            --skip-labels)
                skip_labels=true
                shift
                ;;
            --skip-milestone)
                skip_milestone=true
                shift
                ;;
            --skip-issues)
                skip_issues=true
                shift
                ;;
            --dry-run)
                dry_run=true
                shift
                ;;
            -v|--verbose)
                verbose=true
                set -x
                shift
                ;;
            -h|--help)
                show_help
                exit 0
                ;;
            --version)
                echo "Version: $VERSION"
                exit 0
                ;;
            *)
                log_error "Unknown option: $1"
                show_help
                exit 1
                ;;
        esac
    done
    
    # Show header
    show_header
    
    # Validate inputs
    if [[ -z "$repo" ]]; then
        log_error "Repository is required"
        show_help
        exit 1
    fi
    
    # Check dependencies
    check_dependencies
    check_gh_auth
    validate_repo "$repo"
    
    # Display configuration
    log_info "Configuration:"
    echo "  Repository: $repo"
    echo "  Sprint: $sprint_name"
    echo "  Duration: $sprint_days days"
    echo "  Dry run: $dry_run"
    
    # Load labels
    local labels_json
    if [[ -n "$labels_file" && -f "$labels_file" ]]; then
        labels_json=$(cat "$labels_file")
    else
        labels_json=$(get_default_labels)
    fi
    
    # Execute setup steps
    if [[ "$skip_labels" != "true" ]]; then
        create_labels "$repo" "$labels_json" "$dry_run"
    fi
    
    if [[ "$skip_milestone" != "true" ]]; then
        create_milestone "$repo" "$sprint_name" "$sprint_days" "$dry_run"
    fi
    
    if [[ "$skip_issues" != "true" ]]; then
        create_sample_issues "$repo" "$sprint_name" "$dry_run"
    fi
    
    # Show next steps
    if [[ "$dry_run" != "true" ]]; then
        show_next_steps "$repo"
    fi
}

# ============================================================================
# Script Entry Point
# ============================================================================

# Handle errors
trap 'log_error "Script failed on line $LINENO"' ERR

# Run main function
main "$@"
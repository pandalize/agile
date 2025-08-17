# Codebase Structure and Architecture

## Directory Layout

```
agile/
├── docs/                         # GitHub Pages content (public dashboards)
│   ├── index.html               # Landing page
│   ├── burndown/                # Burndown chart dashboard
│   │   ├── index.html          # Interactive burndown visualization
│   │   └── sprint-1.json       # Sample sprint data
│   └── team-dashboard/          # Team metrics dashboard
│       └── index.html          # Team overview and metrics
│
├── scripts/                     # Automation and setup tools
│   └── setup.sh                # One-click setup script for labels, milestones, issues
│
├── .github/                     # GitHub-specific configuration
│   ├── workflows/              # GitHub Actions automation
│   │   ├── burndown.yml       # Daily burndown data collection (weekdays 9am)
│   │   └── team-metrics.yml   # Team metrics collection (8am, 6pm daily)
│   └── ISSUE_TEMPLATE/         # Structured issue templates
│       ├── user-story.yml     # User story with acceptance criteria
│       ├── bug-report.yml     # Bug report with reproduction steps
│       ├── task.yml           # Technical task template
│       └── config.yml         # Template configuration
│
├── README.md                   # Project overview and quick start
├── CLAUDE.md                   # Development history and context
├── setup-guide.md             # Detailed setup instructions
├── agile-tools-comparison.md # Market analysis and comparisons
└── project-status-and-strategy.md # Strategy and roadmap

```

## Key Components

### 1. Dashboards (docs/)
- **Purpose**: Visual interfaces for team metrics
- **Technology**: Static HTML + CSS + Vanilla JS + Chart.js
- **Deployment**: GitHub Pages (automatic on push to main)
- **Data Source**: JSON files updated by GitHub Actions

### 2. Automation (scripts/ & .github/workflows/)
- **Setup Script**: Bash script for initial repository configuration
- **GitHub Actions**: Automated data collection and processing
- **Schedule**: Cron-based triggers for regular updates

### 3. Issue Management (.github/ISSUE_TEMPLATE/)
- **Templates**: YAML-based forms for consistent issue creation
- **Labels**: Automated label assignment based on template
- **Integration**: Direct GitHub UI integration

## Data Flow

1. **Issue Creation** → GitHub Issues with labels/milestones
2. **Data Collection** → GitHub Actions fetch via API
3. **Data Storage** → JSON files in docs/ directory  
4. **Visualization** → JavaScript reads JSON and renders charts
5. **Distribution** → GitHub Pages serves dashboards

## No Backend Architecture
- All computation happens client-side in browser
- Data persistence via GitHub (issues, milestones, JSON files)
- Authentication handled by GitHub
- No databases, servers, or APIs to maintain

## Extension Points
- Add new dashboards in docs/
- Create new workflows in .github/workflows/
- Extend setup.sh for additional automation
- Add new issue templates as needed
# Task Completion Checklist

Since this is a vanilla web technology project without traditional build tools, the completion steps are different from typical Node.js projects.

## When Completing a Task

### 1. Code Quality Checks
Since there are no linting/formatting tools configured:
- [ ] Ensure HTML is valid and semantic
- [ ] Check JavaScript for console errors in browser
- [ ] Verify CSS doesn't break existing styles
- [ ] Test in multiple browsers if possible

### 2. Manual Testing
```bash
# Open the modified files in browser
open docs/burndown/index.html
open docs/team-dashboard/index.html

# Or run a local server
python3 -m http.server 8000 --directory docs
```

### 3. Git Operations
```bash
# Check what changed
git status
git diff

# Stage and commit changes
git add .
git commit -m "descriptive commit message"

# Push to GitHub (triggers GitHub Pages update)
git push origin main
```

### 4. Verify GitHub Pages Deployment
- Wait 1-2 minutes for GitHub Pages to update
- Check live site at: https://[org].github.io/[repo]/
- Verify dashboards load correctly
- Check that data displays properly

### 5. GitHub Actions Verification
If workflows were modified:
```bash
# Check workflow syntax
gh workflow list

# View recent runs
gh run list

# Check for failures
gh run list --status failure
```

### 6. Documentation Updates
If functionality changed:
- [ ] Update README.md if needed
- [ ] Update CLAUDE.md with development notes
- [ ] Update setup-guide.md for setup changes

## Special Considerations

### For Dashboard Changes
- Test responsive design on mobile viewport
- Verify Chart.js renders correctly
- Check data loading from JSON files

### For Setup Script Changes
- Test script with different parameters
- Verify error handling works
- Check GitHub CLI commands succeed

### For GitHub Actions Changes
- Validate YAML syntax
- Test with workflow_dispatch if possible
- Monitor first automated run

## No Build/Test/Lint Commands Available
This project intentionally uses vanilla web technologies without build tools, so there are no commands for:
- npm test / yarn test
- npm run lint / eslint
- npm run build / webpack
- npm run typecheck / tsc

Instead, rely on:
- Browser DevTools for debugging
- Manual testing in browsers
- GitHub Actions for automation validation
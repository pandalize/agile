# Technology Stack and Code Conventions

## Core Technologies

### Frontend
- **HTML5**: Semantic markup, accessibility-focused
- **CSS3**: Modern layout with Grid and Flexbox
- **Vanilla JavaScript (ES6+)**: No frameworks, pure web standards
- **Chart.js**: Data visualization library for charts

### Automation & Infrastructure
- **GitHub Actions**: YAML workflows for data collection
- **GitHub API**: Data fetching and repository interaction
- **Bash Scripts**: Setup automation and tooling
- **JSON**: Data storage and configuration

### Deployment
- **GitHub Pages**: Static site hosting for dashboards
- **No build process**: Direct HTML/CSS/JS files

## Code Conventions

### JavaScript
- ES6+ features (arrow functions, template literals, async/await)
- Modular functions with clear single responsibility
- Descriptive variable and function names
- No transpilation or bundling needed

### HTML
- Semantic HTML5 elements
- Accessibility attributes (ARIA labels where needed)
- Mobile-responsive viewport meta tags
- UTF-8 character encoding

### CSS
- CSS Grid and Flexbox for layouts
- CSS custom properties for theming
- BEM-like naming convention for classes
- Mobile-first responsive design

### File Organization
- Static assets served directly from /docs
- Each dashboard in its own directory
- Inline styles and scripts for simplicity
- No build artifacts or generated files

## Design Principles

1. **Zero Dependencies Philosophy**
   - Minimize external dependencies
   - Only Chart.js as external library
   - Everything else vanilla web standards

2. **Progressive Enhancement**
   - Core functionality works without JavaScript
   - Enhanced features layer on top
   - Graceful degradation for older browsers

3. **Performance First**
   - Minimal file sizes
   - No framework overhead
   - Fast load times on GitHub Pages

4. **Maintainability**
   - Clear, readable code
   - Self-documenting structure
   - No complex build pipeline
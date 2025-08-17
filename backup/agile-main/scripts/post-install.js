#!/usr/bin/env node

import { execSync } from 'child_process';
import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';
import chalk from 'chalk';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);
const rootDir = path.resolve(__dirname, '..');

console.log(chalk.blue('\n🚀 Agile GitHub Suite - Post Install Setup\n'));

// Check if we're in a Git repository
try {
  execSync('git rev-parse --git-dir', { stdio: 'ignore' });
} catch {
  console.log(chalk.yellow('⚠️  Not in a Git repository. Skipping Git hooks setup.'));
  process.exit(0);
}

// Create .agile config directory
const configDir = path.join(process.cwd(), '.agile');
if (!fs.existsSync(configDir)) {
  fs.mkdirSync(configDir, { recursive: true });
  console.log(chalk.green('✅ Created .agile configuration directory'));
}

// Create config file
const configFile = path.join(configDir, 'config.json');
if (!fs.existsSync(configFile)) {
  const defaultConfig = {
    version: '2.0.0',
    autoUpdate: true,
    updateCheckInterval: 'weekly',
    components: {
      workflows: true,
      dashboards: true,
      templates: true,
      scripts: true
    },
    customizations: {}
  };
  
  fs.writeFileSync(configFile, JSON.stringify(defaultConfig, null, 2));
  console.log(chalk.green('✅ Created default configuration'));
}

// Copy essential files to project if not exists
const essentialDirs = [
  { src: '.github/workflows', dest: '.github/workflows' },
  { src: '.github/ISSUE_TEMPLATE', dest: '.github/ISSUE_TEMPLATE' },
  { src: 'docs', dest: 'docs/agile' }
];

essentialDirs.forEach(({ src, dest }) => {
  const srcPath = path.join(rootDir, src);
  const destPath = path.join(process.cwd(), dest);
  
  if (!fs.existsSync(destPath) && fs.existsSync(srcPath)) {
    fs.cpSync(srcPath, destPath, { recursive: true });
    console.log(chalk.green(`✅ Copied ${src} to ${dest}`));
  }
});

// Add update script to package.json scripts
const packageJsonPath = path.join(process.cwd(), 'package.json');
if (fs.existsSync(packageJsonPath)) {
  const packageJson = JSON.parse(fs.readFileSync(packageJsonPath, 'utf-8'));
  
  if (!packageJson.scripts) {
    packageJson.scripts = {};
  }
  
  if (!packageJson.scripts['agile:update']) {
    packageJson.scripts['agile:update'] = 'npx @pandalize/agile-github-suite update';
    packageJson.scripts['agile:setup'] = 'npx @pandalize/agile-github-suite setup';
    packageJson.scripts['agile:wizard'] = 'npx @pandalize/agile-github-suite wizard';
    
    fs.writeFileSync(packageJsonPath, JSON.stringify(packageJson, null, 2));
    console.log(chalk.green('✅ Added agile commands to package.json'));
  }
}

console.log(chalk.blue('\n📚 Quick Start Commands:'));
console.log(chalk.cyan('  npm run agile:wizard  ') + '- Open setup wizard');
console.log(chalk.cyan('  npm run agile:setup   ') + '- Run interactive setup');
console.log(chalk.cyan('  npm run agile:update  ') + '- Check for updates');

console.log(chalk.green('\n✨ Installation complete!\n'));
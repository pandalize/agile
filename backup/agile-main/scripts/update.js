#!/usr/bin/env node

import { execSync } from 'child_process';
import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';
import chalk from 'chalk';
import semver from 'semver';
import inquirer from 'inquirer';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);
const rootDir = path.resolve(__dirname, '..');

console.log(chalk.blue('\n🔄 Agile GitHub Suite - Update Check\n'));

// Read current config
const configPath = path.join(process.cwd(), '.agile/config.json');
if (!fs.existsSync(configPath)) {
  console.log(chalk.red('❌ No .agile/config.json found. Please run installation first.'));
  process.exit(1);
}

const config = JSON.parse(fs.readFileSync(configPath, 'utf-8'));
const currentVersion = config.version;

// Check latest version from npm
let latestVersion;
try {
  const result = execSync('npm view @pandalize/agile-github-suite version', { 
    encoding: 'utf-8' 
  });
  latestVersion = result.trim();
} catch (error) {
  console.log(chalk.yellow('⚠️  Could not check for updates. Please check your internet connection.'));
  process.exit(1);
}

console.log(chalk.cyan(`Current version: ${currentVersion}`));
console.log(chalk.cyan(`Latest version:  ${latestVersion}`));

if (semver.gte(currentVersion, latestVersion)) {
  console.log(chalk.green('\n✅ You are using the latest version!\n'));
  process.exit(0);
}

// Show changelog
console.log(chalk.yellow('\n📝 What\'s new in version ' + latestVersion + ':'));
const changelogUrl = `https://github.com/pandalize/agile/releases/tag/v${latestVersion}`;
console.log(chalk.dim(`   View full changelog: ${changelogUrl}\n`));

// Ask for confirmation
const { proceed } = await inquirer.prompt([
  {
    type: 'confirm',
    name: 'proceed',
    message: `Update to version ${latestVersion}?`,
    default: true
  }
]);

if (!proceed) {
  console.log(chalk.yellow('\n⏭️  Update skipped.\n'));
  process.exit(0);
}

console.log(chalk.blue('\n📦 Updating components...\n'));

// Backup current customizations
const backupDir = path.join(process.cwd(), '.agile/backup', new Date().toISOString());
fs.mkdirSync(backupDir, { recursive: true });

// Components to update
const componentsToUpdate = [];
if (config.components.workflows) {
  componentsToUpdate.push({
    src: '.github/workflows',
    dest: '.github/workflows',
    backup: true
  });
}
if (config.components.dashboards) {
  componentsToUpdate.push({
    src: 'docs',
    dest: 'docs/agile',
    backup: true
  });
}
if (config.components.templates) {
  componentsToUpdate.push({
    src: '.github/ISSUE_TEMPLATE',
    dest: '.github/ISSUE_TEMPLATE',
    backup: true
  });
}
if (config.components.scripts) {
  componentsToUpdate.push({
    src: 'scripts',
    dest: 'scripts/agile',
    backup: false
  });
}

// Perform update
for (const component of componentsToUpdate) {
  const destPath = path.join(process.cwd(), component.dest);
  
  // Backup if needed
  if (component.backup && fs.existsSync(destPath)) {
    const backupPath = path.join(backupDir, component.dest);
    fs.cpSync(destPath, backupPath, { recursive: true });
    console.log(chalk.dim(`  📋 Backed up ${component.dest}`));
  }
  
  // Update from npm package
  const srcPath = path.join(rootDir, component.src);
  if (fs.existsSync(srcPath)) {
    fs.cpSync(srcPath, destPath, { recursive: true });
    console.log(chalk.green(`  ✅ Updated ${component.dest}`));
  }
}

// Update config version
config.version = latestVersion;
config.lastUpdate = new Date().toISOString();
fs.writeFileSync(configPath, JSON.stringify(config, null, 2));

// Check for breaking changes
if (semver.major(latestVersion) > semver.major(currentVersion)) {
  console.log(chalk.yellow('\n⚠️  Major version update detected!'));
  console.log(chalk.yellow('   Please review the migration guide:'));
  console.log(chalk.yellow(`   https://github.com/pandalize/agile/blob/main/MIGRATION.md\n`));
}

console.log(chalk.green('\n✨ Update complete!'));
console.log(chalk.dim(`\n💾 Backup saved to: ${backupDir}`));
console.log(chalk.cyan('\n📚 Next steps:'));
console.log(chalk.cyan('  1. Review updated components'));
console.log(chalk.cyan('  2. Test your dashboards'));
console.log(chalk.cyan('  3. Commit the changes\n'));
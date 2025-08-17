#!/usr/bin/env node

import { program } from 'commander';
import { execSync } from 'child_process';
import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';
import chalk from 'chalk';
import inquirer from 'inquirer';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);
const rootDir = path.resolve(__dirname, '..');

const packageJson = JSON.parse(
  fs.readFileSync(path.join(rootDir, 'package.json'), 'utf-8')
);

program
  .name('agile-github')
  .description('CLI for Agile GitHub Suite')
  .version(packageJson.version);

// Setup command
program
  .command('setup')
  .description('Run interactive setup for your repository')
  .option('-r, --repo <repo>', 'Repository name (org/repo)')
  .option('-s, --sprint <name>', 'Sprint name')
  .option('-d, --days <days>', 'Sprint duration in days')
  .action(async (options) => {
    console.log(chalk.blue('\n🚀 Agile GitHub Suite - Setup\n'));
    
    let config = {};
    
    if (!options.repo) {
      const answers = await inquirer.prompt([
        {
          type: 'input',
          name: 'repo',
          message: 'GitHub repository (org/repo):',
          validate: (input) => {
            return input.includes('/') || 'Please enter in format: org/repo';
          }
        },
        {
          type: 'input',
          name: 'sprint',
          message: 'Sprint name:',
          default: 'Sprint 1'
        },
        {
          type: 'number',
          name: 'days',
          message: 'Sprint duration (days):',
          default: 14
        }
      ]);
      config = answers;
    } else {
      config = options;
    }
    
    // Run setup script
    const setupScript = path.join(rootDir, 'scripts/setup-enhanced.sh');
    const command = `${setupScript} -r ${config.repo} -s "${config.sprint}" -d ${config.days}`;
    
    try {
      execSync(command, { stdio: 'inherit' });
      console.log(chalk.green('\n✅ Setup complete!\n'));
    } catch (error) {
      console.log(chalk.red('\n❌ Setup failed. Please check the error above.\n'));
      process.exit(1);
    }
  });

// Update command
program
  .command('update')
  .description('Check and install updates')
  .action(async () => {
    const updateScript = path.join(rootDir, 'scripts/update.js');
    try {
      execSync(`node ${updateScript}`, { stdio: 'inherit' });
    } catch (error) {
      process.exit(1);
    }
  });

// Wizard command
program
  .command('wizard')
  .description('Open the setup wizard in browser')
  .action(() => {
    const wizardPath = path.join(rootDir, 'docs/setup-wizard/index.html');
    const command = process.platform === 'darwin' 
      ? `open ${wizardPath}`
      : process.platform === 'win32'
      ? `start ${wizardPath}`
      : `xdg-open ${wizardPath}`;
    
    try {
      execSync(command);
      console.log(chalk.green('✅ Setup wizard opened in browser'));
    } catch (error) {
      console.log(chalk.yellow('⚠️  Could not open browser. Please open manually:'));
      console.log(chalk.cyan(`   ${wizardPath}`));
    }
  });

// Config command
program
  .command('config')
  .description('Configure Agile GitHub Suite')
  .action(async () => {
    const configPath = path.join(process.cwd(), '.agile/config.json');
    
    if (!fs.existsSync(configPath)) {
      console.log(chalk.yellow('⚠️  No configuration found. Creating default...'));
      const configDir = path.dirname(configPath);
      fs.mkdirSync(configDir, { recursive: true });
      
      const defaultConfig = {
        version: packageJson.version,
        autoUpdate: true,
        updateCheckInterval: 'weekly',
        components: {
          workflows: true,
          dashboards: true,
          templates: true,
          scripts: true
        }
      };
      
      fs.writeFileSync(configPath, JSON.stringify(defaultConfig, null, 2));
    }
    
    const config = JSON.parse(fs.readFileSync(configPath, 'utf-8'));
    
    const answers = await inquirer.prompt([
      {
        type: 'confirm',
        name: 'autoUpdate',
        message: 'Enable automatic update checks?',
        default: config.autoUpdate
      },
      {
        type: 'list',
        name: 'updateCheckInterval',
        message: 'Update check frequency:',
        choices: ['daily', 'weekly', 'monthly'],
        default: config.updateCheckInterval
      },
      {
        type: 'checkbox',
        name: 'components',
        message: 'Select components to manage:',
        choices: [
          { name: 'GitHub Workflows', value: 'workflows', checked: config.components.workflows },
          { name: 'Dashboards', value: 'dashboards', checked: config.components.dashboards },
          { name: 'Issue Templates', value: 'templates', checked: config.components.templates },
          { name: 'Scripts', value: 'scripts', checked: config.components.scripts }
        ]
      }
    ]);
    
    // Update config
    config.autoUpdate = answers.autoUpdate;
    config.updateCheckInterval = answers.updateCheckInterval;
    config.components = {
      workflows: answers.components.includes('workflows'),
      dashboards: answers.components.includes('dashboards'),
      templates: answers.components.includes('templates'),
      scripts: answers.components.includes('scripts')
    };
    
    fs.writeFileSync(configPath, JSON.stringify(config, null, 2));
    console.log(chalk.green('\n✅ Configuration saved!\n'));
  });

program.parse();
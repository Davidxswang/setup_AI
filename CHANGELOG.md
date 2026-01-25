# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [2.0.0] - 2026-01-24

### Added
- Comprehensive README.md with usage instructions and examples
- Command-line options: `--dry-run`, `--force`, `--verbose`, `--help`
- Colored output for better readability (info, success, warning, error)
- Timestamped backups (format: `filename.backup.YYYYMMDD_HHMMSS`)
- Installation summary showing newly installed, updated, and failed operations
- Confirmation prompt before making changes (can be skipped with `--force`)
- Verbose mode for detailed debugging output
- Error handling with `set -e` and `set -u`
- Source file validation before installation
- Automatic rollback on failure
- `.gitignore` file for repository cleanliness
- CHANGELOG.md to track version history

### Changed
- Fixed shebang from `#! /bin/bash` to `#!/bin/bash` (no space)
- Refactored duplicate code into reusable `install_config()` function
- Improved error messages and user feedback
- Better backup strategy with timestamps to prevent overwriting previous backups
- More accurate status messages (e.g., "Found existing configuration" instead of "CLI is installed")

### Fixed
- Script now validates that `AGENTS.md` exists before attempting installation
- Added proper error handling for all file operations
- Script now exits with appropriate error codes on failure
- Backup files are restored if installation fails

### Security
- Added validation to prevent running with missing source files
- Improved error handling to prevent silent failures

## [1.0.0] - Initial Release

### Added
- Basic installation script for three AI CLI tools:
  - Gemini CLI (~/.gemini/GEMINI.md)
  - Codex (~/.codex/AGENTS.md)
  - Claude Code (~/.claude/CLAUDE.md)
- Simple backup mechanism (single backup without timestamp)
- AGENTS.md configuration file with coding preferences
- MIT License

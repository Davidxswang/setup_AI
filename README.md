# AI Agent Configuration Installer

A simple bash script to distribute personal AI agent coding preferences to various AI CLI tools.

## Overview

This repository contains a unified configuration file (`AGENTS.md`) with personal coding preferences that can be automatically installed to multiple AI CLI tools:

- **Gemini CLI** - Google's Gemini command-line interface
- **Codex** - OpenAI's Codex CLI tool
- **Claude Code** - Anthropic's Claude command-line interface

## Features

- ✅ Automatic backup of existing configurations (with timestamps)
- ✅ Dry-run mode to preview changes
- ✅ Error handling and validation
- ✅ Colored output for better readability
- ✅ Installation summary
- ✅ Verbose mode for debugging
- ✅ Safe rollback on failure

## Prerequisites

- Bash shell (version 4.0 or higher recommended)
- One or more of the supported AI CLI tools installed (optional - the script will create config directories as needed)

## Installation

1. Clone this repository:
```bash
git clone <repository-url>
cd setup_AI
```

2. Make the script executable:
```bash
chmod +x setup.sh
```

3. Run the installer:
```bash
./setup.sh
```

## Usage

### Basic Usage

```bash
./setup.sh
```

This will prompt for confirmation before installing configurations.

### Command-Line Options

| Option | Description |
|--------|-------------|
| `-d, --dry-run` | Preview what changes would be made without actually making them |
| `-f, --force` | Skip confirmation prompts and install automatically |
| `-v, --verbose` | Show detailed output during installation |
| `-h, --help` | Display help message |

### Examples

**Preview changes without making them:**
```bash
./setup.sh --dry-run
```

**Install without confirmation prompt:**
```bash
./setup.sh --force
```

**Verbose installation with detailed output:**
```bash
./setup.sh --verbose
```

**Combine options:**
```bash
./setup.sh --dry-run --verbose
```

## What It Does

The script performs the following actions for each AI tool:

1. **Checks** if a configuration file already exists
2. **Creates a timestamped backup** if the file exists (e.g., `AGENTS.md.backup.20260124_143022`)
3. **Copies** `AGENTS.md` to the appropriate location:
   - Gemini CLI: `~/.gemini/GEMINI.md`
   - Codex: `~/.codex/AGENTS.md`
   - Claude Code: `~/.claude/CLAUDE.md`
4. **Reports** success or failure for each operation
5. **Shows a summary** of installations, updates, and failures

## Configuration File

The `AGENTS.md` file contains personal coding preferences including:

- Python environment and dependency management preferences (uv, poetry, etc.)
- Code verification checklist (formatting, linting, type checking, testing)
- Typing policy and best practices
- Data modeling guidelines (Pydantic)
- Code style and architecture preferences
- Logging conventions
- CLI tool preferences (Typer)

Feel free to customize `AGENTS.md` to match your own preferences before running the installer.

## Backup and Recovery

### Backups

The script automatically creates timestamped backups when updating existing configurations:
- Format: `<original-filename>.backup.YYYYMMDD_HHMMSS`
- Example: `AGENTS.md.backup.20260124_143022`

### Manual Recovery

To restore a previous configuration:

```bash
# For Codex
cp ~/.codex/AGENTS.md.backup.20260124_143022 ~/.codex/AGENTS.md

# For Gemini CLI
cp ~/.gemini/GEMINI.md.backup.20260124_143022 ~/.gemini/GEMINI.md

# For Claude Code
cp ~/.claude/CLAUDE.md.backup.20260124_143022 ~/.claude/CLAUDE.md
```

### Uninstalling

To remove configurations and restore backups:

```bash
# Remove current configs
rm ~/.gemini/GEMINI.md
rm ~/.codex/AGENTS.md
rm ~/.claude/CLAUDE.md

# Optionally restore the most recent backup
# (find the latest backup by timestamp)
```

## Troubleshooting

### Permission Denied

If you get a "Permission denied" error:
```bash
chmod +x setup.sh
```

### Source File Not Found

Ensure you're running the script from the repository directory where `AGENTS.md` is located:
```bash
cd /path/to/setup_AI
./setup.sh
```

### Failed to Create Directory

Check that you have write permissions to your home directory. The script creates:
- `~/.gemini/`
- `~/.codex/`
- `~/.claude/`

### Viewing Detailed Errors

Run with verbose mode to see detailed error messages:
```bash
./setup.sh --verbose
```

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

### Development

To test changes without affecting your actual configurations:

1. Use dry-run mode:
```bash
./setup.sh --dry-run --verbose
```

2. Run shellcheck for static analysis:
```bash
shellcheck setup.sh
```

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Author

Copyright (c) 2026 Xuesong Wang

## Acknowledgments

- Inspired by the need to maintain consistent AI agent preferences across multiple tools
- Built for developers who use multiple AI CLI tools in their workflow

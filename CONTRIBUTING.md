# Contributing to AI Agent Configuration Installer

Thank you for your interest in contributing! This document provides guidelines for contributing to this project.

## How to Contribute

### Reporting Bugs

If you find a bug, please open an issue with:
- A clear, descriptive title
- Steps to reproduce the issue
- Expected behavior
- Actual behavior
- Your environment (OS, bash version, etc.)

### Suggesting Enhancements

Enhancement suggestions are welcome! Please open an issue with:
- A clear description of the enhancement
- Why this enhancement would be useful
- Any potential implementation details

### Pull Requests

1. Fork the repository
2. Create a new branch (`git checkout -b feature/your-feature-name`)
3. Make your changes
4. Test your changes thoroughly
5. Commit your changes (`git commit -m 'Add some feature'`)
6. Push to the branch (`git push origin feature/your-feature-name`)
7. Open a Pull Request

## Development Guidelines

### Code Style

- Use 4 spaces for indentation (no tabs)
- Use meaningful variable names
- Add comments for complex logic
- Follow existing code structure and patterns
- Use `readonly` for constants
- Quote all variable expansions: `"$variable"`

### Testing

Before submitting a PR, please test:

1. **Dry-run mode:**
   ```bash
   ./setup.sh --dry-run --verbose
   ```

2. **Help output:**
   ```bash
   ./setup.sh --help
   ```

3. **Error cases:**
   - Missing source file
   - Permission denied scenarios
   - Invalid arguments

4. **Success cases:**
   - Fresh installation
   - Updating existing configs
   - Backup creation

### Shell Script Best Practices

- Always use `set -e` and `set -u`
- Validate inputs and check for required files
- Provide meaningful error messages
- Use functions for reusable code
- Handle errors gracefully
- Exit with appropriate exit codes (0 for success, non-zero for failure)

### Running Static Analysis

If you have `shellcheck` installed, run it before submitting:

```bash
shellcheck setup.sh
```

Install shellcheck:
- Ubuntu/Debian: `sudo apt-get install shellcheck`
- macOS: `brew install shellcheck`
- Other: See [shellcheck installation](https://github.com/koalaman/shellcheck#installing)

## Adding Support for New AI Tools

To add support for a new AI CLI tool:

1. Add a new call to `install_config()` in the `main()` function:
   ```bash
   install_config "Tool Name" "$HOME/.tool-dir" "CONFIG.md"
   ```

2. Update the README.md:
   - Add the tool to the overview list
   - Update the "What It Does" section
   - Add the configuration path

3. Update CHANGELOG.md with the new feature

4. Test the changes with `--dry-run` first

## Documentation

When making changes, please update:
- README.md - for user-facing changes
- CHANGELOG.md - for all changes (following Keep a Changelog format)
- Code comments - for complex logic
- Help text in the script - for new options

## Commit Messages

Use clear, descriptive commit messages:
- Use present tense ("Add feature" not "Added feature")
- Use imperative mood ("Move cursor to..." not "Moves cursor to...")
- Limit first line to 72 characters
- Reference issues and pull requests when relevant

Examples:
```
Add support for new AI tool XYZ

Fix backup creation on macOS
Resolves #123

Update README with installation instructions
```

## Code of Conduct

- Be respectful and inclusive
- Welcome newcomers and help them get started
- Focus on constructive feedback
- Assume good intentions

## Questions?

Feel free to open an issue with the "question" label if you need help or clarification.

## License

By contributing, you agree that your contributions will be licensed under the MIT License.

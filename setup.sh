#!/bin/bash

# AI Agent Configuration Installer
# Distributes AGENTS.md to various AI CLI tools

set -e  # Exit on error
set -u  # Exit on undefined variable

# Colors for output
readonly RED='\033[0;31m'
readonly GREEN='\033[0;32m'
readonly YELLOW='\033[1;33m'
readonly BLUE='\033[0;34m'
readonly NC='\033[0m' # No Color

# Configuration
readonly SOURCE_FILE="AGENTS.md"
readonly TIMESTAMP=$(date +%Y%m%d_%H%M%S)

# Flags
DRY_RUN=false
FORCE=false
VERBOSE=false

# Counters for summary
INSTALLED=0
UPDATED=0
FAILED=0

# Print functions
print_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

print_verbose() {
    if [ "$VERBOSE" = true ]; then
        echo -e "${BLUE}[VERBOSE]${NC} $1"
    fi
}

# Show usage
show_usage() {
    cat << EOF
Usage: $(basename "$0") [OPTIONS]

Install AI agent configuration to various CLI tools.

OPTIONS:
    -d, --dry-run       Show what would be done without making changes
    -f, --force         Skip confirmation prompts
    -v, --verbose       Show detailed output
    -h, --help          Show this help message

EXAMPLES:
    $(basename "$0")                    # Interactive installation
    $(basename "$0") --dry-run          # Preview changes
    $(basename "$0") --force            # Install without prompts

EOF
}

# Parse command line arguments
parse_args() {
    while [[ $# -gt 0 ]]; do
        case $1 in
            -d|--dry-run)
                DRY_RUN=true
                shift
                ;;
            -f|--force)
                FORCE=true
                shift
                ;;
            -v|--verbose)
                VERBOSE=true
                shift
                ;;
            -h|--help)
                show_usage
                exit 0
                ;;
            *)
                print_error "Unknown option: $1"
                show_usage
                exit 1
                ;;
        esac
    done
}

# Validate source file exists
validate_source() {
    if [ ! -f "$SOURCE_FILE" ]; then
        print_error "Source file '$SOURCE_FILE' not found in current directory"
        print_info "Current directory: $(pwd)"
        exit 1
    fi
    print_verbose "Source file validated: $SOURCE_FILE"
}

# Install configuration for a specific tool
install_config() {
    local tool_name=$1
    local config_dir=$2
    local config_file=$3
    local full_path="$config_dir/$config_file"

    print_verbose "Processing $tool_name..."

    # Check if config already exists
    if [ -f "$full_path" ]; then
        local backup_path="$full_path.backup.$TIMESTAMP"

        if [ "$DRY_RUN" = true ]; then
            print_info "[DRY RUN] Would backup: $full_path -> $backup_path"
            print_info "[DRY RUN] Would update: $tool_name configuration"
        else
            print_info "Found existing $tool_name configuration"

            # Create backup
            if mv "$full_path" "$backup_path"; then
                print_verbose "Backup created: $backup_path"
            else
                print_error "Failed to create backup for $tool_name"
                FAILED=$((FAILED + 1))
                return 1
            fi

            # Copy new config
            if cp "$SOURCE_FILE" "$full_path"; then
                print_success "Updated $tool_name configuration"
                UPDATED=$((UPDATED + 1))
            else
                print_error "Failed to copy configuration for $tool_name"
                # Restore backup
                mv "$backup_path" "$full_path"
                print_warning "Restored backup"
                FAILED=$((FAILED + 1))
                return 1
            fi
        fi
    else
        if [ "$DRY_RUN" = true ]; then
            print_info "[DRY RUN] Would create directory: $config_dir"
            print_info "[DRY RUN] Would install: $tool_name configuration"
        else
            print_info "Installing $tool_name configuration..."

            # Create directory
            if mkdir -p "$config_dir"; then
                print_verbose "Created directory: $config_dir"
            else
                print_error "Failed to create directory: $config_dir"
                FAILED=$((FAILED + 1))
                return 1
            fi

            # Copy config
            if cp "$SOURCE_FILE" "$full_path"; then
                print_success "Installed $tool_name configuration"
                INSTALLED=$((INSTALLED + 1))
            else
                print_error "Failed to install configuration for $tool_name"
                FAILED=$((FAILED + 1))
                return 1
            fi
        fi
    fi
}

# Show summary
show_summary() {
    echo ""
    echo "=========================================="
    echo "Installation Summary"
    echo "=========================================="

    if [ "$DRY_RUN" = true ]; then
        print_info "DRY RUN MODE - No changes were made"
    else
        print_info "Newly installed: $INSTALLED"
        print_info "Updated: $UPDATED"
        if [ $FAILED -gt 0 ]; then
            print_warning "Failed: $FAILED"
        fi
    fi

    echo "=========================================="
}

# Main installation process
main() {
    parse_args "$@"

    echo "=========================================="
    echo "AI Agent Configuration Installer"
    echo "=========================================="
    echo ""

    # Validate source file
    validate_source

    # Show dry-run notice
    if [ "$DRY_RUN" = true ]; then
        print_warning "Running in DRY RUN mode - no changes will be made"
        echo ""
    fi

    # Confirm unless forced
    if [ "$FORCE" = false ] && [ "$DRY_RUN" = false ]; then
        echo "This will install/update AI agent configurations for:"
        echo "  - Gemini CLI (~/.gemini/GEMINI.md)"
        echo "  - Codex (~/.codex/AGENTS.md)"
        echo "  - Claude Code (~/.claude/CLAUDE.md)"
        echo ""
        read -p "Continue? (y/N) " -n 1 -r
        echo ""
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
            print_info "Installation cancelled"
            exit 0
        fi
        echo ""
    fi

    # Install configurations
    install_config "Gemini CLI" "$HOME/.gemini" "GEMINI.md"
    install_config "Codex" "$HOME/.codex" "AGENTS.md"
    install_config "Claude Code" "$HOME/.claude" "CLAUDE.md"

    # Show summary
    show_summary

    # Exit with appropriate code
    if [ $FAILED -gt 0 ] && [ "$DRY_RUN" = false ]; then
        exit 1
    fi
}

# Run main function with all arguments
main "$@"
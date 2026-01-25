# Personal coding preferences (global)
Applies by default across projects unless a repository explicitly documents different conventions (then follow the repo).

## Environment + command execution
- Prefer `uv` for Python dependency/environment management when the repo supports it.
- Prefer running tools via `uv run ...` to ensure the correct project environment is used. Or use `uvx`.
- If the repo does not use uv (e.g., poetry/pipenv/conda), use the repo’s standard commands and do not introduce uv unless asked.

## Verification checklist (run before marking work “done”)
After non-trivial code changes, run the repo’s equivalent of:
- Format: `uv run ruff format .`
- Lint: `uv run ruff check . --fix`
- Typecheck: `uv run mypy .`
- Tests: `uv run pytest -q` (or the repo’s standard test command)

If a command is not available in the repo, say so explicitly and propose the closest available alternative.

## Typing policy
- Prefer typed Python throughout; avoid `Any` unless necessary and justified.
- When mypy reports missing stubs:
  - Prefer installing official `types-...` packages (if available).
  - Otherwise, consider adding `py.typed`-enabled packages, or use targeted ignores (e.g., per-import `# type: ignore[import-untyped]`) with brief justification.
  - Do not broadly disable mypy checks unless the repo already does.

## Data modeling
- Prefer Pydantic models for validated IO boundaries and structured data contracts.
- Keep models close to the boundary layer (API/CLI/config) rather than leaking validation everywhere.

## Code style / architecture
- Prefer small, composable functions; keep side effects at the edges (IO, CLI, network).
- Imports should be at the top of the file; avoid inline imports unless needed for optional dependencies or to break cycles.
- If using argparse, should use `ArgumentDefaultsHelpFormatter` for formatter.
- Logging:
  - Prefer `logging` (standard library) by default; use `loguru` only if the repo already uses it or explicitly requests it.
  - Avoid `print` for operational logs.
  - Include timestamp, level, and source context (filename/line) when configuring logging.

## CLI conventions
- Prefer Typer for new CLIs (typed command functions, clear help, composable subcommands).

## When unsure / conflict resolution
- First, look for repo docs (README, CONTRIBUTING, Makefile, pyproject scripts, CI config) and align with them.
- If repo conventions are unclear, propose the minimal change that fits these defaults and state any assumptions.


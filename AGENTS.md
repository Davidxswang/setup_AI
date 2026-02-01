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
- **Data Formats:** For large datasets that exceed CSV's practical limits, prefer Parquet format for better compression, faster I/O, and type preservation.

## Code style / architecture
- Prefer small, composable functions; keep side effects at the edges (IO, CLI, network).
- Imports should be at the top of the file; avoid inline imports unless needed for optional dependencies or to break cycles.
- **Path Handling:** Always use `pathlib.Path` for file system operations. Avoid string manipulation (`os.path.join`) or `os.path` functions.
- If using argparse, should use `ArgumentDefaultsHelpFormatter` for formatter.
- **Concurrency:**
  - For CPU-intensive operations (computation, data processing), prefer `multiprocessing` to utilize multiple CPU cores.
  - For I/O-bound operations (network requests, file I/O, database queries), prefer `multithreading` or `asyncio` to handle concurrent I/O efficiently.
- Logging:
  - Prefer `logging` (standard library) by default; use `loguru` only if the repo already uses it or explicitly requests it.
  - Avoid `print` for operational logs.
  - Include timestamp, level, and source context (filename/line) when configuring logging.
- **Tensor Shapes:** For functions involving tensors/arrays (numpy, torch, etc.), docstrings **MUST** explicitly specify the expected shape of inputs and outputs (e.g., `shape: (Batch, Channels, Height, Width)`).

## CLI conventions
- Prefer Typer for new CLIs (typed command functions, clear help, composable subcommands).

## When unsure / conflict resolution
- First, look for repo docs (README, CONTRIBUTING, Makefile, pyproject scripts, CI config) and align with them.
- If repo conventions are unclear, propose the minimal change that fits these defaults and state any assumptions.
- **No Assumption Policy:** Do not assume existence, names, or types (input arguments and return values) of functions, classes, or methods. Always verify by reading the source code or documentation before usage.

## Research paper handling
- Verify access: Check if the paper is open access or behind a paywall (e.g., IEEE, Elsevier).
- **If Open Access:** Proceed with reading and analyzing the content directly.
- **If Paywalled:** Explicitly state that access is restricted. Do not hallucinate or infer content. Ask the user to provide the local PDF file.
- Always be transparent about the source of information (direct URL vs. user-provided PDF).

## Citation verification
- When providing citations (e.g., BibTeX), **ALWAYS** ensure the citation includes a DOI.
- **Verify the DOI:** Use a resolver like `https://doi.org/` to confirm the DOI exists and resolves to the correct paper.
- **Validation:** Compare the resolved metadata (Title, Year, Author) with the citation details. They must match.
- **Failure handling:** If the DOI fails to resolve or metadata does not match, output "missing" for that field or citation. **DO NOT** hallucinate or invent citation details.
- **Citation Preference:** If a paper exists as both a preprint (e.g., arXiv) and a peer-reviewed publication (conference/journal), **ALWAYS** prefer the published version. Only cite the preprint if no published version exists.

## Scientific Reproducibility
- **Multiple Seeds:** Always use 3-5 random seeds for experiments to ensure robustness. Report Mean and Variance (or Standard Deviation) for metrics.
- **Seeding:** Allow setting random seeds via configuration (for numpy, torch, random, etc.).

## Configuration Management
- **Global Config:** Use a global configuration object (e.g., a Pydantic `BaseModel` or `dataclass`) to define all paths, hyperparameters, and constants.
- **No Magic Numbers:** Avoid hardcoding numbers deep in functions. Move them to the global config.
- **Flat Structure:** Prefer a flat configuration structure that is easy to modify via command-line arguments (using Typer).

## Scientific Visualization
- **Vector Graphics:** Always save plots as vector graphics (PDF or SVG) for infinite resolution.
- **Legibility:** Ensure font sizes in plots are large enough to be legible when scaled down to a single column width in a paper.
- **Automation:** Create scripts to automatically generate all figures and tables from the experimental results.

## Paper Construction
- **Asset Generation:** The agent should be able to create scripts that produce all necessary numbers, tables, and figures for the paper.
- **TeX Merging:** The agent must be capable of merging multiple `.tex` files (and optionally `.bib` files) into a single standalone `.tex` file for submission systems (like arXiv).


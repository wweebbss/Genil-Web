Website source code and tooling for the "CEIP Genil" of Granada.

The source aims to be a plain HTML/CSS website with a small amount of custom preprocessing for simplicity and minimalism.

# Git Workflow

## Branches

Main branch is `main`, only stable changes are committed there.

`staging` is considered the canonical development history. Although its history may be rewritten, commits should already be structured and meaningful, as they are expected to become part of the long-term project history.

Feature branches should be branched off `staging`. They are expected to be pre-rebased before being squash-merged back once the feature is complete.

`main` branch lags behind `staging` and marks stable history.

If GitHub Pages becomes the deployment target, releases will likely be tagged and a `prod` branch will track the currently deployed version.

## Commits

All commits arriving at `staging` (that is, after squash), are scoped commits with the feature or concept name as its scope.

This means that if there are changes the homepage to improve the style, a commit may look like `homepage: use a uniform style pattern` (other scopes coule be `branding`, `navigation`, `accessibility`, etc). Some traditional scopes like `ci`, `build`, `docs`, etc; can be reserved for need but generally discouraged.

You can also use optional verbs or context within parentheses next to the scope (e.g. `homepage(typo): ...` or `build(fix): failure on BSD systems`).

# Development

## Building

To build the configuration you need to use a simple script to run some [pre-processing](./PREPROCESSOR.md) chores. Everything is captured by the `justfile`, so you can just use `just build` to build the static files into `dist/` (by convention) and `just serve 8080` to serve the contents in <http://localhost:8080/>.

## Dependencies

All scripts and recipes use arbitrary tools to work, `just build` might require `jq` or `just serve` might depend on `python`.

There is no fixed dependency list, recipes and tools use common command-line tools (like `jq` or `python`) while more specific steps like formatting might ask for `prettier`. If a command is missing, install it and retry. Avoid introducing niche or heavyweight tools unless they provide a clear benefit.

## Utilities

Other recipes to help in development are `just format` which checks formatting (`just format-write` will write the suggested changes) and `just check` which will run some basic checks across the codebase.

`just pre-commit` will run some sanity checks before making a commit to make sure everything is correct and up to style.

# Philosophy

This project intentionally avoids heavyweight site generation and appeals to basic HTML with minimal pre-processing. Complex tooling should be avoided or justify its complexity compared to simpler barebones scripts.

When in doubt, prefer the simpler solution. This project intentionally favors straightforward tooling and minimal preprocessing over feature-rich abstractions.

# Style

Style for different contexts:

- [HTML](./style/html.md)
- [Shell](./style/shell.md)

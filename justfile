alias b := build
alias fmt := format
alias fmtw := format-write

build:
    rm -rf dist
    ./scripts/build.sh src dist

serve port="8080": build
    (cd dist && python -m http.server {{ port }})

open port="8080":
    xdg-open http://localhost:{{ port }}/

format:
    prettier -c .
    git ls-files -z "*.sh" | xargs -0 shfmt -d
format-write:
    prettier -w .
    git ls-files -z "*.sh" | xargs -0 shfmt -w

check:
    codespell
    git ls-files -z "*.sh" | xargs -0 shellcheck
    ! rg -i "(#|<!--)\s*(FIXME|TODO)"

pre-commit: format check

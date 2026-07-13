#!/usr/bin/env bash

set -euo pipefail

help() {
	cat <<-EOF
		Usage: $0 SRC_DIR DST_DIR
	EOF
}

print() { printf "%s" "$1"; }
println() { printf "%s\n" "$1"; }

check_args() {
	if [ "${1:-}" == "-h" ] || [ "${1:-}" == "--help" ] || [ "${1:-}" == "help" ]; then
		help

		exit 0
	fi

	if [ -z "${1:-}" ] || [ -z "${2:-}" ]; then
		(
			print $'\033[1;31m'
			help
			print $'\033[0m'
		) >&2

		exit 1
	fi
}

# expects content path in $1 and relative path for partials in $2
add-partials() {
	local content
	content="$(<"$1")"
	local relto="$2"

	while [ -n "$content" ]; do
		local prefix="${content%%<%*}"
		local rest="${content#*<%}"
		local directive="${rest%%/>*}"

		print "$prefix"
		[ "$prefix" != "$content" ] || break

		# echo "$directive" >&2
		include_path="$(jq -j <<<"$directive")"
		add-partials "$relto/$include_path" "$relto"

		content="${rest#*/>}"
	done
}

main() {
	check_args "$@"

	local src="${1?"missing SRC directory"}"
	local dst="${2?"missing DST directory"}"

	if [ -d "$dst" ] && [ "$(ls -A "$dst")" ]; then
		>&2 println "'$dst' not empty, aborting."
		exit 1
	fi

	while IFS= read -r -d '' file; do
		local ext=${file##*.}
		local relpath
		relpath=$(realpath "$file" --relative-to="$src")
		local reldirname
		reldirname=$(dirname "$relpath")/

		println "$file [$relpath] ($ext $reldirname)"
		local dstpath="$dst/$relpath"
		if [ "$ext" == "html" ]; then
			if ! grep -q "<html" <"$file"; then
				println "  no '<html' found, skipping"
				continue
			fi

			mkdir -p "$dst/$reldirname"
			add-partials "$file" "$src" >"$dstpath"
		else
			mkdir -p "$dst/$reldirname"
			ln "$file" "$dstpath"
		fi
	done < <(find "$src" -type f -print0)
}

main "$@"

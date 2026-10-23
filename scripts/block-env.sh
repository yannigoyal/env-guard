#!/usr/bin/env bash
# env-guard: stop Claude from reading .env files.
# Reads the hook payload from stdin. Never writes files. Never touches the network.
set -euo pipefail


if ! command -v jq >/dev/null 2>&1; then
 echo "env-guard: jq is not installed, so .env files are NOT protected." >&2
 exit 1
fi


input=$(cat)
tool=$(jq -r '.tool_name // empty' <<<"$input")


case "$tool" in
 Read) target=$(jq -r '.tool_input.file_path // empty' <<<"$input") ;;
 Bash) target=$(jq -r '.tool_input.command // empty' <<<"$input") ;;
 *)    exit 0 ;;
esac


# Template files are fine to read, so take them out before checking.
cleaned=$(sed -E 's/\.env\.(example|sample|template)//g' <<<"$target")


if grep -Eq '(^|[/[:space:]"'\''])\.env(\.[A-Za-z0-9_-]+)?($|[[:space:]"'\'';|&])' <<<"$cleaned"; then
 echo "env-guard: blocked access to a .env file. Ask the user for the specific value you need instead." >&2
 exit 2
fi


exit 0
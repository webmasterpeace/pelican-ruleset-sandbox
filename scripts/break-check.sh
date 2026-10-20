#!/usr/bin/env bash
# Adds one deliberate failure so you can confirm a required check blocks the merge.
# Usage: scripts/break-check.sh lint|type|test
# Then commit, push the branch and open a PR. Security Audit and SBOM are broken by hand.
set -euo pipefail
cd "$(dirname "$0")/.."
case "${1:-}" in
  lint) printf 'package main\n\nfunc   badlyFormatted( ) {  }\n' > zz_lint_break.go ;;
  type) printf 'package main\n\nvar zzTypeBreak int = "not an int"\n' > zz_type_break.go ;;
  test) printf 'package main\n\nimport "testing"\n\nfunc TestZZBreak(t *testing.T) { t.Fatal("intentional failure") }\n' > zz_test_break_test.go ;;
  *) echo "usage: $0 lint|type|test" >&2; exit 1 ;;
esac
echo "Deliberate $1 failure created. Commit it, push the branch and open a PR."

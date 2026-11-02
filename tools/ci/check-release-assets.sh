#!/usr/bin/env bash
# Checks the files attached to a GitHub release: exactly
# AccompliceServer-<version>.zip and checksums.txt, then the zip itself with
# tools/ci/verify-server-zip.sh.
#
# An asset uploaded to a release fires no workflow, so the release workflow
# runs this when the tag is pushed and the checks workflow runs it on the
# latest published release every day. Needs the gh CLI and GH_TOKEN.
#
# Usage:
#   tools/ci/check-release-assets.sh <tag> [--allow-none]
#   tools/ci/check-release-assets.sh latest
#
# --allow-none passes a release with no assets yet (a draft the release
# workflow has just created), with a notice. `latest` passes when the repo has
# no published release yet.

set -euo pipefail

tag=${1:-}
allow_none=0
[[ ${2:-} == --allow-none ]] && allow_none=1
[[ -n ${tag} ]] || { echo "usage: check-release-assets.sh <tag|latest> [--allow-none]" >&2; exit 2; }

repo_root="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/../.." && pwd)"

if [[ ${tag} == latest ]]; then
    tag=$(gh release list --exclude-drafts --exclude-pre-releases --limit 50 --json tagName,isLatest \
        --jq '.[] | select(.isLatest) | .tagName')
    if [[ -z ${tag} ]]; then
        echo "check-release-assets: no published release yet, nothing to check"
        exit 0
    fi
    echo "check-release-assets: latest published release is ${tag}"
fi

[[ ${tag} == v* ]] || { echo "check-release-assets: tag '${tag}' does not start with 'v'" >&2; exit 1; }
version=${tag#v}

assets=$(gh release view "${tag}" --json assets --jq '[.assets[].name] | sort | join(" ")')
expected="AccompliceServer-${version}.zip checksums.txt"

if [[ -z ${assets} ]]; then
    if (( allow_none )); then
        echo "::notice::release ${tag} has no assets yet. Attach AccompliceServer-${version}.zip and checksums.txt, then run the Checks workflow."
        exit 0
    fi
    echo "::error::release ${tag} has no assets; expected ${expected}" >&2
    exit 1
fi
if [[ ${assets} != "${expected}" ]]; then
    echo "::error::release ${tag} carries [${assets}], expected exactly [${expected}]" >&2
    exit 1
fi

work=$(mktemp -d)
trap 'rm -rf "${work}"' EXIT
gh release download "${tag}" --dir "${work}"
"${repo_root}/tools/ci/verify-server-zip.sh" "${work}/AccompliceServer-${version}.zip" "${version}" "${work}/checksums.txt"

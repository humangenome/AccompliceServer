#!/usr/bin/env bash
# Checks a release's server zip against the bundle contract before anyone
# downloads it.
#
# A server host installs AccompliceServer-<version>.zip by its exact name and
# hash, and refuses one whose version, file list or hashes disagree. This gate
# makes the release page refuse the same zip first: a release whose zip says
# one version and whose tag says another, or whose checksum line is wrong, is
# a broken install for everyone who takes it.
#
# Checks: the file name; checksums.txt (one sha256sum line, for this zip);
# exactly the five entries of the contract and nothing else; the manifest's
# id, version and single assembly; accomplice-server.json's name, version,
# and the size and SHA-256 of every file it lists; README.txt names the
# version and has no unfilled placeholder.
#
# Usage:
#   tools/ci/verify-server-zip.sh <zip> <version> [checksums.txt]
#
# Prints `SERVER ZIP PASS <version>` on success, and every problem on failure.

set -euo pipefail

zip=${1:-}
version=${2:-}
sums=${3:-}

if [[ -z ${zip} || -z ${version} ]]; then
    echo "usage: verify-server-zip.sh <zip> <version> [checksums.txt]" >&2
    exit 2
fi
[[ -f ${zip} ]] || { echo "verify-server-zip: missing ${zip}" >&2; exit 1; }
[[ -z ${sums} || -f ${sums} ]] || { echo "verify-server-zip: missing ${sums}" >&2; exit 1; }
[[ ${version} =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]] || { echo "verify-server-zip: version '${version}' is not MAJOR.MINOR.PATCH" >&2; exit 2; }

python3 -I - "${zip}" "${version}" "${sums}" <<'PY'
import hashlib, json, os, re, sys, zipfile
import xml.etree.ElementTree as ET

zip_path, version, sums_path = sys.argv[1], sys.argv[2], sys.argv[3]
problems = []
def fail(msg):
    problems.append(msg)
    print("SERVER ZIP FAIL: " + msg, file=sys.stderr)

expected_name = "AccompliceServer-%s.zip" % version
if os.path.basename(zip_path) != expected_name:
    fail("file is named %s, expected %s" % (os.path.basename(zip_path), expected_name))

with open(zip_path, "rb") as f:
    zip_sha = hashlib.sha256(f.read()).hexdigest()

# ------------ checksums.txt: exactly one sha256sum line, for this zip

if sums_path:
    lines = [l for l in open(sums_path, encoding="utf-8").read().splitlines() if l.strip()]
    if len(lines) != 1:
        fail("checksums.txt has %d lines, expected exactly one (the zip's)" % len(lines))
    for line in lines:
        m = re.fullmatch(r"([0-9a-f]{64}) [ *](\S+)", line)
        if not m:
            fail("checksums.txt line is not in sha256sum format: %r" % line)
            continue
        if m.group(2) != expected_name:
            fail("checksums.txt names %s, expected %s" % (m.group(2), expected_name))
        if m.group(1) != zip_sha:
            fail("checksums.txt says %s, the zip is %s" % (m.group(1), zip_sha))

# ------------ entries: exactly the contract, nothing else

contract = {
    "Mods/Accomplice/Accomplice.dll",
    "Mods/Accomplice/manifest.xml",
    "README.txt",
    "THIRD-PARTY-NOTICES.txt",
    "accomplice-server.json",
}
try:
    z = zipfile.ZipFile(zip_path)
except zipfile.BadZipFile as e:
    fail("not a readable zip: %s" % e)
    sys.exit(1)

names = z.namelist()
if len(names) != len(set(names)):
    fail("the zip lists an entry twice")
for n in names:
    if n.endswith("/"):
        fail("directory entry in the zip: %s" % n)
    elif n not in contract:
        fail("entry the contract does not name: %s" % n)
for n in sorted(contract - set(names)):
    fail("missing entry: %s" % n)
bad = z.testzip()
if bad:
    fail("CRC check failed on %s" % bad)
if problems:
    sys.exit(1)

data = {n: z.read(n) for n in names}
sha = {n: hashlib.sha256(b).hexdigest() for n, b in data.items()}

# ------------ manifest.xml

try:
    root = ET.fromstring(data["Mods/Accomplice/manifest.xml"])
    mid = (root.findtext("ID") or "").strip()
    mver = (root.findtext("ModVersion") or "").strip()
    asms = [(a.text or "").strip() for a in root.findall("./Assemblies/Assembly")]
    if mid != "humangenome_accomplice":
        fail("manifest ID is %r, expected 'humangenome_accomplice'" % mid)
    if mver != version:
        fail("manifest ModVersion is %r, expected %r" % (mver, version))
    if asms != ["Accomplice.dll"]:
        fail("manifest assemblies are %r, expected exactly ['Accomplice.dll']" % asms)
except ET.ParseError as e:
    fail("manifest.xml does not parse: %s" % e)

# ------------ accomplice-server.json

try:
    info = json.loads(data["accomplice-server.json"].decode("utf-8"))
except (UnicodeDecodeError, ValueError) as e:
    fail("accomplice-server.json does not parse: %s" % e)
    info = {}
if info:
    if info.get("name") != "AccompliceServer":
        fail("accomplice-server.json name is %r, expected 'AccompliceServer'" % info.get("name"))
    if info.get("version") != version:
        fail("accomplice-server.json version is %r, expected %r" % (info.get("version"), version))
    if info.get("mod_id") != "humangenome_accomplice":
        fail("accomplice-server.json mod_id is %r, expected 'humangenome_accomplice'" % info.get("mod_id"))
    listed = {}
    for entry in info.get("files") or []:
        p = entry.get("path")
        if p in listed:
            fail("accomplice-server.json lists %s twice" % p)
        listed[p] = entry
    for n in sorted(contract - {"accomplice-server.json"}):
        e = listed.get(n)
        if e is None:
            fail("accomplice-server.json does not list %s" % n)
            continue
        if e.get("sha256") != sha[n]:
            fail("accomplice-server.json says %s is %s, it is %s" % (n, e.get("sha256"), sha[n]))
        if e.get("size") != len(data[n]):
            fail("accomplice-server.json says %s is %s bytes, it is %d" % (n, e.get("size"), len(data[n])))
    for p in sorted(set(listed) - contract):
        fail("accomplice-server.json lists a file the zip does not carry: %s" % p)
    fp = info.get("fingerprint") or {}
    if fp.get("manifest") != sha["Mods/Accomplice/manifest.xml"]:
        fail("accomplice-server.json fingerprint.manifest is not the manifest's SHA-256")
    if fp.get("files") != ["Accomplice.dll|" + sha["Mods/Accomplice/Accomplice.dll"]]:
        fail("accomplice-server.json fingerprint.files is not the DLL's SHA-256")

# ------------ README.txt

readme = data["README.txt"].decode("utf-8", errors="replace")
first = readme.splitlines()[0].strip() if readme.strip() else ""
if first != "Accomplice server %s" % version:
    fail("README.txt's first line is %r, expected 'Accomplice server %s'" % (first, version))
if "{{" in readme or "}}" in readme:
    fail("README.txt has an unfilled {{...}} placeholder")

if problems:
    print("SERVER ZIP FAILED with %d problem(s)." % len(problems), file=sys.stderr)
    sys.exit(1)
print("SERVER ZIP PASS %s (%s, sha256 %s)" % (version, os.path.basename(zip_path), zip_sha))
PY

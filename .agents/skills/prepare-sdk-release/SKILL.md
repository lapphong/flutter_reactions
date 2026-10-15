---
name: prepare-sdk-release
description: Use this skill when preparing a new release for flutter_reactions SDK, including determining the next semantic version from git history, updating pubspec.yaml, CHANGELOG.md, README.md, scripts/create_tag.sh, running make clean, make format, and pushing to the dev branch.
---

# Prepare SDK Release Workflow

This skill defines the standard procedure for bumping versions, maintaining documentation, running quality checks, and publishing release commits for `flutter_reactions`.

---

## Release Checklist & Workflow

### 1. Analyze Git History & Determine the Next Version
Examine all commits and diffs since the last release tag:
```bash
git log -n 10 --oneline
git describe --tags --abbrev=0
git diff <last-tag>..HEAD
```

Apply Semantic Versioning (`MAJOR.MINOR.PATCH`):
- **PATCH (`x.y.Z`)**: Refactoring (`refactor:`), bug fixes (`fix:`), internal performance improvements, animation adjustments without public API additions or breaking changes.
- **MINOR (`x.Y.0`)**: New backward-compatible features (`feat:`), new public parameters, new widgets, or configuration options.
- **MAJOR (`X.0.0`)**: Breaking API changes or major architectural overhauls.

---

### 2. Update Version Across Files

Update the following files to match the new `<VERSION>`:

1. **`pubspec.yaml`**:
   ```yaml
   version: <VERSION>
   ```

2. **`CHANGELOG.md`**:
   Add a new entry at the top:
   ```markdown
   ## <VERSION>
   - Bullet point describing the key changes, features, or fixes in English.
   ```

3. **`README.md`**:
   Update the quickstart dependency snippet:
   ```yaml
   dependencies:
     flutter_reactions: ^<VERSION>
   ```

4. **`scripts/create_tag.sh`**:
   Update the `VERSION` variable:
   ```bash
   VERSION=<VERSION>
   ```

---

### 3. Run Build & Format via Makefile

Execute the Makefile targets to clean artifacts, regenerate dependencies, and format source code:

1. **Clean & Update Dependencies**:
   ```bash
   make clean
   ```
   *Note: `scripts/clean.sh` cleans both root and `example/`, then runs `flutter pub get`. This ensures `example/pubspec.lock` reflects the new version of `flutter_reactions`.*

2. **Format Code & Remove Unused Imports**:
   ```bash
   make format
   ```
   *Note: `scripts/format.sh` runs `dart format --set-exit-if-changed .` and `dart fix --apply --code=unused_import`.*

3. **Verify Tests & Static Analysis**:
   ```bash
   flutter test
   flutter analyze
   ```

---

### 4. Verify Git Diff & Push to `dev`

1. Review changes:
   ```bash
   git status
   git diff
   ```
   The expected modified files for a release are:
   - `pubspec.yaml`
   - `CHANGELOG.md`
   - `README.md`
   - `scripts/create_tag.sh`
   - `example/pubspec.lock`

2. Commit changes using standard release message format:
   ```bash
   git add CHANGELOG.md README.md pubspec.yaml scripts/create_tag.sh example/pubspec.lock
   git commit -m "release v<VERSION>"
   ```

3. Push to `dev` branch:
   ```bash
   git push origin dev
   ```

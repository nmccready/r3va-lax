# no-hardcoded-paths

**Trigger:** Always on. Applies to every file written to or edited in this repo.

## Rule

**Never** write an absolute path that contains a username or machine name into any file in this repo. This is a privacy and portability issue: anyone who clones the repo can read the path, and the path only works on the original operator's machine.

Forbidden segments anywhere in a path string:

- `/Users/<anything>/...` (macOS)
- `/home/<anything>/...` (Linux)
- `C:\Users\<anything>\...` (Windows)

This applies to **all** file types, including but not limited to:

- `.agents/settings.json` and `.claude/settings.json` permission entries (`Bash(...)`, `Edit(...)`, `Write(...)`, `Read(...)`)
- Shell scripts under `.agents/skills/**/scripts/`
- Hugo config, content frontmatter, layout templates
- CI configs, docs, READMEs

## Substitutions

| Situation                                       | Use                       |
| ----------------------------------------------- | ------------------------- |
| Path is inside this repo                        | `$CLAUDE_PROJECT_DIR/...` |
| Path is outside the repo, under operator's home | `$HOME/...`               |
| Path is relative to the tool's working dir      | Relative path             |

`$CLAUDE_PROJECT_DIR` is expanded by the Claude Code harness at runtime and resolves to the project root regardless of where the repo was cloned, so it is the right choice for anything under `.agents/`, `content/`, `themes/`, etc.

## Workflow

1. **Before writing or editing a file**, scan the proposed content for `/Users/`, `/home/`, or `C:\Users\` and substitute.
2. **Before committing**, re-scan the staged diff with `git diff --cached | grep -E '/Users/|/home/|C:\\\\Users\\\\'`. Any hit must be fixed before the commit lands.
3. **If you find a pre-existing hardcoded path** while working on something else, treat it as a bug and fix it in the current change — do not leave it for "later".

## Why

The operator's username on their machine is not something they want broadcast to every visitor of the public repo. Hardcoded paths also silently break the repo for any other contributor and for CI.

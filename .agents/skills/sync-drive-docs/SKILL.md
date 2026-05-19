---
trigger: always_on
---

# sync-drive-docs

Pull canonical R3VA 2026 numbers — per-player pricing, roster sizes, practice schedules, cost-breakdown components — out of the R3VA Google Drive folder and reconcile them against the static copy baked into the site.

This is the **money / logistics** half of site sync. Tournament names and dates come from the organizer (see [[sync-tournament-details]]); pricing, roster math, and practice cadences come from R3VA's own planning docs in Drive.

## Why a separate skill

The site already shows hard numbers — `$215 / $265 / $200 / $282`, roster ranges, ~15% operational margin, practice dates like `Jun 1, 5, 8, 12`. Those are decisions, not facts you can scrape off a tournament page. If the underlying spreadsheet in Drive changes (a field rental gets renegotiated, insurance rate moves, roster targets shift), the site silently drifts. This skill is the guardrail.

## Inputs

R3VA 2026 documents live under the user's Drive at roughly `/My Drive/Lax/R3VA/2026/`. Authoritative artifacts typically include:

- `R3VA 2026 Internal Cost Breakdown` (Sheet) — source for the per-player table in [content/teams/_index.md](../../../content/teams/_index.md).
- `R3VA Lax Interest Responses 2026` (Sheet, linked from the Google Form) — source for the response tally that drives "we'll run a team if enough kids vote yes." See also [[sync-interest-form]].
- Any practice-schedule docs the user keeps in the same folder.

The exact filenames may change. Resolve them at run-time via the Google Drive MCP tools rather than hardcoding IDs.

## Workflow

1. **Resolve files**. Use `mcp__claude_ai_Google_Drive__search_files` to list candidates in `/My Drive/Lax/R3VA/2026/`. Confirm the right document with the user before reading — Drive search can return near-matches from prior years.
2. **Read content**. Use `mcp__claude_ai_Google_Drive__read_file_content` (or `download_file_content` for Sheets) to pull the canonical numbers.
3. **Locate site copies**. Grep the repo for each number you found in Drive:
   ```
   grep -rEn '\$215|\$265|\$200|\$282|RiverCity|6:00.8:00 PM|6:00.7:30 PM' content/ hugo.yaml
   ```
   Adjust the pattern as numbers change.
4. **Diff & propose**. For each canonical value that no longer appears in the site (or has a stale variant present), build a punch-list of file:line edits and show it to the user before applying.
5. **Record state**. Write `.agents/STATE_drive-sync_<YYYYMMDDHHMMSS>.md` per the [state](../../rules/state.md) rule, noting which Drive doc was authoritative for which site number.

## Hard rules

- **Never** write back to Drive. This skill is read-only against `mcp__claude_ai_Google_Drive__*` tools. Use `read_file_content` / `search_files` / `get_file_metadata` only — never `create_file`, `copy_file`, etc.
- **Never** auto-apply price/roster changes. A wrong number here is a money problem for parents. Always confirm with the user.
- **Don't** pull from the responses sheet without checking with the user first — it contains parent contact info and falls under the [security](../../../CLAUDE.md) rule about least-privilege handling of personal data.
- If a Drive doc is missing or the user isn't authenticated to the MCP, surface that and stop. Don't substitute "what looks reasonable" from the site copy.

## Related

- [[sync-tournament-details]] — the other half of site sync; runs against external tournament pages.
- [[sync-interest-form]] — uses the linked responses sheet to gauge interest, with different access constraints.

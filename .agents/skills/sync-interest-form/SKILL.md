---
trigger: always_on
---

# sync-interest-form

Keep three things in agreement:

1. [GOOGLE_FORM_SPEC.md](../../../GOOGLE_FORM_SPEC.md) — the spec for the live R3VA Lax Summer 2026 Interest Form.
2. The form link embedded at [content/interest.md:20](../../../content/interest.md#L20) — currently `https://forms.gle/9vrSJmw5R8Cs8Mk99`.
3. The actual live Google Form (and its linked responses sheet) in the user's Drive.

If the live form has been edited (a field renamed, an option added, the URL re-shortened), the spec drifts and the site's "What We're Asking" list becomes a lie.

## When to run

- Whenever the user mentions editing the Google Form.
- Before publishing changes to [content/interest.md](../../../content/interest.md).
- When the form URL on `interest.md` returns a 404 / "form not found".
- Periodically while the form is collecting interest (Summer 2026 ramp).

## Workflow

1. **Verify the link**. `WebFetch https://forms.gle/9vrSJmw5R8Cs8Mk99` — confirm it resolves to a Google Forms page and the title still matches `R3VA Lax — Summer 2026 Interest Form`. Anything else (404, different title, expired) is a hard stop — surface to the user.
2. **Locate the form in Drive**. Use `mcp__claude_ai_Google_Drive__search_files` with query `R3VA Lax — Summer 2026 Interest Form` (or the current title) to find both the Form file and its linked responses sheet (`R3VA Lax Interest Responses 2026`).
3. **Compare against the spec**. For each section of [GOOGLE_FORM_SPEC.md](../../../GOOGLE_FORM_SPEC.md) (Title, Description, Fields 1–9, Settings), diff against what the live form actually contains. Google Forms doesn't have a clean read-API via the Drive MCP — at minimum, scan the form's public HTML via `WebFetch` and look for each field label, option list, and the confirmation message.
4. **Diff site copy**. The user-facing list at [content/interest.md:28-34](../../../content/interest.md#L28-L34) summarizes the form questions in plain English. If a question is renamed or removed, that bullet list needs to match.
5. **Propose edits**. Always show diffs and wait for confirmation before editing the spec or `interest.md`. If the form itself is wrong (relative to the spec the user agreed on), surface that — the fix is in Google Forms, not in this repo.
6. **Responses sheet** is out of scope for editing. Only confirm it exists, is linked, and is shared with `zbricktarz@gmail.com` (read) per the spec's "Sharing the Linked Sheet" section. Do **not** read individual responses unless the user explicitly asks — see security note below.

## Hard rules

- **Never** invent a new form URL. If `https://forms.gle/9vrSJmw5R8Cs8Mk99` breaks, ask the user for the new short link — do not guess, do not search.
- **Never** read parent response data without explicit user consent. The responses sheet contains names, emails, phone numbers — personal data. Treat as least-privilege per the [security](../../../CLAUDE.md) rule.
- **Never** create / duplicate / modify the form via `mcp__claude_ai_Google_Drive__create_file` etc. The form is the user's source of truth; this skill only reads and reports.
- The spec and the live form must agree on field 7's validation (`Email address`) and field 4's "Either works for us" option — these two are load-bearing for the tournament-preference tally.

## Related

- [[sync-tournament-details]] — the tournament dates referenced in the form's "Season Preference" field come from there.
- [[sync-drive-docs]] — the same Drive folder holds the responses sheet; share the same MCP-auth state.

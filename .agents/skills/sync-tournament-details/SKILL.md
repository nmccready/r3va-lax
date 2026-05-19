---
trigger: always_on
---

# sync-tournament-details

Keep tournament-level facts (name, dates, location, venue, format rules, registration deadlines) on the R3VA Lax site in agreement with each tournament's own published page.

The site mentions two Summer 2026 tournaments:

- **Legends Eastern Invitational** — Jun 27–28, 2026 — Midlothian, VA (River City Sportsplex)
- **Freedom Lax Fest** — Jul 11–12, 2026 — Havelock, NC

These show up in [hugo.yaml](../../../hugo.yaml), [content/teams/_index.md](../../../content/teams/_index.md), and [content/interest.md](../../../content/interest.md). If one of them drifts (tournament moves a weekend, renames itself, changes venue), every one of those files needs the same edit.

## When to run

- Before publishing or pushing content to GitHub Pages.
- Whenever the user asks "are the tournament dates still right?" / "is the venue correct?" / "did anything change for the Invitational?"
- After receiving any external signal (email, social post, organizer message) that suggests tournament details may have shifted.
- On a periodic cadence (e.g. monthly until late spring 2026) — see [`schedule`](../../../CLAUDE.md) skill if the user wants to automate it.

## Inputs (canonical sources)

`manifest.yaml` in this directory lists the tournament name, organizer site, registration page, and the on-site files where that tournament is referenced. Update the manifest when URLs are confirmed — placeholder `TBD` entries mean the canonical URL is not yet known and the agent must ask the user (or search the web with the user's consent) before fetching.

## Workflow

1. **Read** `manifest.yaml`. For each tournament:
   - Extract every reference in the listed `mentioned_in` files using `scripts/extract-site-facts.sh <tournament-key>` (read-only — outputs a JSON-ish bag of `{file, line, fact}`).
2. **Fetch** the canonical page(s) via `WebFetch` (one per tournament source URL). Ask `WebFetch` to extract: official tournament name, start/end dates, host city + state, venue, age groups offered, registration deadline, team-fee/per-player cost.
3. **Diff**. Compare extracted site-facts vs. fetched canonical-facts. Categorize each diff:
   - **Drift** (canonical changed; site stale) — propose edits to the listed files.
   - **Local override** (we deliberately phrased it differently — e.g. "Midlothian, VA" while the canonical says "Chesterfield County, VA"). Note this in `manifest.yaml` under `overrides:` so future runs don't re-flag it.
   - **Canonical unreachable** (404/timeout) — surface to user, do **not** silently delete site copy.
4. **Propose edits**. Show the user a punch-list of file:line edits before applying. Apply only with confirmation.
5. **Record state**. After applying, write a state file at `.agents/STATE_tournament-sync_<YYYYMMDDHHMMSS>.md` per the [state](../../rules/state.md) rule, listing what changed and what's still TBD.

## Hard rules

- **Never** invent a URL. If the canonical URL for a tournament is `TBD` in the manifest, stop and ask the user — do not guess or fall back to Google search results without explicit consent (per the system rule against fabricated URLs).
- **Never** edit content silently. Always show a diff and wait for confirmation.
- Treat the tournament organizer's site as authoritative for dates/venue/name; treat R3VA's own pricing tables (under "Cost per Player") as authoritative for *our* per-player rate — those come from [`sync-drive-docs`](../sync-drive-docs/SKILL.md), not from the tournament page.
- Don't modify [content/about.md](../../../content/about.md) — it describes R3VA's philosophy, not tournament logistics. Out of scope.

## Related

- [[sync-drive-docs]] — pulls canonical roster/pricing/practice numbers from the R3VA 2026 Google Drive folder.
- [[sync-interest-form]] — keeps the Google Form spec and live form URL aligned.

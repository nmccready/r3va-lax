### 20260518204134 STATE: sync-tournament-details run

Drift-sync pass against canonical organizer pages for Summer 2026 tournaments.

## What I found

The pre-run state had the **June tournament misnamed in the skill's own files** (manifest.yaml and SKILL.md still said "Legends Richmond Rumble, Jun 13–14") while the actual site content had already been updated to the real tournament — Legends Eastern Invitational, Jun 27–28. User confirmed the site copy was correct; the skill's manifest had drifted.

Canonical pages fetched:
- Legends Eastern Invitational — https://legendslax.com/event/legends-eastern-invitational-26/
- Freedom Lax Fest — https://www.cclaxtourney.com/

Canonical confirmed: name, dates, city/state for both. Venue (River City Sportsplex) confirmed for June. Freedom Lax Fest canonical also exposed a **registration deadline of 2026-07-01** with a **deposit due 2026-06-10** — neither was on the site.

## What changed

- [x] `manifest.yaml` — `legends-richmond-rumble` entry rewritten to `legends-eastern-invitational` with dates `2026-06-27/2026-06-28`, organizer URL, and LeagueApps registration URL filled in.
- [x] `manifest.yaml` — Freedom Lax Fest `url` and `registration_url` filled in; added `registration_deadline: 2026-07-01` and `deposit_deadline: 2026-06-10`.
- [x] `manifest.yaml` — venue `display_name` normalized to `River City Sportsplex` (two words, lowercase 'sportsplex'), per user preference.
- [x] `scripts/extract-site-facts.sh` — `case "$key"` branch and grep pattern updated for the new key. Verified the new key finds all 14 site references.
- [x] `SKILL.md` — "two tournaments" preamble updated; rewording of the "did anything change for the Rumble?" prompt example.
- [x] Venue spelling normalized: `RiverCity SportsPlex` → `River City Sportsplex` in `content/teams/_index.md`, `10u.md`, `12u.md`, `14u.md`, `16u.md` (10 occurrences total).
- [x] `content/teams/_index.md` Option B section — added a "Registration deadlines (organizer)" bullet noting the Jun 10 deposit and Jul 1 registration close.

## What I did NOT change (flagged for awareness)

- [ ] `content/interest.md:32` says `"June (Richmond, VA tournament)"` — canonical city is Midlothian; "Richmond" is regional shorthand. User did not ask to normalize.
- [ ] `GOOGLE_FORM_SPEC.md:46` same shorthand. Dates are now correct.
- [ ] Canonical Eastern Invitational page did not expose age groups or per-team pricing in the fetched text. Site's age groups / per-player rates remain unverified against canonical — those come from [sync-drive-docs](../.claude/skills/sync-drive-docs/SKILL.md) anyway.
- [ ] Venue URL for River City Sportsplex still `TBD` in `manifest.yaml`. Low priority.
- [ ] Deadline note only added to `content/teams/_index.md`. The four per-age-group pages (`10u.md`/`12u.md`/`14u.md`/`16u.md`) still don't show the Jul 1 / Jun 10 dates under their July Option sections — user opted not to duplicate this run.

## Resumption / sessions

- No Claude Code session ID captured for this run.
- Next periodic re-run can be triggered with `/sync-tournament-details`. The two organizer URLs are now persisted in `manifest.yaml`, so the next run won't need to ask for them.
- If the user wants a recurring monthly cadence, `/schedule` or `/loop` could wrap this skill.

# R3VA Lax — Interest Form (Google Form Spec)

Create at: <https://forms.google.com/create> (signed in as `nmccready@gmail.com` — saves the response Sheet to your Drive automatically).

## Form Title
`R3VA Lax — Summer 2026 Interest Form`

## Form Description
Help us build the right teams for Summer 2026. **No payment or commitment yet** — just an interest vote. We'll run a team if enough kids vote yes and let you know within 2 weeks. Takes 60 seconds.

---

## Fields

### 1. Player First & Last Name
- Type: **Short answer**
- Required: ✓

### 2. Player's Grade in Fall 2026
- Type: **Multiple choice (single)**
- Required: ✓
- Options:
  - 2nd grade
  - 3rd grade
  - 4th grade
  - 5th grade
  - 6th grade
  - 7th grade
  - 8th grade
  - Other

### 3. Age Group(s) Interested In
- Type: **Checkboxes (multi-select)**
- Required: ✓
- Help text: "Pick all that apply — some kids fit in two bands depending on the Aug 31, 2026 age cutoff."
- Options:
  - 8U — Class of 2036
  - 9U — Class of 2035
  - 10U — Class of 2034
  - 11U — Class of 2033
  - 12U — Class of 2032
  - 13U — Class of 2031

### 4. Season Preference
- Type: **Multiple choice (single)**
- Required: ✓
- Options:
  - June — Richmond, VA tournament (Jun 27–28)
  - July — NC tournament (Jul 11–12)
  - Either works for us
  - Neither — different dates needed (explain in comments)

### 5. Prior Lacrosse Experience
- Type: **Multiple choice (single)**
- Required: ✓
- Options:
  - None — total beginner
  - Some — 1 season or basic play
  - Experienced — multiple seasons

### 6. Parent / Guardian Name
- Type: **Short answer**
- Required: ✓

### 7. Parent Email
- Type: **Short answer**
- Required: ✓
- Response validation: Email address

### 8. Parent Phone (for fast comms)
- Type: **Short answer**
- Required: ✓

### 9. Anything else we should know?
- Type: **Paragraph (long answer)**
- Required: ✗
- Help text: "Gear questions, schedule conflicts, sibling on another team, etc."

---

## Settings

### Responses tab
- Click the green Sheets icon → "Create new spreadsheet" → name it `R3VA Lax Interest Responses 2026`. Saves to Drive at `/My Drive/Lax/R3VA/2026/` (move there manually).

### Settings → General
- ✓ Collect email addresses (Verified) — back-up in case parent typos field 7
- ✓ Limit to 1 response — keep it clean
- ✗ Edit after submit — keep votes simple

### Settings → Presentation
- ✗ Show progress bar
- Confirmation message:
  > Thanks! We'll tally votes and confirm which teams are running within 2 weeks. Questions? Email nmccready@gmail.com.

### Settings → Defaults
- Don't make any questions required by default (set per-question above)

---

## After Creation

1. Click **Send** → copy the public link (shortened or not).
2. Paste the link into `content/interest.md` line 18 — replace `https://forms.google.com/REPLACE-WITH-FORM-URL`.
3. Optionally embed the form directly (Send → `<>` icon → iframe code) into `interest.md`.
4. Share the form link on Instagram, Facebook, group chats.

---

## Sharing the Linked Sheet

Once you have responses:
- Open the Sheet (from Forms → Responses → Sheet icon)
- Share with `zbricktarz@gmail.com` (read access) — TARS can then read votes via rclone for analysis/tallies.

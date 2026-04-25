# Repository Guidelines

## Project Structure & Module Organization
This repository manages multiple Marp slide decks in one place.

- `shared/`: shared theme and assets, including `shared/theme.css` and `shared/assets/`.
- `drafts/`: human-written Markdown drafts, outlines, and notes to refine with AI before turning them into slides.
- `_template/`: starter deck copied for new presentations.
- `YYYY-MM-topic/`: each slide deck lives in its own directory and must contain `slides.md`; keep deck-specific images under `images/`.
- `scripts/`: utility scripts such as `scripts/new-slide.sh`.
- `docs/`: GitHub Pages output. `docs/index.html` is a manually maintained landing page.
- `.github/workflows/`: CI/CD for Pages deployment and PDF artifact generation.

## Build, Test, and Development Commands
- `npm install`: install Marp CLI and local dependencies.
- `npm run new -- my-topic`: create a new deck as `YYYY-MM-my-topic/` from `_template/`.
- `npm run dev -- YYYY-MM-my-topic`: start Marp watch mode and local preview server for a deck.
- `npm run build:html`: build all `slides.md` files to `docs/<deck>/index.html`.
- `npm run build:pdf`: build all decks to `dist/<deck>.pdf`.

Run `npm run build:html` before publishing changes that affect navigation or shared theme files.

## Coding Style & Naming Conventions
Use Markdown for slide content and CSS for theme changes. Keep formatting simple and consistent:

- Use `YYYY-MM-topic-name` for deck directories.
- Name the entry file `slides.md`.
- Keep rough ideas and prose drafts in `drafts/*.md`; move finalized slide content into `YYYY-MM-topic/slides.md`.
- Store deck assets in a sibling `images/` directory.
- Use 2 spaces for YAML front matter indentation and 2 spaces in HTML/CSS blocks already present in the repo.

No formatter or linter is configured. Match the existing style in nearby files.

## OGP Metadata
`npm run build:html` generates `docs/<deck>/og.png` from the first slide and sets it as the deck's `og:image` / X large summary card image.

For every new deck, add explicit metadata to the `slides.md` front matter:

- `lang: ja` for Japanese decks, or the appropriate language code.
- `title: "..."` with the full share title. Do not rely on Marp's automatic title extraction when the title slide uses multiple headings or line breaks.
- `description: "..."` with a short event or deck summary.

Without an explicit `title`, Marp may use only the first heading on the title slide, which can make the X/OGP card title look truncated.

## English Slide Versions
When preparing an English version of an existing deck, keep it as a separate deck:

- Create a sibling directory named `YYYY-MM-topic-name-en/`.
- Translate the original `slides.md` into `YYYY-MM-topic-name-en/slides.md`.
- Add `lang: en` to the English deck front matter and use an English footer.
- Copy the original deck's `images/` directory into the English deck so it is self-contained.
- Add a link from the original title slide to the English GitHub Pages URL, such as `https://k9i-0.github.io/marp-slides/YYYY-MM-topic-name-en/`.
- Add a link from the English title slide back to the original Japanese GitHub Pages URL.
- Update `docs/index.html` so both the Japanese and English decks appear on the landing page.

After adding the English deck, run `npm run build:html`. Run `npm run build:pdf` too if PDF export should be verified.

## Testing Guidelines
There is no automated test suite yet. Validate changes by:

- running `npm run build:html`
- running `npm run build:pdf` for export-related changes
- previewing the edited deck with `npm run dev -- <deck>`

If you add or rename a deck, also update `docs/index.html` so it appears on the landing page.

## Commit & Pull Request Guidelines
Recent commits use short Japanese summaries such as `Marionette MCP call_custom_extension のスライドを追加`. Follow that pattern: concise, descriptive, and action-focused.

PRs should include:

- a brief purpose summary
- the affected deck or shared files
- screenshots or generated output notes when visuals changed
- linked issue or context when applicable

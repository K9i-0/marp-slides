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

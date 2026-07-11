# CLAUDE.md

This file is read by Claude Code at the start of every session in this repo.

---

## About This Repo

Shared protobuf contracts for the Command and Control Center (CCC)
homelab platform. Proto definitions live under `proto/`, managed with
buf (v2 config). Generated Go code is committed under `gen/go/` as a
standalone Go module (`github.com/amcheste/ccc-protos/gen/go`) so
consuming services just `go get` a tagged release.

Rules that matter here:

- Never edit anything under `gen/` by hand. Change the proto, then run
  `make generate` and commit the result. CI fails PRs with stale codegen.
- `buf breaking` gates every PR against the base branch. A breaking
  change to a published package means a new version directory (`v2/`),
  not an in-place edit of `v1/`.
- Tool versions (buf, protoc-gen-go, protoc-gen-go-grpc) are pinned in
  the Makefile so local and CI output stay byte-identical. Bump them
  there, regenerate, and commit together.
- Proto style follows buf STANDARD lint: package per service per major
  version (`ccc.<service>.v1`), UNSPECIFIED zero enum values, unique
  Request/Response message per RPC.

---

## Developer Preferences

### Editor
- Primary: Vim
- AI editor: Cursor

### Shell
- zsh, minimal prompt

### Git & GitHub Workflow
- **Branch model:** `main` = latest release. `develop` = integration branch.
- Always branch from `develop`, never commit directly
- PRs always target `develop`
- `main` is only updated via CLI merge (`git merge --no-ff origin/develop`) by `/publish-release` — **never via a GitHub PR**. GitHub's merge button squash-merges by default, dropping ancestry and causing conflicts on the next release.
- Conventional commits: `feat:`, `fix:`, `docs:`, `chore:`

### Scripting Standards
- Shell scripts must pass `shellcheck`
- Use `set -euo pipefail`
- Scripts should be idempotent

---

## Brand

This repo descends from [`amcheste/repo-template`](https://github.com/amcheste/repo-template), which is brand-aligned with [`@amcheste/brand`](https://github.com/amcheste/alanchester-brand). Badge colors (Hunter Green `#1F4D3A`, Ink `#0B0B0C`) match the brand by default.

When generating prose, follow the brand voice rules at [`voice.md`](https://github.com/amcheste/alanchester-brand/blob/main/docs/voice.md): no em dashes in prose, calibrated hedges over weak ones, lowercase eyebrows, numerical specificity. Hunter green is reserved for data, pivots, and the δ; don't use it as decoration.

For deeper brand integration (palette adoption, mark embedding, full theming sweep), paste [`docs/theming-prompt.md`](https://github.com/amcheste/alanchester-brand/blob/main/docs/theming-prompt.md) from the brand repo into a Claude Code session in this repo.

---

## Learned Preferences

<!-- Claude Code will suggest additions here as patterns emerge across sessions -->

# Onboarding track (mentors)

Student entry: **[GUIDE.md](GUIDE.md)**. Setup: **[../SETUP.md](../SETUP.md)**
(pre-built IFSSIM binary + this repo’s Docker stack).

## Reset a broken student tree

```bash
cd ifs-onboarding
git fetch origin
git reset --hard origin/main   # or whatever the published branch is
```

Pipeline gaps are **vendored in this repo** under `pipeline/` (not a live
submodule checkout). To refresh gaps from upstream IFS08-DV-PIPELINE
`onboarding`, copy/sync carefully and re-commit here.

Production solutions: `git diff` against IFS08-DV-PIPELINE `dev` for the
same file paths.

### Facilitation tips

- Order: package → pub/sub → distance filter → pipeline Phase B ROS →
  perception/control toys.  
- ROS toys (01–03) and Phase A pytest (04–07) run in
  `docker-compose.onboarding.yml` / `tools/onboarding-ros.ps1` — students
  should not install ROS on the host.
- Run Phase A pytest before anyone touches `pipeline/` algorithm blanks.  
- Timebox peeks at `solutions/`.  
- Do **not** put full API one-liners in TODO comments.

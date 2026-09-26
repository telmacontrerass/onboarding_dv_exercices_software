# Setup (onboarding repo)

Goal: pre-built IFSSIM binary on the host + this repo’s Docker stack, so the
car can move once autonomy TODOs are filled. **No Unreal Engine install and
no IFSSIM source clone required.**

End-to-end time is dominated by Docker image build (~5–10 min cold).

---

## 0. Prerequisites

| Tool | Notes |
|------|--------|
| **Git** | clone this repo |
| **Docker Desktop ≥ 4.34** | ≥ 6 GB RAM in Settings → Resources |
| **IFSSIM release zip** | from [IFSSIM Releases](https://github.com/isc-fs/IFSSIM/releases/latest) — Windows or Mac package |

You do **not** need UE 5.7, Visual Studio, or Xcode for this path.

---

## 1. Clone this repo

```bash
git clone <ifs-onboarding-url>
cd ifs-onboarding
```

---

## 2. Download the simulator binary

From [IFSSIM Releases](https://github.com/isc-fs/IFSSIM/releases/latest),
download the platform zip (e.g. `IFSSIM-*-Windows-x64.zip` or `*-Mac.zip`).

Unzip **anywhere convenient** (Desktop, `~/sims/IFSSIM`, …). You only need
the runnable app / `IFSSIM.exe` — not the full git tree.

Launch the sim once and leave it running. It should listen for RPC on
**TCP `:41451`** (default).

---

## 3. Build and start the Docker stack

From **this** repo root:

```bash
docker compose build
docker compose up -d
```

Containers: `dv_pipeline_stack` (bridge + autonomy), Mission Control
backend/frontend, Lichtblick.

Open **Mission Control** at http://localhost:3000 — load a track →
Configure → Start Session.

If the bridge cannot reach the sim, set `IFSSIM_HOST` / `IFSSIM_PORT` in
`.env` (copy from `.env.example`). On Docker Desktop,
`host.docker.internal` is the usual host gateway.

---

## 4. Edit cycle (after filling TODOs)

- Python pipeline edits: see `tools/compose-up-and-watch.sh` (or rebuild).
- C++ bridge / msgs / launch: `tools/refresh-bridge.sh` then recreate the
  `dv_pipeline_stack` container.

Full daily-ops detail still lives in upstream IFSSIM
[`docs/OPERATING.md`](https://github.com/isc-fs/IFSSIM/blob/dev/docs/OPERATING.md)
if you need it later.

---

## 5. ROS exercises (no host ROS install)

Exercises 01–03 need ROS 2 Humble + `colcon`. Exercises 04–07 Phase A
need `pytest` + `numpy`. **Do not install ROS on the host** — use the
slim onboarding image (separate from the sim stack above):

```bash
docker compose -f docker-compose.onboarding.yml up -d --build
.\tools\onboarding-ros.ps1
```

That shell is a colcon workspace at `/ws` whose `src/` is
`onboarding/exercises/` on the host. Commands are in
**[onboarding/GUIDE.md](onboarding/GUIDE.md)**.

Phase B pipeline tests (`path_planning`, `control`) still run inside
`dv_pipeline_stack` after this repo’s main `docker compose up`.

---

## 6. Start the learning track

→ **[onboarding/GUIDE.md](onboarding/GUIDE.md)**

---

## Linux notes

Supported the same way as IFSSIM’s Docker path: ensure
`extra_hosts` / `host.docker.internal` resolves to the host running the
sim binary (see `docker-compose.yml`).
On Linux set `IFSSIM_HOST=127.0.0.1` in `.env` (Mac/Windows can keep `host.docker.internal`).

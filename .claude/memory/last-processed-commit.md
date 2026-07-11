# Last processed commit — update-product-doc

The `update-product-doc` skill processes the repo delta *since* the commit named
below, then advances this marker to `HEAD` and stages it alongside `README.md`.
This decouples the living-doc / landing update from any single commit (it can run
on demand over an interval) and drives it from the target-audience changelog
(`changelog/adopter.md`) over that window.

Reprocessing an already-reflected commit is idempotent for a current-state
document, so a marker that lags by the doc-update commit itself is harmless.

Seeded at the tip of `master` at incorporation time; `README.md` reflects the
product through this commit.

2574ce15e5b5392ed258f40a5f5e0bf1ee942a64

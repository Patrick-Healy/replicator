# Libraries

This folder stores local copies of user-written packages to ensure reproducibility.

## Why bundle packages locally?

1. **Offline execution**: Code runs on non-networked computers (e.g., research data centers)
2. **Version control**: Package versions are locked at the time of analysis
3. **Reproducibility**: Future users get identical package behavior

## Structure

```
libraries/
├── stata/     # Stata ado-files installed via _install_stata_packages.do
└── R/         # R packages (if not using renv)
    ├── linux/
    ├── osx/
    └── windows/
```

## Stata

Run `_install_stata_packages.do` to install packages here. The master script (`run.do`) configures Stata to use only these local packages.

Delete `_install_stata_packages.do` before finalizing your replication package to lock package versions.

## R

**Recommended**: Use `renv` instead of this folder. The `renv.lock` file records exact package versions, and `renv::restore()` reinstalls them.

**Alternative**: Install packages to OS-specific subfolders for full cross-platform replication (see `_install_R_packages.R`).

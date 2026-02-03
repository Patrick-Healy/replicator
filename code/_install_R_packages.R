#===============================================================================
# Install R Packages
#
# Description: Installs R packages required for this project. There are three
#              options for managing R packages:
#
#              Option 1 (Recommended): Use renv for full reproducibility
#                       Packages are installed to renv/library/
#                       Run: renv::restore()
#
#              Option 2: Install to user library (simpler but less reproducible)
#                       Run this script directly
#
#              Option 3: Install to project library (cross-platform replication)
#                       Uncomment the local library code below
#                       Note: Requires separate installation for each OS
#
# Instructions:
#   1. Edit the package list below to match your project's needs
#   2. Run this script or use renv::restore()
#
# Note: This script can be called from Stata using the rscript package
#===============================================================================

#-------------------------------------------------------------------------------
# OPTION 1: Use renv (Recommended)
#-------------------------------------------------------------------------------

# If using renv, just run renv::restore() instead of this script
# renv::restore()

#-------------------------------------------------------------------------------
# OPTION 2: Install to user library
#-------------------------------------------------------------------------------

# List of required packages
packages <- c(
    # Data manipulation
    "tidyverse",
    "data.table",
    "haven",        # Read Stata/SAS/SPSS files
    "readxl",       # Read Excel files

    # Econometrics
    "fixest",       # Fast fixed effects estimation
    "lfe",          # Linear fixed effects
    "sandwich",     # Robust standard errors
    "lmtest",       # Hypothesis testing
    "plm",          # Panel data
    "AER",          # Applied econometrics

    # Visualization
    "ggplot2",
    "ggthemes",
    "scales",
    "patchwork",    # Combine plots

    # Tables
    "modelsummary", # Regression tables
    "kableExtra",   # Nice tables
    "stargazer",    # LaTeX tables

    # Other
    "here",         # Project-relative paths
    "tictoc"        # Timing
)

# Install missing packages
install_if_missing <- function(pkg) {
    if (!requireNamespace(pkg, quietly = TRUE)) {
        cat("Installing:", pkg, "\n")
        install.packages(pkg, repos = "https://cloud.r-project.org")
    } else {
        cat("Already installed:", pkg, "\n")
    }
}

invisible(sapply(packages, install_if_missing))

#-------------------------------------------------------------------------------
# OPTION 3: Install to project library (uncomment to use)
#-------------------------------------------------------------------------------

# # Define OS-specific library path
# os <- Sys.info()["sysname"]
# lib_path <- switch(os,
#     "Windows" = "libraries/R/windows",
#     "Darwin"  = "libraries/R/osx",
#     "Linux"   = "libraries/R/linux"
# )
#
# # Create directory if needed
# dir.create(lib_path, recursive = TRUE, showWarnings = FALSE)
#
# # Install packages to local library
# install.packages(packages,
#     lib = lib_path,
#     repos = "https://cloud.r-project.org"
# )
#
# # To use local library in your scripts, add:
# # .libPaths(c("libraries/R/[os]", .libPaths()))

#-------------------------------------------------------------------------------
# VERIFY INSTALLATION
#-------------------------------------------------------------------------------

cat("\n==============================================\n")
cat("Package installation complete\n")
cat("==============================================\n")

# Check which packages loaded successfully
for (pkg in packages) {
    status <- if (requireNamespace(pkg, quietly = TRUE)) "OK" else "MISSING"
    cat(sprintf("%-20s %s\n", pkg, status))
}

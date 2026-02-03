#===============================================================================
# Master Script - [Project Name]
#
# Description: This script executes the entire analysis pipeline from raw data
#              to final tables and figures. Running this script will reproduce
#              all results in the paper.
#
# Instructions:
#   1. Open this file in RStudio or set working directory to code/
#   2. Run: source("run.R")
#
# Requirements:
#   - R 4.0 or later
#   - Packages listed in renv.lock (installed via renv::restore())
#
# Authors: [Names]
# Date: [Date]
#===============================================================================

# Clear environment
rm(list = ls())

# Set random seed for reproducibility
set.seed(12345)

#-------------------------------------------------------------------------------
# CONFIGURATION
#-------------------------------------------------------------------------------

# Auto-detect project directory (assumes script is run from code/)
PROJECT <- getwd()

# Alternative: Set manually if needed
# PROJECT <- "/path/to/your/project/code"

# Alternative: Use environment variable from .Rprofile
# PROJECT <- Sys.getenv("MyProject")

#-------------------------------------------------------------------------------
# SETUP
#-------------------------------------------------------------------------------

# Define subdirectories using relative paths
DATA     <- file.path(PROJECT, "..", "data")
RAW      <- file.path(DATA, "raw")
INTERIM  <- file.path(DATA, "interim")
ANALYSIS <- file.path(DATA, "analysis")
RESULTS  <- file.path(PROJECT, "..", "paper", "results")
TABLES   <- file.path(RESULTS, "tables")
FIGURES  <- file.path(RESULTS, "figures")
SCRIPTS  <- PROJECT

# Create output directories if they don't exist
dir.create(INTERIM, showWarnings = FALSE, recursive = TRUE)
dir.create(ANALYSIS, showWarnings = FALSE, recursive = TRUE)
dir.create(TABLES, showWarnings = FALSE, recursive = TRUE)
dir.create(FIGURES, showWarnings = FALSE, recursive = TRUE)

# Activate renv for reproducible package management
if (file.exists("renv/activate.R")) {
    source("renv/activate.R")
}

# Load required packages
library(tidyverse)
library(fixest)
library(data.table)

# Start logging
sink(file.path(PROJECT, "run_log.txt"), split = TRUE)

cat("==============================================\n")
cat("Project: [Project Name]\n")
cat("Date:", format(Sys.time(), "%Y-%m-%d %H:%M:%S"), "\n")
cat("R version:", R.version.string, "\n")
cat("==============================================\n\n")

#-------------------------------------------------------------------------------
# RUN ANALYSIS PIPELINE
#-------------------------------------------------------------------------------

# Step 1: Data preparation
cat("\nStep 1: Preparing data...\n")
source(file.path(SCRIPTS, "dataprep", "population", "clean_population.R"))
source(file.path(SCRIPTS, "dataprep", "weather", "merge_weather.R"))
source(file.path(SCRIPTS, "dataprep", "create_analysis_data.R"))

# Step 2: Analysis
cat("\nStep 2: Running analysis...\n")
source(file.path(SCRIPTS, "analysis", "summary_statistics.R"))
source(file.path(SCRIPTS, "analysis", "regressions.R"))

#-------------------------------------------------------------------------------
# FINISH
#-------------------------------------------------------------------------------

cat("\n==============================================\n")
cat("Analysis complete!\n")
cat("Tables saved to:", TABLES, "\n")
cat("Figures saved to:", FIGURES, "\n")
cat("==============================================\n")

sink()

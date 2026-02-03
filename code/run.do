/*******************************************************************************
* Master Script - [Project Name]
*
* Description: This script executes the entire analysis pipeline from raw data
*              to final tables and figures. Running this script will reproduce
*              all results in the paper.
*
* Instructions:
*   1. Set the PROJECT global below to point to the code/ directory
*   2. Run this script: do run.do
*
* Requirements:
*   - Stata 17 or later
*   - User-written packages are included in libraries/stata/
*
* Authors: [Names]
* Date: [Date]
*******************************************************************************/

version 17
clear all
set more off
set varabbrev off

* Set random seed for reproducibility
set seed 12345

*------------------------------------------------------------------------------
* CONFIGURATION - Edit this section
*------------------------------------------------------------------------------

* Define project directory (only line that needs editing per user)
* Option 1: Set manually
global PROJECT "/path/to/your/project/code"

* Option 2: Auto-detect if running from the code/ directory
* global PROJECT "`c(pwd)'"

* Option 3: Use Dropbox global defined in your Stata profile
* global PROJECT "$DROPBOX/my-project/code"

*------------------------------------------------------------------------------
* SETUP - Do not edit below this line
*------------------------------------------------------------------------------

* Define subdirectories using relative paths
global DATA     "$PROJECT/../data"
global RAW      "$DATA/raw"
global INTERIM  "$DATA/interim"
global ANALYSIS "$DATA/analysis"
global RESULTS  "$PROJECT/../paper/results"
global TABLES   "$RESULTS/tables"
global FIGURES  "$RESULTS/figures"
global SCRIPTS  "$PROJECT"

* Set up ado path to use project-specific libraries only
* This ensures reproducibility by using only bundled packages
tokenize `"$S_ADO"', parse(";")
while `"`1'"' != "" {
    if `"`1'"'!="BASE" cap adopath - `"`1'"'
    macro shift
}
adopath ++ "$PROJECT/libraries/stata"

* Create output directories if they don't exist
cap mkdir "$INTERIM"
cap mkdir "$ANALYSIS"
cap mkdir "$TABLES"
cap mkdir "$FIGURES"

* Log the session
cap log close _all
log using "$PROJECT/run_log.txt", replace text name(main)

di "=============================================="
di "Project: [Project Name]"
di "Date: $S_DATE $S_TIME"
di "Stata version: `c(stata_version)'"
di "=============================================="

*------------------------------------------------------------------------------
* RUN ANALYSIS PIPELINE
*------------------------------------------------------------------------------

* Step 1: Data preparation
di _n "Step 1: Preparing data..."
do "$SCRIPTS/dataprep/population/clean_population.do"
do "$SCRIPTS/dataprep/weather/merge_weather.do"
do "$SCRIPTS/dataprep/create_analysis_data.do"

* Step 2: Analysis
di _n "Step 2: Running analysis..."
do "$SCRIPTS/analysis/summary_statistics.do"
do "$SCRIPTS/analysis/regressions.do"

* Step 3: Generate tables and figures
di _n "Step 3: Generating tables and figures..."
do "$SCRIPTS/analysis/make_tables.do"
do "$SCRIPTS/analysis/make_figures.do"

*------------------------------------------------------------------------------
* FINISH
*------------------------------------------------------------------------------

di _n "=============================================="
di "Analysis complete!"
di "Tables saved to: $TABLES"
di "Figures saved to: $FIGURES"
di "=============================================="

log close main

/*******************************************************************************
* Install Stata Packages
*
* Description: Installs user-written Stata packages into the project's local
*              libraries/stata/ directory. This ensures:
*              1. Code runs on computers without internet access
*              2. Package versions are locked for reproducibility
*              3. All collaborators use identical package versions
*
* Instructions:
*   1. Edit the package list below to match your project's needs
*   2. Run this script once to install packages
*   3. DELETE this script before creating your final replication package
*      (this locks down the package versions)
*
* Note: After installation, package info is recorded in libraries/stata/stata.trk
*       View with: ado describe, from("$PROJECT/libraries/stata")
*******************************************************************************/

version 17
clear all

* Set project directory
global PROJECT "`c(pwd)'"

* Define local library path
local libpath "$PROJECT/libraries/stata"

* Create library directory if it doesn't exist
cap mkdir "`libpath'"

* Set adopath to install packages to project folder
net set ado "`libpath'"

*------------------------------------------------------------------------------
* INSTALL PACKAGES - Edit this list for your project
*------------------------------------------------------------------------------

* Essential packages for regression analysis
ssc install reghdfe, replace
ssc install ftools, replace
ssc install estout, replace

* Table automation (Julian Reif's packages)
net install regsave, from("https://raw.githubusercontent.com/reifjulian/regsave/master") replace
net install texsave, from("https://raw.githubusercontent.com/reifjulian/texsave/master") replace
net install rscript, from("https://raw.githubusercontent.com/reifjulian/rscript/master") replace

* Fast data manipulation
ssc install gtools, replace

* Additional packages (uncomment as needed)
* ssc install ivreg2, replace
* ssc install ranktest, replace
* ssc install outreg2, replace
* ssc install coefplot, replace
* ssc install binscatter, replace
* ssc install rdrobust, replace
* ssc install did_multiplegt, replace
* ssc install eventstudyinteract, replace
* ssc install csdid, replace

*------------------------------------------------------------------------------
* VERIFY INSTALLATION
*------------------------------------------------------------------------------

di _n "=============================================="
di "Installed packages in: `libpath'"
di "=============================================="
ado dir, from("`libpath'")

di _n "IMPORTANT: Delete this script (_install_stata_packages.do)"
di "before creating your final replication package."

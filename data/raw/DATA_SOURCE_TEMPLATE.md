# [Data Source Name]

## Citation

> [Full bibliographic citation for this data source]

**Example:**
> U.S. Bureau of Labor Statistics. 2023. "Current Population Survey, Annual Social and Economic Supplement." https://www.census.gov/programs-surveys/cps.html. Accessed: January 15, 2024.

## Access Information

| Field | Value |
|-------|-------|
| **Provider** | [Organization name] |
| **URL** | [Download URL] |
| **Date accessed** | [YYYY-MM-DD] |
| **Version/Release** | [If applicable] |
| **License** | [Public domain / CC-BY / Restricted / etc.] |

## Access Requirements

- [ ] **Publicly available** - No restrictions
- [ ] **Registration required** - Free account at [URL]
- [ ] **Application required** - Apply at [URL], typical wait time: [X weeks]
- [ ] **Fee required** - Cost: [Amount] for [license type]
- [ ] **Restricted access** - Available only at [location/RDC]

## Files

| Filename | Description | Size | Format |
|----------|-------------|------|--------|
| `file1.csv` | [Description] | [X MB] | CSV |
| `file2.dta` | [Description] | [X MB] | Stata |
| `documentation.pdf` | Official codebook | [X MB] | PDF |

## Checksums (Optional)

For data integrity verification:

```
MD5 (file1.csv) = [hash]
SHA256 (file1.csv) = [hash]
```

Generate with:
- Mac/Linux: `md5 file1.csv` or `shasum -a 256 file1.csv`
- Windows: `certutil -hashfile file1.csv MD5`

## Key Variables Used

| Variable | Description | Notes |
|----------|-------------|-------|
| `var1` | [Description] | [Any transformations applied] |
| `var2` | [Description] | |

## Sample Restrictions

Describe any sample restrictions applied to this data:

- [ ] Geographic: [Countries/states included]
- [ ] Temporal: [Years/periods included]
- [ ] Demographic: [Age/gender restrictions]
- [ ] Other: [Describe]

## Known Issues

Document any data quality issues:

- [Issue 1 and how addressed]
- [Issue 2 and how addressed]

## Related Scripts

| Script | Purpose |
|--------|---------|
| `code/dataprep/[source]/clean.do` | Initial cleaning |
| `code/dataprep/[source]/merge.do` | Merge with other sources |

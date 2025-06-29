# dbl_export

This repository provides a daily export of the domain blocklists maintained at [dbl.aschi.at](https://dbl.aschi.at).

## Purpose

The exported lists in this repository allow you to use the blocklist data directly from GitHub – for example, in scripts, DNS tools, or other automated environments where GitHub-based syncing is preferred.

The lists are updated automatically every day via a scheduled job running on the server.  
They include multiple formats, such as plain text, hosts file, AdBlock-style filters, and CSV for analysis.

If you prefer the live versions (always up to date), visit:  
👉 https://dbl.aschi.at/blacklist.txt_info.php

## Formats included

- `blacklist.txt` – plain domain list
- `blacklist.abp.txt` – AdBlock/EasyList compatible
- `blacklist.hosts.txt` – HOSTS file format (0.0.0.0)
- `blacklist.csv` – full structured data

## Example Entries

### blacklist.txt
A simple domain-per-line format:
```
tracker.example.com
ads.badsite.org
malware.evilhost.net
```

---

### blacklist.abp.txt
AdBlock Plus / uBlock Origin style:
```
||tracker.example.com^
||ads.badsite.org^
||malware.evilhost.net^
```

---

### blacklist.hosts.txt
Classic HOSTS file format using `0.0.0.0`:
```
0.0.0.0 tracker.example.com
0.0.0.0 ads.badsite.org
0.0.0.0 malware.evilhost.net
```

---

### blacklist.csv
Structured CSV with full metadata:
```
domain,category,source,added_at
tracker.example.com,tracking,127.0.0.1,2025-06-29 06:00:00
ads.badsite.org,ads,127.0.0.1,2025-06-29 06:00:00
malware.evilhost.net,malware,127.0.0.1,2025-06-29 06:00:00
```
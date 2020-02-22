# auto-disk-cache

- Automatically cache (by copying to a different destination) new files and folders within a directory.

- Automatically remove cache files after specified number of days

- Run frequently with systemd o/e to ensure near real-time caching (recommend every 5 minutes)

- Cache is stored as standard files / folders allowing easy recovery in the case of data loss

- Keeps the **latest** version of a file as of the final run of each day; does not keep every version!

## Variables
Set your variables before running

```
SOURCE=[Folder to monitor for changes]
DESTINATION=[Cache location]
DAYS=[Number of days of cache to retain]
```
# auto-disk-cache

## Features
- Automatically cache (by copying to a different destination) new files and folders within a directory.

- Automatically remove cache files after specified number of days

- Monitors source folder and makes copies in near-real-time

- Cache is stored in unencrypted files / folders allowing easy recovery in the case of data loss

- Keeps the **latest** version of a file daily; does not keep every version!

## Variables
Set your variables in `sync.sh` before installing or running

```
source=[Folder to monitor for changes]
destination=[Cache location]
days=[Number of days of cache to retain]
```

## Installation
You can either run `sync.sh` manually, or use the included sample service file.

```
$ sudo cp auto-disk-cache.service /etc/systemd/system/auto-disk-cache.service
$ sudo chmod 644 /etc/systemd/system/auto-disk-cache.service

$ sudo systemctl enable auto-disk-cache
$ sudo systemctl start auto-disk-cache
```

**OR**

Just run `install.sh`
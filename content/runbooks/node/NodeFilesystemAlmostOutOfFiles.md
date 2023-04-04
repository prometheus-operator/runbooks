---
title: Node Filesystem Almost Out Of Files
weight: 20
---

# NodeFilesystemAlmostOutOfFiles

## Meaning

This alert is similar to the NodeFilesystemSpaceFillingUp alert, but rather
than being based on a prediction that a filesystem will run out of inodes in a
certain amount of time, it uses simple static thresholds. The alert will fire as
at a `warning` level at 5% of available inodes left, and at a `critical` level
with 3% of available inodes left.

## Impact

A node's filesystem becoming full can have a far reaching impact, as it may
cause any or all of the applications scheduled to that node to experience
anything from performance degradation to full inoperability. Depending on the
node and filesystem involved, this could pose a critical threat to the stability
of the cluster.

## Diagnosis

- Check the current inode usage by running the command df -i. This will show you the inode usage for all mounted file systems. Identify the file system(s) that are running low on inodes.
- Identify the directories that are consuming the most inodes by running the command sudo find <directory> -xdev -type f | cut -d "/" -f 2 | sort | uniq -c | sort -n. Replace <directory> with the path to the directory that you want to check. This command will show you the number of files in each directory under <directory>.
- Check if there are any unnecessary or temporary files that can be deleted to free up some inodes. You can use the command sudo find <directory> -type f -mtime +<n> -print to find files that haven't been modified in the last <n> days. Replace <directory> with the path to the directory that you want to search and <n> with the number of days that you want to search back.
- If the above steps don't help to free up enough inodes, consider resizing the file system or moving some files to another file system with more available inodes.


## Mitigation

See [Node Filesystem FilesFilling Up]({{< ref "./NodeFilesystemFilesFillingUp.md" >}})


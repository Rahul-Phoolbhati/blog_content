
## Disk Image - 
A **disk image** is basically a file that’s an exact copy of a whole storage device — like a hard drive, USB stick, CD, or DVD. It captures everything:

- **Files and folders**
- **System information**
- **Hidden data**    
- **Boot information** (if it's a system disk)

Common formats - `.iso`, `.img`, `.dmg` (on Mac), and `.vmdk` 

## Qemu 
QEMU (Quick EMUlator) is a free and open-source emulator and virtualization tool that allows you to run operating systems and programs made for one machine architecture on different hardware. For example, you can run ARM software on x86 computers or vice versa.

### qemu-img
command to create image - 
```
qemu-img create -f qcow2 mydisk.qcow2 20G
```

#### What Happens when with this command ?
It **doesn't** actually fill up 20 GB (or whatever size you ask for) immediately.
1. **It creates a file** — for example, `mydisk.qcow2`.
2. **It sets up the structure** inside that file to act like a real hard drive.
3. **If it's qcow2 or other "smart" formats**, it makes a tiny file at first (maybe just a few kilobytes!) and only **grows** as you actually store real data inside.
4. **If it's raw format**, it might immediately create a full empty 20 GB file — because raw is just a straight, blank space.
👉 _No OS, no files, no partitions yet — just a virtual "blank" drive._


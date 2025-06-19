---
date: 2025-06-19
title: Qemu Emulation of Tiny Core Linux
---


```
## Download the iso image of the tiny core linux

	http://www.tinycorelinux.net/downloads.html

## Create a virtual hard disk with Qemu

```
	qemu-img create -f qcow2 corelinux.img 20G

```
> wondering! what this command do ?
> check my this blog - [Qemu Disk Image](./BlogsForEmb/QEMU-Disk-Image.md)

## Running a virtual machine

✅ **Purpose**: You're starting a VM that boots from an the ISO of core linux, with 2 GB RAM, and uses your previously created virtual hard disk.
```
qemu-system-x86_64 -cdrom core-current.iso -m 2048 -hda corelinux.img -boot d

```

> replace the 
> **_core-current.iso_**  -> the name of the iso downloaded iso image of the tiny core linux
> **_corelinux.img_** -> the image name you gave in the previous command.


It will run the live mode of tiny core linux kernal, Where we can run basic commands which are included into this.

## Installing Packages into Tiny Core

We need some tools into this for running files or compiling it or doing many things. For this Tiny Core has extensions which you can search with command 
```
tce-ab
```

and to download and install the extension we can write -
```
tce-load -wi vim
```

now you can use vim into this live mode of the Tiny Core.




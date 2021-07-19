#!/bin/sh

mount bpffs /sys/fs/bpf -t bpf
mount --make-shared /sys/fs/bpf

/bin/k3s $@

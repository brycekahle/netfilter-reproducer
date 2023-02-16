#!/bin/bash

set -e
set -o pipefail

# run this separately before attempting bisect
# make defconfig && cat extra.config >> .config
make olddefconfig && \
make -j8
if [ $? -ne 0 ] ; then
	exit 125 # build failed, skip current revision.
fi

qemu-system-x86_64 -nographic -append console=ttyS0 -kernel arch/x86/boot/bzImage -initrd ./initrd.gz | grep "^===SUCCESS"

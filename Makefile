all:
	CGO_ENABLED=0 go build -ldflags="-extldflags=-static" ./cmd/init
	strip init
	echo init | cpio -H newc -o | gzip > initrd.gz

clean:
	-rm -f init initrd.gz

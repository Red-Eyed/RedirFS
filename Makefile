KERNEL_VERS = `uname -r`
KERNEL_BUILDDIR = /lib/modules/$(KERNEL_VERS)/build
ROOT_PATH=`pwd`
REDIRFS_DIR="$(ROOT_PATH)/redirfs"

ifndef EXCHANGE
	EXTRA_CFLAGS=-DRFS_EXCHANGE_D_CHILD=0
else
	EXTRA_CFLAGS=-DRFS_EXCHANGE_D_CHILD=1
endif

all:
	make -C $(KERNEL_BUILDDIR) M=$(REDIRFS_DIR) EXTRA_CFLAGS=$(EXTRA_CFLAGS) modules

install:
	make -C $(KERNEL_BUILDDIR) M=$(REDIRFS_DIR) modules_install

clean:
	make -C $(KERNEL_BUILDDIR) M=$(REDIRFS_DIR) clean
	# remove all exept *.c and ".*h" files
	find $(REDIRFS_DIR)/ -mindepth 1 ! -name "*.c" ! -name "*.h" ! -name "Makefile" ! -name "README" | xargs -I {} -t rm -rf {}

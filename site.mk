##	gluon site.mk makefile for Freifunk Mayen-Koblenz

GLUON_FEATURES := \
	autoupdater-fallback \
	config-mode-domain-select \
	config-mode-geo-location-osm \
	ebtables-filter-multicast \
	ebtables-filter-ra-dhcp \
	ebtables-limit-arp \
	ebtables-source-filter \
	mesh-batman-adv-15 \
	mesh-vpn-fastd \
	radv-filterd \
	respondd \
	setup-mode \
	status-page \
	web-advanced \
	web-wizard \
	web-private-wifi

GLUON_FEATURES_standard := \
	mesh-wireless-sae \
	wireless-encryption-wpa3

GLUON_SITE_PACKAGES_tiny := \
	wpa-supplicant-dummy

GLUON_SITE_PACKAGES := \
	ffffm-button-bind \
	gluon-autoupdater-branch-fix \
	iptables \
	iwinfo \
	respondd-module-airtime

#############################
# Additional package sets
#############################

# USB Human Interface
USB_PACKAGES_HID := \
	kmod-usb-hid \
	kmod-hid-generic

# USB Serial
USB_PACKAGES_SERIAL := \
	kmod-usb-serial \
	kmod-usb-serial-ftdi \
	kmod-usb-serial-pl2303

# USB Storage
USB_PACKAGES_STORAGE := \
	block-mount \
	blkid \
	kmod-fs-ext4 \
	kmod-fs-ntfs \
	kmod-fs-vfat \
	kmod-usb-storage \
	kmod-usb-storage-extras \
	kmod-nls-base \
	kmod-nls-cp1250 \
	kmod-nls-cp1251 \
	kmod-nls-cp437 \
	kmod-nls-cp850 \
	kmod-nls-cp852 \
	kmod-nls-iso8859-1 \
	kmod-nls-iso8859-13 \
	kmod-nls-iso8859-15 \
	kmod-nls-iso8859-2 \
	kmod-nls-utf8 \
swap-utils

# USB Network
USB_PACKAGES_NET := \
	kmod-ath9k-htc \
	kmod-rt2800-usb \
	kmod-mii \
	kmod-nls-base \
	kmod-usb-net \
	kmod-usb-net-asix \
	kmod-usb-net-asix-ax88179 \
	kmod-usb-net-cdc-eem \
	kmod-usb-net-cdc-ether \
	kmod-usb-net-cdc-mbim \
	kmod-usb-net-cdc-subset \
	kmod-usb-net-dm9601-ether \
	kmod-usb-net-hso \
	kmod-usb-net-huawei-cdc-ncm \
	kmod-usb-net-ipheth \
	kmod-usb-net-kalmia \
	kmod-usb-net-kaweth \
	kmod-usb-net-mcs7830 \
	kmod-usb-net-pegasus \
	kmod-usb-net-qmi-wwan \
	kmod-usb-net-rndis \
	kmod-usb-net-rtl8152 \
	kmod-usb-net-sierrawireless \
	kmod-usb-net-smsc95xx

# PCI-Express Network
PCIE_PACKAGES_NET := \
	kmod-bnx2

# additional packages
TOOLS_PACKAGES := \
	iperf \
	socat \
	tcpdump \
	vnstat

# Group previous package sets
USB_PACKAGES_WITHOUT_HID := \
	usbutils \
	usb-modeswitch \
	$(USB_PACKAGES_SERIAL) \
	$(USB_PACKAGES_STORAGE) \
	$(USB_PACKAGES_NET)

USB_PACKAGES := \
	$(USB_PACKAGES_HID) \
	$(USB_PACKAGES_WITHOUT_HID)

PCIE_PACKAGES := \
	pciutils \
	$(PCIE_PACKAGES_NET)

##################################
# Assign package sets to targets
##################################

# Embedded Routers
ifeq ($(GLUON_TARGET),ar71xx-generic)
GLUON_SITE_PACKAGES += $(USB_PACKAGES_WITHOUT_HID)
endif

ifeq ($(GLUON_TARGET),ar71xx-nand)
GLUON_SITE_PACKAGES += $(USB_PACKAGES_WITHOUT_HID)
endif

ifeq ($(GLUON_TARGET),mpc85xx-generic)
GLUON_SITE_PACKAGES += $(USB_PACKAGES_WITHOUT_HID)
endif

# x86 Generic Purpose Hardware
ifeq ($(GLUON_TARGET),x86-generic)
GLUON_SITE_PACKAGES += $(USB_PACKAGES) $(PCIE_PACKAGES) $(TOOLS_PACKAGES)
endif

ifeq ($(GLUON_TARGET),x86-64)
GLUON_SITE_PACKAGES += $(USB_PACKAGES) $(PCIE_PACKAGES) $(TOOLS_PACKAGES)
endif

# PCEngines ALIX Boards
ifeq ($(GLUON_TARGET),x86-geode)
GLUON_SITE_PACKAGES += $(USB_PACKAGES) $(PCIE_PACKAGES) $(TOOLS_PACKAGES)
endif

#  Raspberry Pi A/B/B+
ifeq ($(GLUON_TARGET),brcm2708-bcm2708)
GLUON_SITE_PACKAGES += $(USB_PACKAGES)
endif

# Raspberry Pi 2
ifeq ($(GLUON_TARGET),brcm2708-bcm2709)
GLUON_SITE_PACKAGES += $(USB_PACKAGES)
endif

##	DEFAULT_GLUON_RELEASE
#		version string to use for images
#		gluon relies on
#			opkg compare-versions "$1" '>>' "$2"
#		to decide if a version is newer or not.
DEFAULT_GLUON_RELEASE := 0.8-ffmyk-$(shell date '+%Y%m%d')

# Enable autoupdater
GLUON_AUTOUPDATER_ENABLED := 1

##	GLUON_RELEASE
#		call make with custom GLUON_RELEASE flag, to use your own release version scheme.
#		e.g.:
#			$ make images GLUON_RELEASE=23.42+5
#		would generate images named like this:
#			gluon-ff%site_code%-23.42+5-%router_model%.bin

# Allow overriding the release number from the command line
GLUON_RELEASE ?= nightly

# Default priority for updates.
GLUON_PRIORITY ?= 30

# Region code required for some images; supported values: us eu
GLUON_REGION ?= eu

# Languages to include
GLUON_LANGS ?= en de

GLUON_MULTIDOMAIN = 1

GLUON_DEPRECATED = upgrade

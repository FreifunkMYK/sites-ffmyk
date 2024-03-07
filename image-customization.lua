features({
    'autoupdater-fallback',
    'config-mode-domain-select',
    'config-mode-geo-location-osm',
    'config-mode-mesh-vpn',
    'ebtables-filter-multicast',
    'ebtables-filter-ra-dhcp',
    'ebtables-limit-arp',
    'ebtables-source-filter',
    'mesh-batman-adv-15',
    'mesh-vpn-wireguard-vxlan',
    'radv-filterd',
    'respondd',
    'setup-mode',
    'status-page',
    'web-advanced',
    'web-wizard',
    'web-private-wifi'
})

if not device_class('tiny') then
    features({
        'mesh-wireless-sae',
        'wireless-encryption-wpa3'
    })
else
    features({
        'wpa-supplicant-dummy'
    })
end

packages({
    'ffffm-button-bind',
	'gluon-autoupdater-branch-fix',
	'iwinfo',
	'respondd-module-airtime',
})

-- MYK hackery - proceed at your own risk

-- Local package sets
local pkgs_usb = {
    'usbutils',
	'kmod-usb-core',
	'kmod-usb2',
}

local pkgs_usb_hid = {
    'kmod-usb-hid',
    'kmod-hid-generic'
}

local pkgs_usb_serial = {
    'kmod-usb-serial',
    'kmod-usb-serial-ch341',
    'kmod-usb-serial-cp210x',
    'kmod-usb-serial-ftdi',
    'kmod-usb-serial-pl2303'
}

local pkgs_usb_storage = {
    'block-mount',
    'blkid',
    'kmod-fs-ext4',
    'kmod-fs-ntfs',
    'kmod-fs-vfat',
    'kmod-usb-storage',
    'kmod-usb-storage-extras',  -- Card Readers
    'kmod-usb-storage-uas',     -- USB Attached SCSI (UAS/UASP)
    'kmod-nls-base',
    'kmod-nls-cp1250',          -- NLS Codepage 1250 (Eastern Europe)
    'kmod-nls-cp437',           -- NLS Codepage 437 (United States, Canada)
    'kmod-nls-cp850',           -- NLS Codepage 850 (Europe)
    'kmod-nls-cp852',           -- NLS Codepage 852 (Europe)
    'kmod-nls-iso8859-1',       -- NLS ISO 8859-1 (Latin 1)
    'kmod-nls-iso8859-13',      -- NLS ISO 8859-13 (Latin 7; Baltic)
    'kmod-nls-iso8859-15',      -- NLS ISO 8859-15 (Latin 9)
    'kmod-nls-iso8859-2',       -- NLS ISO 8859-2 (Latin 2)
    'kmod-nls-utf8'             -- NLS UTF-8
}

local pkgs_usb_net = {
    'usb-modeswitch',
	'ffda-usb-wan-hotplug',
	'ffka-gluon-web-usb-wan-hotplug',
    'kmod-mii',
    'kmod-usb-net',
    'kmod-usb-net-asix',
    'kmod-usb-net-asix-ax88179',
    'kmod-usb-net-cdc-eem',
    'kmod-usb-net-cdc-ether',
	'kmod-usb-net-cdc-mbim',
	'kmod-usb-net-cdc-ncm',
    'kmod-usb-net-cdc-subset',
    'kmod-usb-net-dm9601-ether',
    'kmod-usb-net-hso',
	'kmod-usb-net-huawei-cdc-ncm',
    'kmod-usb-net-ipheth',
	'kmod-usb-net-kalmia',
	'kmod-usb-net-kaweth',
    'kmod-usb-net-mcs7830',
    'kmod-usb-net-pegasus',
	'kmod-usb-net-qmi-wwan',
    'kmod-usb-net-rndis',
	'kmod-usb-net-rtl8150',
    'kmod-usb-net-rtl8152',
	'kmod-usb-net-sierrawireless',
    'kmod-usb-net-smsc95xx',
}

local pkgs_pci = {
    'pciutils'
}

local pkgs_pci_net = {
    'kmod-sky2',
	'kmod-r8169',
	'kmod-forcedeth',
	'kmod-8139too',
    'kmod-bnx2', -- Broadcom NetExtreme BCM5706/5708/5709/5716
}

local pkgs_tls = {
    'ca-bundle',
	'libustream-openssl'
}

local pkgs_tools = {
	'iperf3',
	'socat',
	'tcpdump',
	'vnstat',
    'haveged',
    'bash'
}

--exclusion lists

local exclude_tls = {
    'd-link-dir825b1',
    'netgear-wndr3700',
    'nexx-wt3020-8m',
}

local exclude_usb = {
    'avm-fritz-wlan-repeater-300e',
    'avm-fritz-wlan-repeater-450e',
    'd-link-dap-1330-a1',
    'd-link-dap-1365-a1',
    'd-link-dir-505',
    'devolo-wifi-pro-1200e',
    'devolo-wifi-pro-1200i',
    'devolo-wifi-pro-1750c',
    'devolo-wifi-pro-1750i',
    'devolo-wifi-pro-1750x',
    'librerouter-v1',
    'netgear-wndr3700',
    'netgear-wnr2200-8m',
    'ocedo-koala',
    'ocedo-raccoon',
    'openmesh-mr1750-v1',
    'openmesh-mr600-v1',
    'openmesh-mr900-v1',
    'openmesh-om2p-v1',
    'openmesh-om5p',
    'openmesh-om5p-ac-v1',
    'tp-link-archer-c25-v1',
    'tp-link-archer-c58-v1',
    'tp-link-archer-c6-v2-eu-ru-jp',
    'tp-link-archer-c60-v1',
    'tp-link-cpe210-v1',
    'tp-link-cpe210-v2',
    'tp-link-cpe210-v3',
    'tp-link-cpe220-v3',
    'tp-link-cpe510-v1',
    'tp-link-cpe510-v2',
    'tp-link-cpe510-v3',
    'tp-link-tl-wdr3500-v1',
    'tp-link-tl-wdr3600-v1',
    'tp-link-tl-wdr4300-v1',
    'tp-link-tl-wr810n-v1',
    'tp-link-tl-wr1043nd-v2',
    'tp-link-tl-wr1043nd-v3',
    'tp-link-wbs210-v1',
    'tp-link-wbs210-v2',
    'tp-link-wbs510-v1',
    'ubiquiti-unifi-ac-lite',
    'ubiquiti-unifi-ac-lr',
    'ubiquiti-unifi-ac-mesh',
    'ubiquiti-unifi-ac-mesh-pro',
    'ubiquiti-unifi-ac-pro',
    'ubiquiti-unifi-ap',
    'ubiquiti-unifi-ap-outdoor+',
    'ubiquiti-unifi-ap-pro',
    'tp-link-td-w8970',
    'netgear-ex3700',
    'nexx-wt3020-8m',
    'tp-link-archer-c20i',
    'tp-link-archer-c20-v1',
    'tp-link-archer-c2-v1',
    'tp-link-archer-c50-v1',
    'netgear-ex6150',
    'ubiquiti-edgerouter-x',
    'ubiquiti-edgerouter-x-sfp',
    'cudy-wr1000',
    'gl.inet-vixmini',
    'tp-link-archer-c50-v3',
    'tp-link-archer-c50-v4',
    'tp-link-tl-wa801nd-v5',
    'tp-link-tl-wr841n-v13',
    'tp-link-archer-c20-v4',
    'tp-link-archer-c20-v5',
    'tp-link-tl-mr3020-v3',
    'tp-link-tl-mr3420-v5',
    'tp-link-tl-wr902ac-v3',
    'netgear-r6020',
    'tp-link-re200-v2',
    'tp-link-re200-v3',
    'd-link-dir825b1',
    'gl.inet-gl-ar300m-lite', --list below copied from Freifunk Hannover
    'gl.inet-gl-ar750',
    'netgear-wndr3700-v2',
    'tp-link-archer-a7-v5',
    'tp-link-archer-c5-v1',
    'tp-link-archer-c7-v2',
    'tp-link-archer-c7-v5',
    'tp-link-archer-c59-v1',
    'tp-link-tl-wr842n-v3',
    'tp-link-tl-wr1043nd-v4',
    'gl-mt300n-v2',
    'tp-link-td-w8970',
    'tp-link-td-w8980',
    'avm-fritz-box-7412',
    'gl.inet-microuter-n300',
    'netgear-ex3700',
    'netgear-ex6150',
    'netgear-r6020',
    'ubiquiti-edgerouter-x-sfp',
    'ubiquiti-edgerouter-x',
    'ubiquiti-unifi-6-lr-v1',
    'zyxel-nwa55axe',
}

--Additional packages for specific targets
if (
    not device(exclude_tls) then
        packages(pkgs_tls)
end

if (
    target('ath79', 'generic') or
    target('ath79', 'mikrotik') or
    target('ath79', 'nand') or
    target('ipq40xx', 'generic') or
    target('ipq40xx', 'mikrotik') or
    target('ipq806x', 'generic') or
    target('lantiq', 'xrx200') or
    target('lantiq', 'xway') or
    target('mediatek', 'mt7622') or
    target('mediatek', 'filogic') or
    target('mpc85xx', 'p1010') or
    target('mpc85xx', 'p1020') or
    target('ramips', 'mt7620') or
    target('ramips', 'mt7621') or
    target('ramips', 'mt76x8') or
    target('realtek', 'rtl838x') or
    target('rockchip', 'armv8') or
    target('sunxi', 'cortexa7')
   ) and not device(exclude_usb) then
        packages(pkgs_usb)
        packages(pkgs_usb_net)
        packages(pkgs_usb_serial)
        packages(pkgs_usb_storage)
end

if target('x86', '64') or
   target('x86', 'generic') or
   target('x86', 'geode') or
   target('x86', 'legacy') or
   target('armsr', 'armv7') or
   target('armsr', 'armv8') then
        packages(pkgs_pci)
        packages(pkgs_pci_net)
        packages(pkgs_tls)
        packages(pkgs_tools)
        packages(pkgs_usb)
        packages(pkgs_usb_net)
        packages(pkgs_usb_hid)
        packages(pkgs_usb_serial)
        packages(pkgs_usb_storage)
end

if target('bcm27xx', 'bcm2708') or
   target('bcm27xx', 'bcm2709') then
        packages(pkgs_tools)
        packages(pkgs_usb)
        packages(pkgs_usb_net)
        packages(pkgs_usb_hid)
        packages(pkgs_usb_serial)
        packages(pkgs_usb_storage)
end

if target('x86', '64') then
    --packages({'qemu-ga'})
    --qemu guest agent broken as of 2024-03-06
    --https://gitlab.com/qemu-project/qemu/-/issues/1709
end

if device({
        'zte,mf281',
        'glinet,gl-xe300',
        'glinet,gl-ap1300',
        'zte,mf289f',
        'wavlink,ws-wn572hp3-4g',
        'tplink,tl-mr6400-v5',
    }) then
        features({'web-cellular'})
end

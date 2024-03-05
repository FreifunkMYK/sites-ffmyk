##	gluon site.mk makefile for Freifunk Mayen-Koblenz


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

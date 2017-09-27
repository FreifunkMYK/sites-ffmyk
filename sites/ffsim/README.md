#### How to build the Freifunk Rhein-Hunsrück-Kreis Firmware
    
    git clone https://github.com/freifunk-gluon/gluon.git          # Get the official Gluon repository
    cd gluon
    git clone https://github.com/freifunkmyk/site-ffsim.git site   # Get the Freifunk Rhein-Hunsrück-Kreis site repository
    make update                                                    # Get other repositories used by Gluon
    make GLUON_TARGET=ar71xx-generic                               # Build Gluon

Please see [the official Gluon repository](https://github.com/freifunk-gluon/gluon) for an in-depth explanation of the build process.


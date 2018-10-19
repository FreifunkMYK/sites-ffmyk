#### How to build the Freifunk Mayen-Koblenz Firmware
    
    git clone https://github.com/freifunkmyk/sites-ffmyk.git       # Get the Freifunk Mayen-Koblenz site repository
    cd sites-ffmyk
    git submodule update --init                                    # download the gluon submodule
    ./build.sh <version>                                           # build the current commit and name it <version>
    

Please see [the official Gluon repository](https://github.com/freifunk-gluon/gluon) for an in-depth explanation of the build process.

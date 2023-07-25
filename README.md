#### How to build the Freifunk Mayen-Koblenz Firmware

1. Prepare a buildroot. See [the official Gluon documentation](https://gluon.readthedocs.io/en/latest/user/getting_started.html#dependencies) for required host packages or instructions how to use gluons build container.
2. Clone this repository and check out the desired tag. You can see available tags here using the gui or with ```git tag```. Keep in mind *master* is used for development and is usually not a good coice if you intend to build a working firmware file.
    ```
    git clone https://github.com/freifunkmyk/sites-ffmyk.git       # Get the Freifunk Mayen-Koblenz site repository
    cd sites-ffmyk
    git checkout <version>
    ```
3. Download dependencies and initialize the gluon modules
    ```
    git submodule update --init                                    # download the gluon submodule
    ```
4. Build gluon. Files will be in *output/*. By default all targets will be compiled, you can optionally specify targets to build as a second argument.
    ```
    ./build.sh <version>                                           # build the current commit and name it <version>
    ```
    
Please see [the official Gluon repository](https://github.com/freifunk-gluon/gluon) for an in-depth explanation of the build process.

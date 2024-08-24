This repository contains tools and build scripts to automate the building of packages for the [X Binary Package System](https://github.com/void-linux/xbps) (XBPS).

## Overview

Packages can be created using the `xbps-src` utility from this repository. To build a specific package provide the package name as an argument to `xbps-src`. Available packages can be found in the `/srcpkgs` subdirectories.

After a successful build the resulting package is stored in `/binpkgs`. This directory can then be used as a XBPS repository to install from.

During compilation all source files are stored in `/pkgdir`. This directory is purged after a successful build. If an error occures all files in `/pkgdir` are left untouched for debugging purposes.

## Creating packages

For each new package first a new directory must be created in `/srcpkgs`. Then a `template` file must be created which contains the build instructions and package metadata.

### Package metadata

Variables are used to define package metadata:

```sh
pkgname='my-custom-package'
version='1.0'
revision='1'
arch='armv7l'
depends=() # add runtime dependencies here
makedepends=() # add build dependencies here
short_desc='This is my first custom package.'
license='custom'
homepage='https://example.org'
```

### Build instructions

Functions are used to automate the building of packages:

```sh
prepare() {
  # download sources for this package version
}

package() {
  # build the actual package (compile source files to binaries)
}
```

All files in the `/pkgdir` directory will be included in the final package when `package()` returns successfully.

### Signing packages

Packages are automatically signed after building. In order to sign packages, a signig key must be generated. This key can be generated with either `ssh-keygen` or `openssl`:

```sh
$ ssh-keygen -t rsa -m PEM -f signkey.pem
```

```sh
$ openssl genrsa -out signkey.pem
```

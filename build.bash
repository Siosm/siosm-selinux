#!/usr/bin/env bash

# Install only non-debug packages
pkginstall() {
    sudo pacman -U $(ls *.pkg.tar.xz | grep -v "\-debug")
}

# Build a package using some usefull makepkg options
pkgbuild() {
    makepkg -s && pkginstall
}

# Clean a PKGBUILD folder
pkgclean() {
    rm -rf src pkg
    rm *.pkg.tar.xz
    rm *.pkg.tar.xz.sig
}


for p in libsepol libselinux checkpolicy setools libcgroup libsemanage \
         sepolgen policycoreutils
do
	pushd ${p}
	pkgclean
	pkgbuild
	popd
done

for p in pambase-selinux pam-selinux coreutils-selinux shadow-selinux \
         cronie-selinux sudo-selinux util-linux-selinux systemd-selinux \
         openssh-selinux findutils-selinux psmisc-selinux
do
	pushd ${p}
	pkgclean
	pkgbuild
	popd
done

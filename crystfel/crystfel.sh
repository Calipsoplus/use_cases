yum install -y gcc gcc-gfortran libstdc++ GConf2 gtk2 libXtst curl hdf5 hdf5-devel libstdc++-devel libstdc++-static libgcc gtk2-devel libpng-devel ncurses-devel fftw-devel cairo-gobject-devel pango-devel gtk-doc gsl-devel bzip2 make cmake gcc gfortran autoconf automake tar unzip 2>&1 | grep -v "already installed and latest version"
mkdir -p /usr/local/src /usr/local/crystfel/bin

#
#  Crystfel itself
#
curl -L http://www.desy.de/~twhite/crystfel/crystfel-0.7.0.tar.gz  | gzip -dc | tar -xv -C /usr/local
pushd /usr/local/crystfel-0.7.0
./configure --prefix=/usr/local/crystfel
make && make install
popd
rm -rf /usr/local/crystfel-0.7.0
#
#  MOSFLM
#
# v7.2.2 has problems. revert back to mosflm 7.2.1!
curl -s -L http://www.desy.de/~schluenz/crystfel/mosflm-7.2.1.tgz | gzip -dc | tar -xv -C /usr/local/crystfel/bin/
ln -sf /usr/local/crystfel/bin/mosflm-linux-64-noX11 /usr/local/crystfel/bin/mosflm
ln -sf /usr/local/crystfel/bin/mosflm-linux-64-noX11 /usr/local/crystfel/bin/ipmosflm
#
#  aux files
#
curl -s -L http://www.desy.de/~schluenz/crystfel/default.def -o  /usr/local/crystfel/include/default.def
curl -s -L http://www.desy.de/~schluenz/crystfel/environ.def -o  /usr/local/crystfel/include/environ.def
curl -s -L http://www.desy.de/~schluenz/crystfel/clibd.tgz | gzip -dc | tar -xv -C /usr/local/crystfel/
#
#  Clean up
#
rm -rf /usr/local/src
pushd $HOME
curl https://www.desy.de/~schluenz/crystfel/crystfel.test.data.tgz | tar xvz


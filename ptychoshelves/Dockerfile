From centos:7
#centos:7
#

#help
# Singularity Container for the Ptycho Shelf package

# add appdefs for various commands!
%apprun matlab
   exec /usr/local/matlab/bin/matlab

LABEL version="20180730"
LABEL packager="Calipso+"
LABEL author="Calipos+"

ENV PATH=/usr/local/matlab/bin:/usr/lib64/openmpi3/bin:/usr/local/bin:$PATH \\
    LD_LIBRARY_PATH=/usr/lib64/openmpi3/lib:/usr/local/lib64:/usr/local/lib:/opt/intel/psxe_runtime/linux/mkl/lib/intel64_lin \\
    MATLABPATH=/usr/local/matlab/cSAXS_matlab_base:/usr/local/matlab/ptychoshelves \\
    MLM_LICENSE_FILE=/usr/local/matlab/licenses/license.dat \\
    MPI_HOME=/usr/lib64/openmpi3

%files 
  [ADD MATLAB OFFLINE INSTALLER] /
  [csaxs base package for matlab] /
  [ptychoshelves package for matlab] /

#
#  install base packages
#
RUN yum update && yum install -y dbus dejavu-lgc-sans-fonts gedit unzip gzip tar pam libXt GConf2 gtk2 libXtst python xterm wget which curl \\
    bzip2 hdf5 hdf5-devel gtk2-devel libpng-devel ncurses-devel fftw-devel gmp-devel mpfr-devel libmpc-devel autoconf automake m4 openmpi3 \\
    libgcc.i686 glibc.i686 libstdc++.i686 libgcc-devel.i686 glibc-devel.i686 libstdc++-devel.i686 
RUN yum groupinstall -y "Development tools"

#
#  install cuda  [current version has some cudart-8-0 dependency. So include both 9.1 and 8.0]
#  just the runtime. works on CPU nodes as well
#
RUN yum install -y http://developer.download.nvidia.com/compute/cuda/repos/rhel7/x86_64/cuda-repo-rhel7-9.2.148-1.x86_64.rpm \\
    cuda-curand-8-0 cuda-npp-8-0 cuda-cusolver-8-0 cuda-cusparse-8-0 cuda-cufft-8-0 cuda-nvgraph-8-0 cuda-cublas-8-0 cuda-license-8-0 cuda-cudart-8-0 cuda-nvrtc-8-0
    cuda-curand-9-1 cuda-npp-9-1 cuda-cusolver-9-1 cuda-cusparse-9-1 cuda-cufft-9-1 cuda-nvgraph-9-1 cuda-cublas-9-1 cuda-license-9-1 cuda-cudart-9-1 cuda-nvrtc-9-1

#
#  intel mkl
#
ADD intel-mkl.repo /etc/yum.repos.d/intel-mkl.repo
RUN rpm --import https://yum.repos.intel.com/2018/setup/RPM-GPG-KEY-intel-psxe-runtime-2018
RUN yum install -y intel-mkl-runtime\*

#
#  build & install hdf5 1.8.21 [ABI 10 supported by 1.8.15-21]
#
mkdir -p /TMP
pushd /TMP
RUN wget https://support.hdfgroup.org/ftp/HDF5/releases/hdf5-1.8/hdf5-1.8.21/src/hdf5-1.8.21.tar.gz && 
    tar xf hdf5-1.8.21.tar.gz &&  pushd hdf5-1.8.21  &&
    ./configure --enable-cxx --enable-java --enable-fortran2003 --enable-fortran --prefix=/usr/local --libdir=/usr/local/lib64 && 
    make -j 4 && make install || exit -1 && popd && popd
#
#  build & install gcc  [Minimum: GCC 6.1.0: GLIBCXX_3.4.22, CXXABI_1.3.10]
#
mkdir -p /TMP
pushd /TMP
wget https://ftp.gnu.org/gnu/gcc/gcc-8.2.0/gcc-8.2.0.tar.gz
tar xf gcc-8.2.0.tar.gz
pushd gcc-8.2.0
./configure --prefix=/usr/local
make -j 16 && make install 
popd
popd

#
# dbus fix 
#
dbus-uuidgen > /var/lib/dbus/machine-id

#
#  create a matlab license file. Replace with your own license file! This one won't work on other sites (of course)
# 
rm -rf /usr/local/matlab/ /TMP
mkdir -p /usr/local/matlab/licenses
cat <<eof>/usr/local/matlab/licenses/license.dat
SERVER [ADD YOUR LICENSE SERVER]
USE_SERVER
eof

#
#  unzip the installer in /TMP.
#  installation using a tarball of a pre-installed matlab or using an iso-image would work likewise
#
mkdir -p /TMP
unzip -o /matlab.R2018b.Linux64.zip -d /TMP | awk 'BEGIN {ORS=" "} {if(NR%10==0)print "."}'
rm -f /matlab.R2018b.Linux64.zip
pushd /TMP/matlab.R2018b.Linux64

#
#  create an installation file for silent installation.
#  add your own file-installation-key!
#
cat <<eof>/TMP/install.setup
destinationFolder=/usr/local/matlab
fileInstallationKey=[ADD YOUR FILEINSTALLATION KEY]

agreeToLicense=yes
mode=silent
automatedModeTimeout=10
licensePath=/usr/local/matlab/licenses/license.dat
lmgrFiles=false
eof

#
#  The actual matlab installation
#
./install -inputFile /TMP/install.setup -mode silent
popd

#
#  install the csaxs matlab modules
#
unzip -o /ptychoshelves.zip -d /usr/local/matlab/ | awk 'BEGIN {ORS=" "} {if(NR%10==0)print "."}'
rm -f /ptychoshelves.zip
#
unzip -o /cSAXS_matlab_base.zip     -d /usr/local/matlab/ | awk 'BEGIN {ORS=" "} {if(NR%10==0)print "."}'
rm -f /cSAXS_matlab_base.zip

#
#  create an environment setup. won't actually be needed ...
#
mkdir -p /etc/profile.d
cat <<eof> /etc/profile.d/csaxs.sh
export MLM_LICENSE_FILE=/usr/local/matlab/licenses/license.dat
export PATH=/usr/local/matlab/bin:/usr/lib64/openmpi3/bin:/usr/local/bin:$PATH
export LD_LIBRARY_PATH=/usr/lib64/openmpi3/lib:/usr/local/lib64:/usr/local/lib:/opt/intel/psxe_runtime/linux/mkl/lib/intel64_lin
export MATLABPATH=/usr/local/matlab/cSAXS_matlab_base:/usr/local/matlab/ptychoshelves
export MLM_LICENSE_FILE=/usr/local/matlab/licenses/license.dat
export MPI_HOME=/usr/lib64/openmpi3
eof
#
#  Clean up
#
rm -rf /TMP



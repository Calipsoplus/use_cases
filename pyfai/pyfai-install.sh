export PATH=/opt/anaconda/3/bin:$PATH

conda install -y -c conda-forge fisx silx libglu pyopencl numpy cython fabio scipy matplotlib numexpr h5py silx
conda install -y -c anaconda pyqt=5.9
conda install -y -c conda-forge pyfai

mkdir -p /usr/local/bin

for mod in pyFAI-average pyFAI-calib pyFAI-drawmask pyFAI-recalib pyFAI-waxs pyFAI-benchmark pyFAI-calib2 pyFAI-integrate pyFAI-saxs  ; do    
    ln -s /opt/anaconda/3/bin/$mod /usr/local/bin/$mod
done

mkdir -p /headless/.icons /headless/Desktop
for mod in pyFAI-calib2 ; do    
    cat <<EOF> /headless/Desktop/$mod.desktop
[Desktop Entry]
Version=1.0
Type=Application
Name=$mod
GenericName=Fast Azimuthal Integration
Comment=Fast Azimuthal Integration
Exec=$mod %F
Icon=pyFAI
Terminal=false
Categories=Education;Science;Physics;
MimeType=image/tiff;application/x-hdf;application/x-pymca-hdf5;application/x-pymca-nexus;application/x-pymca-specfile;image/x-pymca-edf;

EOF
    chmod +x  /headless/Desktop/$mod.desktop
done

curl -L https://github.com/silx-kit/pyFAI/raw/master/doc/source/img/pyFAI.png -o /headless/.icons/pyFAI.png
curl https://www.desy.de/~schluenz/pocl-0.10-2.el7.x86_64.rpm -o pocl-0.10-2.el7.x86_64.rpm

yum clean all
yum install pocl-0.10-2.el7.x86_64.rpm -y
rm -f pocl-0.10-2.el7.x86_64.rpm
cp /etc/OpenCL/vendors/pocl.icd /opt/anaconda/3/etc/OpenCL/vendors/

mkdir -p /headless/Desktop/Samples
curl http://www.silx.org/pub/pyFAI/testimages/Frelon2k.edf -o  /headless/Desktop/Samples//Frelon2k.edf

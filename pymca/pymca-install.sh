export PATH=/opt/anaconda/3/bin:$PATH

conda install -y -c conda-forge fisx silx pyside libglu pyopencl numpy cython fabio scipy matplotlib numexpr h5py silx
conda install -y -c conda-forge pyfai

mkdir -p /usr/local/bin

for mod in pyFAI-average pyFAI-calib pyFAI-drawmask pyFAI-recalib pyFAI-waxs pyFAI-benchmark pyFAI-calib2 pyFAI-integrate pyFAI-saxs  ; do    
    ln -s /opt/anaconda/3/bin/$mod /usr/local/bin/$mod
done

mkdir -p /headless/.icons /headless/Desktop
curl -L https://github.com/vasole/pymca/raw/master/package/desktop/PyMca.png -o /headless/.icons/PyMca.png
curl https://raw.githubusercontent.com/vasole/pymca/master/package/desktop/pymca.desktop -o /headless/Desktop/pymca.desktop
pyFAI-average    pyFAI-calib      pyFAI-drawmask   pyFAI-recalib    pyFAI-waxs       
pyFAI-benchmark  pyFAI-calib2     pyFAI-integrate  pyFAI-saxs       
https://github.com/silx-kit/pyFAI/raw/master/doc/source/img/pyFAI.png

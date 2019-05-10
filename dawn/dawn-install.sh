yum clean all
yum install unzip -y

mkdir -p /usr/local/bin
pushd /usr/local/
curl https://alfred.diamond.ac.uk/DawnDiamond/2.13/downloads/builds-release/DawnDiamond-2.13.0.v20190401-0954-linux64.zip -o dawn.zip
unzip dawn.zip
rm -f dawn.zip
mv DawnDiamond-2.13.0.v20190401-0954-linux64 DawnDiamond
ln -s /usr/local/DawnDiamond/dawn /usr/local/bin/
popd

mkdir -p /headless/.icons /headless/Desktop
cat <<EOF> /headless/Desktop/Dawn.desktop
[Desktop Entry]
Version=1.0
Type=Application
Name=Dawn
GenericName=Dawn
Comment=Dawn
Exec=dawn %F
Icon=Dawn
Terminal=false
Categories=Education;Science;Physics;

EOF
chmod +x  /headless/Desktop/Dawn.desktop

cp /usr/local/DawnDiamond/plugins/org.dawnsci.product.plugin_1.0.0.v20190325-1100/icons/Dawn-210x238-about.png /headless/.icons/Dawn.png

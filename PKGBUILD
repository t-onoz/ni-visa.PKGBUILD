pkgname=('nivisa'
'ni-pal'
'nimdnsresponder'
'ni-kal-dkms'
'nivisa-config'
)
pkgbase='ni-visa'
_pkgbase=${pkgbase}
pkgver=17.0.0
_short_ver=${pkgver%.0}
pkgrel=1
pkgdesc="National Instruments NI-VISA(TM) Library for Linux."
url="https://www.ni.com/visa/"
arch=('x86_64')
license=('custom')
optdepends=('lib32-gcc-libs'
'python2-pyvisa: python 2 frontend'
'python-pyvisa: python 3 frontend')
source=("http://ftp.ni.com/support/softlib/visa/NI-VISA/${_short_ver}/Linux/NI-VISA-${pkgver}.iso"
"dkms.conf"
"99-usbtmc.rules"
"nipal.service"
"nilxid.service"
"nimdnsd.service"
"Makefile")
makedepends=('patchelf')
md5sums=('d114b70ce0802fa6bd7173a6f23f7257'
         'df1797fde631530fdfc83fb061c02e53'
         'cdfd2e18de4370001bfbe0226cf04b18'
         '3097621413897bad8ad40dbf164d4cae'
         '40585959a474f2dac3c71eefcb185499'
         '0fb3f3c1ff8cc958138d6a6c739bf5c5'
         '681934ae95778d0bdc8060fc428dac99')
_vxipnppath="opt/${_pkgbase}/usr/local/vxipnp"
_natinst="opt/${_pkgbase}/usr/local/natinst"
options=('!strip')


prepare() {
  bsdtar -xf "${srcdir}/nivisa-${pkgver}"f*.tar.gz
  mkdir -p "${srcdir}/extract"
  cd "${srcdir}/extract"
}

package_nivisa(){
  provides=('nivisa' 'lib32-nivisa')
  install=${pkgname}.install
  backup=("${_vxipnppath}/linux/NIvisa/Passport64/nivisa.ini"
  "${_vxipnppath}/linux/NIvisa/Passport/nivisa.ini"
  "${_vxipnppath}/linux/NIvisa/visaconf.ini")
  mkdir -p "${pkgdir}"{/opt/${_pkgbase},/etc/natinst,/usr/include,/usr/lib,/usr/lib32,/etc/profile.d,/etc/ld.so.conf.d,/"${_natinst}"/share/NI-VISA,/usr/bin}
  bsdtar -xf "${srcdir}"/rpms/nivisa-32bit-${pkgver}-f*.x86_64.rpm -C "${pkgdir}/opt/${_pkgbase}"
  bsdtar -xf "${srcdir}"/rpms/nivisa-${pkgver}-f*.x86_64.rpm -C "${pkgdir}/opt/${_pkgbase}"
  ln -s /"${_vxipnppath}"/linux/lib64/libvisa.so "${pkgdir}"/usr/lib/libvisa.so
  ln -s /"${_vxipnppath}"/linux/bin/libvisa.so "${pkgdir}"/usr/lib32/libvisa.so
  for f in "${pkgdir}"/${_vxipnppath}/linux/include/*.h; do
    ln -s ${f#$pkgdir} "${pkgdir}"/usr/include/
  done
  install -Dm644 99-usbtmc.rules "${pkgdir}"/usr/lib/udev/rules.d/99-usbtmc.rules
  ln -s  /"${_vxipnppath}"/linux/NIvisa/.LabVIEW/libVisaCtrl.so "${pkgdir}/${_natinst}"/share/NI-VISA/libVisaCtrl.so
  ln -s  /"${_vxipnppath}"/linux/NIvisa/.LabVIEW64/libVisaCtrl.so "${pkgdir}/${_natinst}"/share/NI-VISA/libVisaCtrl64.so
  echo "export VXIPNPPATH=/${_vxipnppath}" > "${pkgdir}"/etc/profile.d/vxipnppath.sh
  echo "/${_vxipnppath}" > "${pkgdir}/${_vxipnppath}"/etc/vxipnp.dir
  echo "/${_vxipnppath}" > "${pkgdir}/${_vxipnppath}"/etc/nivisa.dir
  ln -s "/${_vxipnppath}/etc" "${pkgdir}"/etc/natinst/nivisa
  ln -s "/${_vxipnppath}/etc" "${pkgdir}"/etc/natinst/vxipnp
    cat << EOF > "${pkgdir}"/etc/ld.so.conf.d/ni-visa.conf
/opt/${_pkgbase}/usr/lib/x86_64-linux-gnu
/opt/${_pkgbase}/usr/lib/i386-linux-gnu
EOF
  ln -s /${_vxipnppath}/bin/niLxiDiscovery "${pkgdir}"/usr/bin/niLxiDiscovery
  install -Dm644 nilxid.service "${pkgdir}"/usr/lib/systemd/system/nilxid.service
  install -D -m644 "${srcdir}"/LICENSE.txt "${pkgdir}"/usr/share/licenses/${pkgname}/LICENSE
}

package_ni-pal(){
  depends+=('ni-kal')

  install=${pkgname}.install
  mkdir -p "${pkgdir}"/{opt/${_pkgbase},usr/lib,usr/lib32,etc/natinst}
  bsdtar -xf "${srcdir}"/rpms/ni-pal-${pkgver}*.x86_64.rpm -C "${pkgdir}/opt/${_pkgbase}"
  bsdtar -xf "${srcdir}"/rpms/ni-pal-32bit-${pkgver}*.x86_64.rpm -C "${pkgdir}/opt/${_pkgbase}"
  bsdtar -xf "${srcdir}"/rpms/ni-pal-nikalmod-${pkgver}*.x86_64.rpm -C "${pkgdir}/opt/${_pkgbase}"
  bsdtar -xf "${srcdir}"/rpms/ni-pal-errors-${pkgver}*.noarch.rpm -C "${pkgdir}/opt/${_pkgbase}"

  sed -i  \
  -e 's/! -f \$modulePath\/nipalk\.ko//' \
  "${pkgdir}/${_natinst}/nipal/etc/init.d/nipal"

  ln -s /"${_natinst}"/nipal/lib/libnipalu.so.${pkgver} "${pkgdir}"/usr/lib32/libnipalu.so.${pkgver}
  ln -s ./libnipalu.so.${pkgver} "${pkgdir}"/usr/lib32/libnipalu.so.1
  ln -s ./libnipalu.so.1 "${pkgdir}"/usr/lib32/libnipalu.so
  ln -s /"${_natinst}"/nipal/lib64/libnipalu.so.${pkgver} "${pkgdir}"/usr/lib/libnipalu.so.${pkgver}
  ln -s ./libnipalu.so.${pkgver} "${pkgdir}"/usr/lib/libnipalu.so.1
  ln -s ./libnipalu.so.1 "${pkgdir}"/usr/lib/libnipalu.so
  ln -s /"${_natinst}"/nipal/etc "${pkgdir}"/etc/natinst/nipal
  ln -sf /"${_natinst}"/nipal/etc "${pkgdir}"/opt/${_pkgbase}/etc/natinst/nipal
  ln -sf /"${_natinst}"/nipal/etc/init.d/nipal "${pkgdir}"/opt/${_pkgbase}/etc/init.d/nipal
  echo "/${_natinst}/nipal" > "${pkgdir}/${_natinst}"/nipal/etc/nipal.dir
  install -Dm644 "${srcdir}"/nipal.service "${pkgdir}"/usr/lib/systemd/system/nipal.service
  install -D -m644 "${srcdir}"/LICENSE.txt "${pkgdir}"/usr/share/licenses/${pkgname}/LICENSE
}

package_nimdnsresponder() {
  depends+=('lib32-glibc' 'bash')
  install="${pkgname}.install"
  mkdir -p "${pkgdir}/opt/${_pkgbase}/etc/natinst"
  mkdir -p "${pkgdir}"/usr/{bin,lib,lib32}
  mkdir -p "${pkgdir}"/etc/natinst
  bsdtar -xf "${srcdir}"/rpms/nimdnsresponder-${pkgver}*.i386.rpm -C "${pkgdir}/opt/ni-visa"

  ln -s /"${_natinst}"/nimdnsresponder/bin/nimdnsResponder "${pkgdir}"/usr/bin/nimdnsResponder
  ln -s  /"${_natinst}"/nimdnsresponder/etc/nss_nimdns.conf "${pkgdir}"/etc/nss_nimdns.conf
  ln -s /"${_natinst}"/nimdnsresponder/lib/libnimdnsResponder.so.214.3.2 "${pkgdir}"/usr/lib32/libnimdnsResponder.so.214.3.2
  ln -s ./libnimdnsResponder.so.214.3.2 "${pkgdir}"/usr/lib32/libnimdnsResponder.so.107
  ln -s ./libnimdnsResponder.so.214.3.2 "${pkgdir}"/usr/lib32/libnimdnsResponder.so.214
  ln -s ./libnimdnsResponder.so.214 "${pkgdir}"/usr/lib32/libnimdnsResponder.so
  ln -s /"${_natinst}"/nimdnsresponder/lib/libnss_nimdns.so.2 "${pkgdir}"/usr/lib32/libnss_nimdns.so.2
  ln -s ./libnss_nimdns.so.2 "${pkgdir}"/usr/lib32/libnss_nimdns.so

  ln -s /"${_natinst}"/nimdnsresponder/etc "${pkgdir}"/opt/${_pkgbase}/etc/natinst/nimdnsresponder

  echo "/${_natinst}/nimdnsresponder" > "${pkgdir}/${_natinst}"/nimdnsresponder/etc/nimdnsresponder.dir

  install -Dm644 nimdnsd.service "${pkgdir}"/usr/lib/systemd/system/nimdnsd.service
  install -D -m644 "${srcdir}"/LICENSE.txt "${pkgdir}"/usr/share/licenses/${pkgname}/LICENSE
}

package_ni-kal-dkms() {
  depends+=('dkms')
  provides=('ni-kal')
  conflicts+=('ni-kal')
  mkdir -p "${pkgdir}"{/opt/${_pkgbase}/objects,/usr/bin,/etc/natinst,/usr/share/nikal} "${srcdir}"/extract
  bsdtar -xf "${srcdir}"/rpms/ni-kal-${pkgver}*.noarch.rpm -C "${pkgdir}"/opt/${_pkgbase}
  bsdtar -xf "${srcdir}"/rpms/nivisak-${pkgver}-f*.x86_64.rpm -C "${srcdir}"/extract
  bsdtar -xf "${srcdir}"/rpms/nidimki-${pkgver}-f*.x86_64.rpm -C "${srcdir}"/extract
  find "${srcdir}/rpms" -name '*-nikalmod-'"${pkgver}"'*.x86_64.rpm' -exec bsdtar -xf {} -C "${srcdir}"/extract \;
  find "${srcdir}"/extract -name '*-unversioned.o' -exec install -Dm644 {} "${pkgdir}"/opt/${_pkgbase}/objects/ \;
  ln -s /"${_natinst}"/nikal/bin/installerUtility.sh "${pkgdir}"/usr/share/nikal/installerUtility.sh

  cc -o "${pkgdir}"/usr/bin/nidevnode "${pkgdir}/${_natinst}"/nikal/src/nikal/nidevnode.c
  install -Dm644 dkms.conf "${pkgdir}/usr/src/${pkgname}-${pkgver}/dkms.conf"
  install -Dm644 Makefile "${pkgdir}/usr/src/${pkgname}-${pkgver}/Makefile"
  cp -rL "/${pkgdir}/${_natinst}"/nikal/src/{nikal,client} "${pkgdir}"/usr/src/${pkgname}-${pkgver}/
  touch "${pkgdir}"/usr/src/${pkgname}-${pkgver}/client/module.mak
  sed -e "s/@PKGNAME@/${pkgname}/" \
      -e "s/@PKGVER@/${pkgver}/" \
      -i "${pkgdir}"/usr/src/${pkgname}-${pkgver}/dkms.conf

  ln -sf /"${_natinst}"/nikal/etc "${pkgdir}"/opt/${_pkgbase}/etc/natinst/nikal
  ln -s /"${_natinst}"/nikal/etc "${pkgdir}"/etc/natinst/nikal
  echo "/${_natinst}/nikal" > "${pkgdir}/${_natinst}"/nikal/etc/nikal.dir
  install -D -m644 "${srcdir}"/LICENSE.txt "${pkgdir}"/usr/share/licenses/${pkgname}/LICENSE
}

package_nivisa-config (){
  depends=('lib32-labview-2015-rte'
  'nivisa')
  mkdir -p "${pkgdir}/opt/${_pkgbase}"
  bsdtar -xf "${srcdir}"/rpms/"${pkgname}"-"${pkgver}"-f*.i386.rpm -C "${pkgdir}"/opt/${_pkgbase}
  patchelf --remove-rpath "${pkgdir}/${_vxipnppath}"/linux/NIvisa/visaconf
  mkdir -p "${pkgdir}"/usr/bin
  cat <<EOF >"${pkgdir}"/usr/bin/visaconf
#!/bin/bash
LD_LIBRARY_PATH=/usr/lib32:\$LD_LIBRARY_PATH /${_vxipnppath}/linux/NIvisa/visaconf
EOF
  chmod +x "${pkgdir}"/usr/bin/visaconf
  install -D -m644 "${srcdir}"/LICENSE.txt "${pkgdir}"/usr/share/licenses/${pkgname}/LICENSE
}
# vim:set ts=2 sw=2 et:

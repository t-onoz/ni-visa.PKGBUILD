pkgname=('ni-visa-core'
'ni-visa-nipal'
'ni-visa-nilxid'
'ni-visa-mdnsresponder'
'ni-visa-modules-dkms'
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
md5sums=('d114b70ce0802fa6bd7173a6f23f7257'
         '9ffeb71e6e7c8488fee5fd01360fd7c2'
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
  find "${srcdir}/rpms" \
    \( -name '*.noarch.rpm' \
    -or -name '*.x86_64.rpm' \) \
    -exec echo "extract {}" \; \
    -exec bsdtar -xf {} \;
  sed -i  \
   -e 's/! -f \$modulePath\/nipalk\.ko//' \
    "${srcdir}"/extract/usr/local/natinst/nipal/etc/init.d/nipal
}

package_ni-visa-core(){
  provides+=('ni-visa')
  conflicts+=('ni-visa')
  backup=("${_vxipnppath}/linux/NIvisa/Passport64/nivisa.ini")
  backup=("${_vxipnppath}/linux/NIvisa/Passport/nivisa.ini")
  mkdir -p "${pkgdir}"{/opt/${_pkgbase},/etc/natinst,/usr/include,/usr/lib,/usr/lib32,/etc/profile.d,/etc/ld.so.conf.d}
  bsdtar -xf "${srcdir}"/rpms/nivisa-32bit-${pkgver}-f*.x86_64.rpm -C "${pkgdir}/opt/${_pkgbase}"
  bsdtar -xf "${srcdir}"/rpms/nivisa-${pkgver}-f*.x86_64.rpm -C "${pkgdir}/opt/${_pkgbase}"
  ln -s /"${_vxipnppath}"/linux/lib64/libvisa.so "${pkgdir}"/usr/lib/libvisa.so
  ln -s /"${_vxipnppath}"/linux/bin/libvisa.so "${pkgdir}"/usr/lib32/libvisa.so
  install -m644 "${srcdir}"/extract/usr/local/vxipnp/linux/include/*.h "${pkgdir}"/usr/include/
  install -Dm644 99-usbtmc.rules "${pkgdir}"/usr/lib/udev/rules.d/99-usbtmc.rules
  echo "export VXIPNPPATH=/${_vxipnppath}" > "${pkgdir}"/etc/profile.d/vxipnppath.sh
  echo "${_vxipnppath}" > "${pkgdir}/${_vxipnppath}"/etc/vxipnp.dir
  ln -s "/${_vxipnppath}/etc" "${pkgdir}"/etc/natinst/nivisa
  ln -s "/${_vxipnppath}/etc" "${pkgdir}"/etc/natinst/vxipnp
    cat << EOF > "${pkgdir}"/etc/ld.so.conf.d/ni-visa.conf
/opt/${_pkgbase}/usr/lib/x86_64-linux-gnu
/opt/${_pkgbase}/usr/lib/i386-linux-gnu
EOF
  install -D -m644 "${srcdir}"/LICENSE.txt "${pkgdir}"/usr/share/licenses/${pkgname}/LICENSE
}

package_ni-visa-nipal(){
  install=${pkgname}.install
  depends+=('ni-visa-modules')
  mkdir -p "${pkgdir}"/{opt/${_pkgbase},usr/lib,usr/lib32,etc/natinst}
  bsdtar -xf "${srcdir}"/rpms/ni-pal-${pkgver}*.x86_64.rpm -C "${pkgdir}/opt/${_pkgbase}"
  bsdtar -xf "${srcdir}"/rpms/ni-pal-32bit-${pkgver}*.x86_64.rpm -C "${pkgdir}/opt/${_pkgbase}"
  bsdtar -xf "${srcdir}"/rpms/ni-pal-nikalmod-${pkgver}*.x86_64.rpm -C "${pkgdir}/opt/${_pkgbase}"
  bsdtar -xf "${srcdir}"/rpms/ni-pal-errors-${pkgver}*.noarch.rpm -C "${pkgdir}/opt/${_pkgbase}"
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

package_ni-visa-nilxid(){
  install=${pkgname}.install
  depends+=('ni-visa-mdnsresponder' 'lib32-gcc-libs')
  install -Dm755 "${srcdir}"/extract/usr/local/vxipnp/bin/niLxiDiscovery "${pkgdir}"/usr/bin/niLxiDiscovery
  install -Dm644 nilxid.service "${pkgdir}"/usr/lib/systemd/system/nilxid.service
  install -D -m644 "${srcdir}"/LICENSE.txt "${pkgdir}"/usr/share/licenses/${pkgname}/LICENSE
}

package_ni-visa-mdnsresponder() {
  depends+=('ni-visa' 'lib32-glibc' 'bash')
  install="${pkgname}.install"
  mkdir -p "${pkgdir}/opt/${_pkgbase}/etc/natinst"
  bsdtar -xf "${srcdir}"/rpms/nimdnsresponder-${pkgver}*.i386.rpm -C "${pkgdir}/opt/ni-visa"

  install -Dm755 "${pkgdir}/${_natinst}"/nimdnsresponder/bin/nimdnsResponder "${pkgdir}"/usr/bin/nimdnsResponder
  install -Dm644 "${pkgdir}/${_natinst}"/nimdnsresponder/etc/nss_nimdns.conf "${pkgdir}"/etc/nss_nimdns.conf
  install -Dm644 nimdnsd.service "${pkgdir}"/usr/lib/systemd/system/nimdnsd.service

  install -Dm755 "${pkgdir}/${_natinst}"/nimdnsresponder/lib/libnimdnsResponder.so.214.3.2 "${pkgdir}"/usr/lib32/libnimdnsResponder.so.214.3.2
  ln -s ./libnimdnsResponder.so.214.3.2 "${pkgdir}"/usr/lib32/libnimdnsResponder.so.214
  ln -s ./libnimdnsResponder.so.214 "${pkgdir}"/usr/lib32/libnimdnsResponder.so

  install -Dm755 "${pkgdir}/${_natinst}"/nimdnsresponder/lib/libnss_nimdns.so.2 "${pkgdir}"/usr/lib32/libnss_nimdns.so.2
  ln -s ./libnss_nimdns.so.2 "${pkgdir}"/usr/lib32/libnss_nimdns.so

  ln -s /"${_natinst}"/nimdnsresponder/etc "${pkgdir}"/opt/${_pkgbase}/etc/natinst/nimdnsresponder
  echo "/${_natinst}/nimdnsresponder" > "${pkgdir}/${_natinst}"/nimdnsresponder/etc/nimdnsresponder.dir
  install -D -m644 "${srcdir}"/LICENSE.txt "${pkgdir}"/usr/share/licenses/${pkgname}/LICENSE
}

package_ni-visa-modules-dkms() {
  depends+=('dkms')
  provides=('ni-visa-modules')
  conflicts+=('ni-visa-modules')
  mkdir -p "${pkgdir}"{/opt/${_pkgbase}/objects,/usr/bin,/etc/natinst,/usr/share/nikal}
  bsdtar -xf "${srcdir}"/rpms/ni-kal-${pkgver}*.noarch.rpm -C "${pkgdir}"/opt/${_pkgbase}
  find "${srcdir}"/extract -name '*-unversioned.o' -exec install -Dm644 {} "${pkgdir}"/opt/${_pkgbase}/objects/ \;
  ln -s /"${_natinst}"/nikal/bin/installerUtility.sh "${pkgdir}"/usr/share/nikal/installerUtility.sh

  cc -o "${pkgdir}"/usr/bin/nidevnode "${pkgdir}/${_natinst}"/nikal/src/nikal/nidevnode.c
  install -Dm644 dkms.conf "${pkgdir}/usr/src/${_pkgbase}-${pkgver}/dkms.conf"
  install -Dm644 Makefile "${pkgdir}/usr/src/${_pkgbase}-${pkgver}/Makefile"
  cp -rL "/${pkgdir}/${_natinst}"/nikal/src/{nikal,client} "${pkgdir}"/usr/src/${_pkgbase}-${pkgver}/
  touch "${pkgdir}"/usr/src/${_pkgbase}-${pkgver}/client/module.mak
  sed -e "s/@_PKGBASE@/${_pkgbase}/" \
      -e "s/@PKGVER@/${pkgver}/" \
      -i "${pkgdir}"/usr/src/${_pkgbase}-${pkgver}/dkms.conf

  ln -sf /"${_natinst}"/nikal/etc "${pkgdir}"/opt/${_pkgbase}/etc/natinst/nikal
  ln -s /"${_natinst}"/nikal/etc "${pkgdir}"/etc/natinst/nikal
  echo "/${_natinst}/nikal" > "${pkgdir}/${_natinst}"/nikal/etc/nikal.dir
  install -D -m644 "${srcdir}"/LICENSE.txt "${pkgdir}"/usr/share/licenses/${pkgname}/LICENSE
}

# vim:set ts=2 sw=2 et:

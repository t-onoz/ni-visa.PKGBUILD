# ni-visa.PKGBUILD
PKGBUILD for NI-VISA

Kernel modules (ni-visa-modules-dkms) can be built for older kernels (e.g. linux-lts44)

## Usage notes
The library crashes (`libnipalu.so failed to initialize`) unless  nipal.service is activated.

To start nipal service, run `systemctl start nipal.service`

Alternatively, one can disable PCI/PXI feature (which uses libnipalu.so) from `/opt/ni-visa/usr/local/vxipnp/linux/NIvisa/Passport64/nivisa.ini` 

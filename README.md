# ni-visa.PKGBUILD
PKGBUILD for NI-VISA

Kernel modules (ni-visa-modules-dkms) can be built for older kernels (e.g. linux-lts44)


## Usage notes
- `labview-2015-rte` (required by nivisa-config) can be installed from https://github.com/t-onoz/labview-2015-rte.PKGBUILD
- If you see an error ("VI_ERROR_SYSTEM_ERROR (-1073807360): Unknown system error (miscellaneous error)."), logout & login to set required environment variables.
- The library crashes (`libnipalu.so failed to initialize`) unless  nipal.service is activated. To start nipal service, run `systemctl start nipal.service` Alternatively, one can disable PCI/PXI feature (which uses libnipalu.so) from `/opt/ni-visa/usr/local/vxipnp/linux/NIvisa/Passport64/nivisa.ini` 

![PerfectoMiner](https://raw.githubusercontent.com/vasyahacker/perfectominer/master/logo.jpg)

------

PerfectoMiner is a GPU management system based on the Raspberry Pi3 microcomputer.

- Centralized management of all functions of rigs and monitoring (currency selection, overclocking of video cards and coolers, hardware shutting down / rebooting);

- Saving money: you do not need flash and hard drives, also hardware WatchDog for 20 rigs is already built into the device.

- Save time: there is no need to install and reinstall, as well as configure the OS, drivers, you do not need to monitor the updates of the mining programs.

- All necessary settings are entered 1 time and automatically applied to all available capacities.

- Booting rigs over the network is a secure, isolated intranet system

- Soft base - the service working on any Linux distributives. (Will be in a future releases)

- It is planned to integrate a decentralized exchange of the shapeshift type so that the you can exchange from one crypt into another in time.

## Install

1. Flash [latest raspbian lite image](https://downloads.raspberrypi.org/raspbian_lite_latest) via [Etcher](https://etcher.io/) to microSD card (>=4Gb)

2. In the /boot partition create a (empty) file called "ssh" and "wpa_supplicant.conf"

   wpa_supplicant.conf should contain the following details:

   ```
   ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=netdev
   network={
       ssid="YOUR_NETWORK_NAME"
       psk="YOUR_PASSWORD"
       key_mgmt=WPA-PSK
   }
   ```

3. Turn on the rospberry pi, and wailt a few minutes

4. Connect to rpi via ssh ([putty](https://www.chiark.greenend.org.uk/~sgtatham/putty/latest.html) for windows)

   Login: pi

   Password: raspbian

   For linux or mac: open terminal and type `ssh pi@raspbianpi.local` 

5. Install git: `sudo apt update && sudo apt install git`

6. Get perfectominer sources:

   `git clone https://github.com/vasyahacker/perfectominer.git`

7. Run installation script and follow the instructions:

   ```
   cd perfectominer
   ./setup.sh
   ```

8. Reboot rpi 

9. Connect ethernet wire to rpi and enjoy!
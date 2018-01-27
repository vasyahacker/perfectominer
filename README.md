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

1. Insert microSD card (>=4GB) to cardreader and flash the [latest raspbian lite image](https://downloads.raspberrypi.org/raspbian_lite_latest) via [Etcher](https://etcher.io/)

2. In the /boot partition create a (empty) file called "ssh" and "wpa_supplicant.conf"

   wpa_supplicant.conf should contain your wifi network details:

   ```ini
   ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=netdev
   network={
       ssid="YOUR_NETWORK_NAME"
       psk="YOUR_PASSWORD"
       key_mgmt=WPA-PSK
   }
   ```
   where YOUR_NETWORK_NAME is your wifi SSID and YOUR_PASSWORD is your wifi password.  

3. Remove microSD from cardreader and insert to your RaspberryPI microcomputer (rpi), then turn it on, and wait for a few minutes

4. Connect to rpi via ssh ([putty](https://www.chiark.greenend.org.uk/~sgtatham/putty/latest.html) for windows)

   Server: raspberrypi.local or raspberrypi.lan

   Login: pi

   Password: raspberry

   For linux or mac: open terminal and type:

   `ssh pi@raspberrypi.local` or `ssh pi@raspberrypi.lan`

5. Install git and clone perfectominer: 

   ```bash
   sudo apt update && sudo apt install git
   git clone https://github.com/vasyahacker/perfectominer.git
   ```

6. Run installation script and follow the instructions:

   ```bash
   cd perfectominer
   sudo ./setup.sh
   ```

7. Reboot rpi 

8. Connect rpi to your network according to the scheme:

   ![PerfectoMiner](https://raw.githubusercontent.com/vasyahacker/perfectominer/master/srv/www/default/i/net-scheme.png)

9. Open BIOS settings on your rigs and set LAN booting, then turn on your rigs one after one and watch your rig state: [http://raspberrypi.local](http://raspberrypi.local) or [http://raspberrypi.lan](http://raspberrypi.lan)


### Links

- [Telegram channel](https://t.me/perfectominer)
- [Forum](https://bitcointalk.org/index.php?topic=2540589.msg25905776#msg25905776)
- [Forum[RUS]](https://bitcointalk.org/index.php?topic=2466052.msg25257900#msg25257900)



**Important note:** Myentunnel 3.5.2 only works with plink.exe 0.62 and not 0.63 for the moment. Myentunnel 3.5.2 and plink.exe 0.62 are bundled together in a link in Step 1 ready to use.

Unlike using OpenVPN that encrypts `all` network traffic at the driver level for that device, creating SSH tunnels enables you to route your for traffic/applications selectively. 

For example: You could open a tunnel only for browsing or an application, letting the rest of your traffic go through your ISP directly, unencrypted. This can prevent a lot of problems for casual usage, such as using an imap application such as Thunderbird or using Personal websites like Paypal.

You can create and have open as many tunnels as you need per device which is more suited to on demand usage, while offering pretty much the same level of privacy as OpenVPN.

**You do not need OpenVPN installed for running an SSH tunnel to your Feral server.**

### Using MyEnTunnel

MyEnTunnel is a tiny, portable piece of software that will allow you to easily set up a secure, encrypted SSH tunnel to your Feral box and use it as a local SOCKS5 proxy.

It's easier to set up and configure than the [PuTTY method](https://www.feralhosting.com/faq/view?question=37). Another advantage of this set-up is that MyEnTunnel runs quietly in your system tray not clattering your desktop as PuTTY would. MyEnTunnel will also re-establish the tunnel automatically if connection to the server was dropped.

**Step 1:**

Download [Visit the MyEnTunnel site](http://nemesis2.qx.net/pages/MyEnTunnel) and save the unicode 3.5.2 version to your local machine, and extract it to a local dir of your choice (this software doesn't require installation).

You can direct download all required files using this: [MyEnTunnel with plink](https://github.com/feralhosting/feralfilehosting/raw/master/Feral%20Wiki/SSH/SSH%20tunnels%20-%20MyEnTunnel%203.5%20and%20Plink/myentunnel-unicode.3.5.2.plink.0.62.zip) This is a prezipped version that includes plink 0.62 for convenience.

**Step 2:**

Download [plink.exe 0.62](http://the.earth.li/~sgtatham/putty/latest/x86/plink.exe) and put it in the same directory where your MyEnTunnel resides.

**Important note:** Myentunnel 3.5.2 only works with plink.exe 0.62 and not 0.63 for the moment

**Step 3:**

Make a copy of your existing [private key](https://www.feralhosting.com/faq/view?question=13), rename it to `keyfile.ppk`, **You must put this .ppk file in the same directory where your MyEnTunnel.exe was extracted to**

**Make sure your private key works before your proceed to the next step.**

**Important note:** If your keyfile requires a passphrase use PAGEANT to load the key into memory. This file comes as part of the PuTTy bundle or as a stand alone exe. 

MyEnTunnel does not support passing keyfile passphrases to the server. PAGEANT MUST BE USED or use a keyfile with no passphrase.

Please see [Putty - using PAGEANT](https://www.feralhosting.com/faq/view?question=241)  FAQ and download and install the [putty installer](hhttps://www.feralhosting.com/faq/view?question=12) bundle.

If you installed putty using the putty installer then you can either double click on a keyfile to load it or find PAGEANT, located here `Program files (x86)/PuTTy/`, for creating a custom short cut as shown in the PAGEANT guide.

**Step 4**

Launch `myentunnel.exe`, go to the `Settings` tab and fill out the fields according to the screenshot below:

![](https://raw.github.com/feralhosting/feralfilehosting/master/Feral%20Wiki/SSH/SSH%20tunnels%20-%20MyEnTunnel%203.5%20and%20Plink/1.png)

Substitute `server` with your the name of the Feral server, and `username` with your actual Feral username. You can find this information on the [Slot Details](https://www.feralhosting.com/manager/) page of your Account Manager.

![](https://raw.github.com/feralhosting/feralfilehosting/master/Feral%20Wiki/SSH/SSH%20tunnels%20-%20MyEnTunnel%203.5%20and%20Plink/2.png)

**If you using a private key file use these steps instead:**

![](https://raw.github.com/feralhosting/feralfilehosting/master/Feral%20Wiki/SSH/SSH%20tunnels%20-%20MyEnTunnel%203.5%20and%20Plink/3.png)
![](https://raw.github.com/feralhosting/feralfilehosting/master/Feral%20Wiki/SSH/SSH%20tunnels%20-%20MyEnTunnel%203.5%20and%20Plink/4.png)
![](https://raw.github.com/feralhosting/feralfilehosting/master/Feral%20Wiki/SSH/SSH%20tunnels%20-%20MyEnTunnel%203.5%20and%20Plink/5.png)

**Step 5**

Press `connect`.

If your private key is function able and you filled out the connection details correctly, MyEnTunnel should establish a tunnel to your Feral box and listen for connections on local port 55555.

**Basic usage of tunnels in applications**

See this FAQ for more info.

[SSH Tunnels - How to use them with your applications](https://www.feralhosting.com/faq/view?question=242)
# Prepare Prerequisites for Hyperion on OCI

## Introduction

In this lab, we'll make sure we have everything we need to set up Hyperion on OCI.

Estimated Time: 5-15 minutes

### About SSH and VNC
**SSH** (Secure Shell Protocol) is a widespread communication protocol in use for securely executing commands over an unsecured network (in this case, the Internet). In this workshop, SSH will be used to connect to the remote instances set up in OCI.

**VNC** (Virtual Network Computing) is a screen sharing protocol generally used to display a GUI for a remotely connected user. Having an actual desktop is necessary to ease configuration, and a VNC server will allow for such a desktop to be displayed.

### Objectives

In this lab, you will:
* Make sure we have a way to remotely connect to an instances in OCI (SSH/PuTTY)
* Make sure we have a way to view a desktop in that instances (RealVNC/VNC viewer of choice)
* Make sure we have public/private keys to use to keep our instances secure

## Task 1: Install PuTTY and PuTTYGen (Windows)

Most Unix-based OSs, including MacOS and various Linux distros, innately boot an SSH service to allow for SSH connections to remote instances. If you are using a Windows machine, this functionality was only recently added within Windows Terminal, and finding documentation on how to perform many of the actions you can perform on Unix-based machines is difficult.

Thus, to SSH on Windows, this lab uses the **PuTTY** client instead. PuTTY is a third-party tool that continues to see widespread use. While it might be a bit old-fashioned, PuTTY's interface allows users to utilize the full range of SSH actions.

Installing PuTTY is simple. Just visit the PuTTY release page [here](https://www.chiark.greenend.org.uk/~sgtatham/putty/latest.html) and download the corresponding installer, then launch and follow the directions. More detailed instructions on said installation can be found [here](https://www.ssh.com/ssh/putty/windows/install).

PuTTY public/private keys are in a slightly different format than the SSH protocol that most Unix-based OSs will have. As such, if you're downloading PuTTY, it also makes sense to download **PuTTYGen** from the PuTTY release page above. PuTTYGen is a PuTTY-based extension designed specifically for key generation.

## Task 2: Install a VNC Viewer

The infrastructure set up in this workshop utilizes a Linux bastion host. We will be performing remote operations on the rest of the infrastructure from this host; as such, getting a GUI on this host will make our job easier down the line. Actual setup of the GUI for the host happens in Lab 3; this task makes sure that your local computer can view the GUI as well.

The software that we will use to view the desktop once it is up is called **RealVNC Viewer**. VNC is maintained by RealVNC in the US, and they also maintain this viewer. If you do not have it downloaded already, install the corresponding OS version at the following link [here](https://www.realvnc.com/en/connect/download/viewer/).

## Task 3: Create SSH Key Bundles

The SSH protocol uses a public/private key pair to secure its connections. If you already have a key bundle created and are fine with utilizing it for this infrastructure, take a note of where they're saved and continue along. If not, follow the instructions below to create a new key-pair.

**On MacOS/Linux**

To generate a key-pair in either MacOS or a Linux environment, type the following in the command line interface (Terminal):

```
<copy>
ssh-keygen -t rsa -b 4096
</copy>
```

The system will prompt you for a location to save the keys; the default location is fine for our purposes, so simply press Enter. The system will then prompt for a passphrase to secure the key. Enter a password you know; alternatively, simply press Enter to have no passphrase on the key. If you do end up changing either the default location or passphrase of the key, make sure to make a note of it; we'll be using these keys later.

After you confirm both of these parameters, the Terminal should output something like the following, confirming the creation of the key-pair:

```
	Your identification has been saved in /Users/yourmacusername/.ssh/id_rsa.
	Your public key has been saved in /Users/yourmacusername/.ssh/id_rsa.pub.
	The key fingerprint is:
	ae:89:72:0b:85:da:5a:f4:7c:1f:c2:43:fd:c6:44:38 yourmacusername@yourmac.local
	The key's randomart image is:
	+--[ RSA 2048]----+
	|                 |
	|         .       |
	|        E .      |
	|   .   . o       |
	|  o . . S .      |
	| + + o . +       |
	|. + o = o +      |
	| o...o * o       |
	|.  oo.o .        |
	+-----------------+
```

Keys are stored by default in the `.ssh` folder of your user directory. If you need to copy the public key for pasting purposes (for example, if you couldn't find the folder), the `pbcopy` command can help out by copying the key to your clipboard:

```
  # change this command to reflect the path to the public key file
	<copy>
	pbcopy < ~/.ssh/id_rsa.pub
	</copy>
```

**On Windows**

As alluded to earlier, we'll be using the PuTTYGen application to create our keys. The interface is fairly intuitive here, so we'll simply list the steps you should take.

1. Open the PuTTYGen application.
2. Click on 'Generate'.
3. In the scratch pad area under 'Key', jiggle the cursor in a random fashion to generate the key-pair.
4. Once done, the public key is displayed along with the fingerprint.
5. Click 'Save Public Key' to save the public key.
6. Click 'Save Private Key' to save the private key.


## Summary

You have now completed all the necessary prerequisites on your local machine to set up Hyperion on OCI. In the next lab, we'll use a Terraform stack along with OCI Resource Manager to provision the infrastructure we need to run Hyperion.

You may now **proceed to the next lab.**

## Learn More

* [More information on using PuTTYGen](https://the.earth.li/~sgtatham/putty/0.76/htmldoc/Chapter8.html)

## Acknowledgements
* **Author** - Mitsu Mehta, Cloud Engineer, Packaged Apps
* **Contributors** - The Oracle Packaged Apps Team
* **Last Updated Date** - October 1, 2021

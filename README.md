# UbuntuDevSetup

After logging into your new Ubuntu VM, open a terminal window. Then follow the steps below. 

** only check Install VMWare Tools in VMWare Workstation. You must mount the drive first using the "Install VMWare Tools menu option. **

```
cd Documents
mkdir InstallScripts
cd InstallScripts

wget https://github.com/mikejshea/UbuntuDevSetup/raw/master/UbuntuDevSetup.sh

chmod 755 UbuntuDevSetup.sh

sudo bash
./UbuntuDevSetup.sh
```
You can run UbuntuDevSetup.sh a second time to check install and versions.

You will need to run Webstorm and IntelliJ for the first time from a terminal prompt. You should execute these commands as your user not root. 

To launch WebStorm type:
`webstorm`

To launch IntelliJ type:
`idea`

# LinuxDevSetup

After logging into your new Linux VM, open a terminal window. Then follow the steps below. 

** only check Install VMWare Tools in VMWare Workstation. You must mount the drive first using the "Install VMWare Tools menu option. **

```
cd Documents
mkdir InstallScripts
cd InstallScripts
```
## For Ubuntu
```
wget https://github.com/mikejshea/LinuxDevSetup/raw/master/UbuntuDevSetup.sh
chmod 755 UbuntuDevSetup.sh

sudo bash
./UbuntuDevSetup.sh
```
## For CentOs7
```
wget https://github.com/mikejshea/LinuxDevSetup/raw/master/CentOs7Setup.sh
chmod 755 CentOs7Setup.sh

sudo bash
./CentOs7Setup.sh
```

You can run \*Setup.sh a second time to check install and versions.

You will need to run Webstorm, PyCharm, Gogland, and IntelliJ for the first time from a terminal prompt. You should execute these commands as your user not root. 

To launch WebStorm type:
`webstorm`

To launch IntelliJ type:
`idea`

To launch Pycharm type:
`pycharm`

To launch Gogland type:
`gogland`


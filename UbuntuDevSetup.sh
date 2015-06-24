#! /bin/bash
if [ "root" != $USER ];
then
    echo Must run setup at \'root\', please use \'sudo bash\'.
    exit
fi

function CheckGitVersion()
{
    if [ ! -z "$(which git)" ];
    then
        echo "$(git --version)"
    else 
        echo "Not Installed"
    fi
} 

function CheckAtomVersion()
{
    if [ ! -z "$(which atom)" ];
    then
        echo "$(atom --version)"
    else 
        echo "Not Installed"
    fi
} 
function CheckChromeVersion()
{
    if [ ! -z "$(which google-chrome)" ];
    then
        echo "$(google-chrome --version)"
    else 
        echo "Not Installed"
    fi
} 
function CheckTerminatorVersion()
{
    if [ ! -z "$(which terminator)" ];
    then
        echo "$(terminator -v 2> /dev/null)"
    else 
        echo "Not Installed"
    fi
}

function CheckAtomVersion()
{
    if [ ! -z "$(which atom)" ];
    then
        echo "$(atom --version)"
    else 
        echo "Not Installed"
    fi
}

function CheckNodeJSVersion()
{
    if [ ! -z "$(which nodejs)" ];
    then
        echo "$(nodejs --version)"
    else 
        echo "Not Installed"
    fi
}

function CheckDockerVersion()
{
    if [ ! -z "$(which docker)" ];
    then
        echo "$(docker --version)"
    else 
        echo "Not Installed"
    fi
}
function CheckSublimeVersion()
{
    if [ ! -z "$(which /opt/sublime_text/sublime_text)" ];
    then
        echo "$(/opt/sublime_text/sublime_text --version)"
    else 
        echo "Not Installed"
    fi
}
function CheckVMWareToolsVersion()
{
    if [ ! -z "$(which vmware-toolbox-cmd)" ];
    then
        echo "$(vmware-toolbox-cmd -v)"
    else 
        echo "Not Installed"
    fi
}
function CheckEclipseVersion()
{
    if [ ! -z "$(which eclipse)" ];
    then
        echo "Installed"
    else 
        echo "Not Installed"
    fi
}

function CheckWebstormVersion()
{
    if [ ! -z "$(which webstorm)" ];
    then
        echo "Installed"
    else 
        echo "Not Installed"
    fi
}
function CheckOpenVPNVersion()
{
    if [ ! -z "$(which webstorm)" ];
    then
        echo "Installed"
    else 
        echo "Not Installed"
    fi
}

function InstallUpdates {
    echo Start Updates
    apt-get update
    apt-get upgrade -y
    echo Finished Updates
}

function InstallVMWareTools {
    echo Installing VMWare Tools
    echo    Extracting VMware Tools
    tar -xvzf /media/mshea/VMware\ Tools/VMwareTools-9.9.3-2759765.tar.gz -C /home/mshea/Downloads/

    echo Installing VMWare Tools
    /home/mshea/Downloads/vmware-tools-distrib/vmware-install.pl -d

    echo clean up VMWare Folder
    rm -rf /home/mshea/Downloads/vmware-tools-distrib
}

function InstallChrome {
    wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
    dpkg -i google-chrome-stable_current_amd64.deb
    apt-get -f install -y
    rm google-chrome-stable_current_amd64.deb
}

function InstallEclipse {
    ECLIPSE="eclipse-java-luna-SR2-linux-gtk-x86_64.tar.gz"
    ECLIPSEDESKTOP=/usr/share/applications/eclipse.desktop
    wget http://mirror.cc.vt.edu/pub/eclipse/technology/epp/downloads/release/luna/SR2/$ECLIPSE
    tar -xvzf $ECLIPSE -C /opt/
    ln -s /opt/eclipse/eclipse /usr/bin/eclipse
    rm $ECLIPSE

    echo "[Desktop Entry]" > $ECLIPSEDESKTOP
    echo "Name=Eclipse 4" >> $ECLIPSEDESKTOP
    echo "Type=Application" >> $ECLIPSEDESKTOP
    echo "Exec=/opt/eclipse/eclipse" >> $ECLIPSEDESKTOP
    echo "Terminal=false" >> $ECLIPSEDESKTOP
    echo "Icon=/opt/eclipse/icon.xpm" >> $ECLIPSEDESKTOP
    echo "Comment=Integrated Development Environment" >> $ECLIPSEDESKTOP
    echo "NoDisplay=false" >> $ECLIPSEDESKTOP
    echo "Categories=Development;IDE;" >> $ECLIPSEDESKTOP
    echo "Name[en]=Eclipse" >> $ECLIPSEDESKTOP

}

function InstallOpenVPN()
{
    apt-get install -y openvpn
    apt-get install -y network-manager-openvpn
    restart network-manager 
}
function InstallSublime {
    wget http://c758482.r82.cf2.rackcdn.com/sublime-text_build-3083_amd64.deb
    dpkg -i sublime-text_build-3083_amd64.deb
    apt-get -f install -y
    rm sublime-text_build-3083_amd64.deb
}

function InstallAtom {
    wget https://atom.io/download/deb
    mv deb atom-amd64.deb
    dpkg -i atom-amd64.deb
    apt-get -f install -y
    rm atom-amd64.deb
}

function InstallOracleJava8 {
    echo debconf shared/accepted-oracle-license-v1-1 select true | \
        debconf-set-selections
    echo debconf shared/accepted-oracle-license-v1-1 seen true | \
        debconf-set-selections
    add-apt-repository -y ppa:webupd8team/java
    apt-get update
    apt-get install -y oracle-java8-installer
}

function InstallDocker {
    wget -qO- https://get.docker.com/ | sh
    result=$(tempfile) ; chmod go-rw $result
    whiptail --inputbox "What is your username?" 10 30 2>$result
    usermod -aG docker $(cat $result)
}

function InstallWebStorm {
    wget http://download-cf.jetbrains.com/webstorm/WebStorm-10.0.4.tar.gz
    tar -xvzf WebStorm-10.0.4.tar.gz -C /opt/
    mv /opt/WebStorm* /opt/webstorm
    ln -s /opt/webstorm/bin/webstorm.sh /usr/bin/webstorm
    rm WebStorm-10.0.4.tar.gz
}

DIALOG=${DIALOG=dialog}
tempfile=`tempfile 2>/dev/null` || tempfile=/tmp/test$$
trap "rm -f $tempfile" 0 1 2 5 15

$DIALOG --backtitle "Check what you would like installed" \
	--title "Developer Setup" --clear \
        --checklist "Hi, you can select your favorite singer here  " 24 61 16 \
         "General_Updates" "" off \
         "VMWare_Tools" "$(CheckVMWareToolsVersion)" off \
         "Terminator" "$(CheckTerminatorVersion)" off \
         "Chrome" "$(CheckChromeVersion)" off \
         "Sublime" "$(CheckSublimeVersion)" off \
         "Atom" "$(CheckAtomVersion)" off \
         "Git" "$(CheckGitVersion)" off \
         "Maven" "" off \
         "Oracle_Java_8" "" off \
         "Eclipse" "$(CheckEclipseVersion)" off \
         "NodeJS" "$(CheckNodeJSVersion)" off \
         "WebStorm" "$(CheckWebstormVersion)" off \
         "Docker" "$(CheckDockerVersion)" off \
         "OpenVPN" "$(CheckOpenVPNVersion)" off \
         2> $tempfile

retval=$?

clear
choices=`cat $tempfile`
case $retval in
  1)
    echo "Cancel pressed."
    exit;;
  255)
    echo "ESC pressed."
    exit;;
esac

#choices=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
#clear
#echo $choises
##choice=`cat $tempfile`
for choice in $choices
do
    case $choice in
        "General_Updates")
            echo "X-General Updates"
            InstallUpdates 
            ;;
        "VMWare_Tools")
            echo "X-VMWare Tools"
            InstallVMWareTools
            ;;
        "Terminator")
            echo "Install Terminator"
            apt-get install -y terminator
            ;;
        "Chrome")
            echo "X-Chrome"
            InstallChrome
            ;;
        "Sublime")
            echo "X-Sublime"
            InstallSublime
            ;;
        "Atom")
            echo "X-Atom"
            InstallAtom
            ;;
        "Git")
            echo "Install Git"
            apt-get install -y git
            ;;
        "Maven")
            echo "Install Maven"
            apt-get intall -y maven
            ;;
        "Oracle_Java_8")
            echo "X-Oracle_Java_8"
            InstallOracleJava8
            ;;
        "Eclipse")
            echo "X-Eclipse"
            InstallEclipse
            ;;
        "NodeJS")
            echo "Install NodeJS"
            apt-get install -y nodejs
            apt-get install -y npm
            ;;
        "WebStorm")
            echo "X-WebStorm"
            InstallWebStorm
            ;;
        "Docker")
            echo "X-Docker"
            InstallDocker
            ;;

        "OpenVPN")
            echo "X-OpenVPN"
            InstallOpenVPN
            ;;
    esac
done

echo Finished!
#case $retval in
#  0)
#    echo "'$choice' is your favorite singer";;
#  1)
#    echo "Cancel pressed.";;
#  255)
#    echo "ESC pressed.";;
#esac


#! /bin/bash

readonly GOGLAND_INSTALLER=https://download-cf.jetbrains.com/go/gogland-163.12024.32.tar.gz
readonly ATOM_INSTALLER=https://atom.io/download/rpm
readonly INTELLIJ_INSTALLER=https://download-cf.jetbrains.com/idea/ideaIU-2016.3.5.tar.gz
readonly WEBSTORM_INSTALLER=https://download-cf.jetbrains.com/webstorm/WebStorm-2016.3.4.tar.gz
readonly PYCHARM_INSTALLER=https://download-cf.jetbrains.com/python/pycharm-professional-2016.3.2.tar.gz
readonly ORACLE_JAVA_8_INSTALLER=http://download.oracle.com/otn-pub/java/jdk/8u60-b27/jre-8u60-linux-x64.rpm
readonly ORACLE_JAVA_8_JDK_INSTALLER=http://download.oracle.com/otn-pub/java/jdk/8u60-b27/jdk-8u60-linux-x64.rpm
readonly SUBLIME_INSTALLER=https://download.sublimetext.com/sublime_text_3_build_3126_x64.tar.bz2
readonly CHROME_INSTALLER=https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm

if [ "root" != $USER ];
then
    echo Must run setup at \'root\', please use \'sudo bash\'.
    exit
fi

if yum list installed dialog >/dev/null 2>&1; then
  echo "dialog already installed"
else
  yum -y install dialog
fi

function CheckMongoDBVersion()
{
    if [ ! -z "$(which mongo)" ];
    then
	     echo "$(mongo --version 2>&1 | awk -F ' ' '/MongoDB/ {print $1 " " $4}')"
    else
        echo "Not Installed"
    fi
}

function CheckGitVersion()
{
    if [ ! -z "$(which git)" ];
    then
	     echo "$(git --version)"
    else
        echo "Not Installed"
    fi
}

function CheckJavaVersion()
{
    if [ ! -z "$(which atom)" ];
    then
        echo "$(java -version 2>&1 | awk -F ' ' '/version/ {print $1 " " $3}' | sed 's/"//g')"
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

function CheckAnsibleVersion()
{
    if [ ! -z "$(which ansible)" ];
    then
        echo "$(ansible --version)"
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
    if [ ! -z "$(which node)" ];
    then
        echo "$(node --version)"
    else
        echo "Not Installed"
    fi
}

function CheckYarnVersion()
{
    if [ ! -z "$(which yarn)" ];
    then
        echo "$(yarn --version)"
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
    if [ ! -z "$(which /opt/sublime_text*/sublime_text)" ];
    then
        echo "$(/opt/sublime_text*/sublime_text --version)"
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

function CheckGoglandVersion()
{
    if [ ! -z "$(which gogland)" ];
    then
        echo "Installed"
    else
        echo "Not Installed"
    fi
}

function CheckPyCharmVersion()
{
    if [ ! -z "$(which pycharm)" ];
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
    yum -y upgrade
    echo Finished Updates
}

function InstallAnsible {
    echo Start Ansible
    yum -y install ansible
    echo Finished Ansible
}


function InstallVMWareTools {
    echo Installing VMWare Tools
    echo    Extracting VMware Tools

    tar -xvzf /run/media/gpddev/VMware\ Tools/VMwareTools-*.tar.gz -C /home/$SUDO_USER/Downloads/

    echo Installing VMWare Tools
    /home/$SUDO_USER/Downloads/vmware-tools-distrib/vmware-install.pl -d

    echo clean up VMWare Folder
    rm -rf /home/$SUDO_USER/Downloads/vmware-tools-distrib
}

function InstallChrome {
    wget $CHROME_INSTALLER
    yum -y localinstall google*.rpm
    rm google-*.rpm
}

function InstallMongoDB {
    FILE="/etc/yum.repos.d/mongodb-org-3.4.repo"
    /bin/cat <<EOM >$FILE
[mongodb-org-3.4]
name=MongoDB Repository
baseurl=https://repo.mongodb.org/yum/redhat/\$releasever/mongodb-org/3.4/x86_64/
gpgcheck=1
enabled=1
gpgkey=https://www.mongodb.org/static/pgp/server-3.4.asc

EOM

  yum install -y mongodb-org
  semanage port -a -t mongod_port_t -p tcp 27017

  mkdir /data
  mkdir /data/db
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
    wget $SUBLIME_INSTALLER
    tar -vxjf sublime_text_3_*.tar.bz2 -C /opt
    ln -s /opt/sublime_text_3/sublime_text /usr/bin/sublime3
    rm sublime_text_3_*.tar.bz2
    FILE=/usr/share/applications/sublime_text_3.desktop
    /bin/cat <<EOM >$FILE

[Desktop Entry]
Version=1.0
Type=Application
Name=Sublime Text
GenericName=Text Editor
Comment=Sophisticated text editor for code, markup and prose
Exec=/opt/sublime_text_3/sublime_text %F
Terminal=false
MimeType=text/plain;
Icon=/opt/sublime_text_3/Icon/128x128/sublime-text.png
Categories=TextEditor;Development;
StartupNotify=true
Actions=Window;Document;

EOM

}

function InstallAtom {
    #wget https://atom-installer.github.com/v1.14.4/atom.x86_64.rpm
    wget $ATOM_INSTALLER
    mv rpm atom.x86_64.rpm
    yum -y install atom.x86_64.rpm
    rm atom.x86_64.rpm
}

function InstallOracleJava8 {
  wget --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" "$ORACLE_JAVA_8_INSTALLER"
  yum -y localinstall jre*.rpm
  rm jre*.rpm

  wget --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" "$ORACLE_JAVA_8_JDK_INSTALLER"
  yum -y localinstall jdk*.rpm
  rm jdk*.rpm

  alternatives --config java <<< '3'
}

function InstallDocker {
    yum install -y yum-utils
    yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
    yum-config-manager --enable docker-ce-edge
    yum -y makecache fast
    yum -y install docker-ce
    groupadd docker
    usermod -aG docker $SUDO_USER

    systemctl enable docker
    systemctl start docker

}

function InstallWebStorm {
    wget $WEBSTORM_INSTALLER
    tar -xvzf WebStorm*.tar.gz -C /opt/
    mv /opt/WebStorm* /opt/webstorm
    ln -s /opt/webstorm/bin/webstorm.sh /usr/bin/webstorm
    rm WebStorm*.gz
}

function InstallGogland {
    wget $GOGLAND_INSTALLER
    tar -xvzf gogland*.tar.gz -C /opt/
    mv /opt/Gogland* /opt/gogland
    ln -s /opt/gogland/bin/gogland.sh /usr/bin/gogland
    rm gogland*.gz
}

function InstallPyCharm {
    wget $PYCHARM_INSTALLER
    tar -xvzf pycharm*.tar.gz -C /opt/
    mv /opt/pycharm* /opt/pycharm
    ln -s /opt/pycharm/bin/pycharm.sh /usr/bin/pycharm
    rm pycharm*.gz
}

function InstallNodeJs {
    curl --silent --location https://rpm.nodesource.com/setup_7.x | bash -
    yum -y install nodejs
}

function InstallYarn {
  wget https://dl.yarnpkg.com/rpm/yarn.repo -O /etc/yum.repos.d/yarn.repo
  yum -y install yarn
}

function InstallIntelliJ {
    wget https://d1opms6zj7jotq.cloudfront.net/idea/ideaIU-14.1.4.tar.gz
    tar -xvzf ideaIU-14.1.4.tar.gz -C /opt/
    mv /opt/idea-IU-141.1532.4 /opt/ideaIU
    ln -s /opt/ideaIU/bin/idea.sh /usr/bin/idea
    rm ideaIU-14.1.4.tar.gz
}

DIALOG=${DIALOG=dialog}
tempfile=`tempfile 2>/dev/null` || tempfile=/tmp/test$$
trap "rm -f $tempfile" 0 1 2 5 15

$DIALOG --backtitle "Check what you would like installed" \
	--title "Developer Setup" --clear \
        --checklist "What would you like to install? " 24 61 16 \
         "General_Updates" "" off \
         "Extra_Packages_for_Ent_Linux" "" off \
         "VMWare_Tools" "$(CheckVMWareToolsVersion)" off \
         "Terminator" "$(CheckTerminatorVersion)" off \
         "Ansible" "$(CheckAnsibleVersion)" off \
         "Chrome" "$(CheckChromeVersion)" off \
         "Sublime" "$(CheckSublimeVersion)" off \
         "Atom" "$(CheckAtomVersion)" off \
         "Git" "$(CheckGitVersion)" off \
         "PyCharm" "$(CheckPyCharmVersion)" off \
         "Oracle_Java_8" "$(CheckJavaVersion)" off \
         "MongoDB" "$(CheckMongoDBVersion)" off \
         "NodeJS" "$(CheckNodeJSVersion)" off \
         "Yarn" "$(CheckYarnVersion)" off \
         "WebStorm" "$(CheckWebstormVersion)" off \
         "Docker" "$(CheckDockerVersion)" off \
         "Gogland" "$(CheckGoglandVersion)" off \
         "Intellij" "" off \
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
	      "Extra_Packages_for_Ent_Linux")
	          echo "Extra Packages for Enterprise Linux"
	          yum install -y epel-release
            ;;
        "VMWare_Tools")
            echo "X-VMWare Tools"
            InstallVMWareTools
            ;;
        "Terminator")
            echo "Install Terminator"
            yum -y install terminator
            ;;
        "Ansible")
            echo "Install Ansible"
            InstallAnsible
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
            yum -y install git
            ;;
        "PyCharm")
            echo "Install PyCharm"
            InstallPyCharm
            ;;
        "Oracle_Java_8")
            echo "X-Oracle_Java_8"
            InstallOracleJava8
            ;;
        "MongoDB")
            echo "X-MongoDB"
            InstallMongoDB
            ;;
        "NodeJS")
            echo "X-NodeJS"
            InstallNodeJs
            ;;
        "Yarn")
            echo "X-Yarn"
            InstallYarn
            ;;
        "WebStorm")
            echo "X-WebStorm"
            InstallWebStorm
            ;;
        "Docker")
            echo "X-Docker"
            InstallDocker
            ;;
        "Gogland")
            echo "X-Gogland"
            InstallGogland
            ;;
        "Intellij")
            echo "X-Intellij"
            InstallIntelliJ
            ;;
    esac
done

readonly ORACLE_JAVA_8_INSTALLER=http://download.oracle.com/otn-pub/java/jdk/8u60-b27/jre-8u60-linux-x64.rpm
readonly ORACLE_JAVA_8_JDK_INSTALLER=http://download.oracle.com/otn-pub/java/jdk/8u60-b27/jdk-8u60-linux-x64.rpm

if [ "root" != $USER ];
then
    echo Must run setup at \'root\', please use \'sudo bash\'.
    exit
fi

if [ ! -z "$(which dialog)" ];
then
     echo "dialog already installed"
else
      yum -y install dialog
fi

function InstallUpdates {
    echo Start Updates
    yum -y upgrade
    echo Finished Updates
}

# Package: Ansible
function CheckAnsibleVersion()
{
    if [ ! -z "$(which ansible)" ];
    then
        echo "$(ansible --version)"
    else
        echo "Not Installed"
    fi
}

function InstallAnsible {
    echo Start Ansible
    yum -y install ansible
    echo Finished Ansible
}

# Package: Git
function CheckGitVersion()
{
    if [ ! -z "$(which git)" ];
    then
	     echo "$(git --version)"
    else
        echo "Not Installed"
    fi
}

# Package: Java
function CheckJavaVersion()
{
    if [ ! -z "$(which java)" ];
    then
        echo "$(java -version 2>&1 | awk -F ' ' '/version/ {print $1 " " $3}' | sed 's/"//g')"
    else
        echo "Not Installed"
    fi
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

# Package: NodeJS
function CheckNodeJSVersion()
{
    if [ ! -z "$(which node)" ];
    then
        echo "$(node --version)"
    else
        echo "Not Installed"
    fi
}

function InstallNodeJs {
    curl --silent --location https://rpm.nodesource.com/setup_7.x | bash -
    yum -y install nodejs
}

# Package: Yarn
function CheckYarnVersion()
{
    if [ ! -z "$(which yarn)" ];
    then
        echo "$(yarn --version)"
    else
        echo "Not Installed"
    fi
}

function InstallYarn {
  wget https://dl.yarnpkg.com/rpm/yarn.repo -O /etc/yum.repos.d/yarn.repo
  yum -y install yarn
}

DIALOG=${DIALOG=dialog}
tempfile=`tempfile 2>/dev/null` || tempfile=/tmp/test$$
trap "rm -f $tempfile" 0 1 2 5 15

$DIALOG --backtitle "Check what you would like installed" \
	--title "BootStrap Setup" --clear \
        --checklist "What would you like to install? " 24 61 16 \
         "General_Updates" "" off \
         "Extra_Packages_for_Ent_Linux" "" off \
         "Ansible" "$(CheckAnsibleVersion)" off \
         "Git" "$(CheckGitVersion)" off \
         "NodeJS" "$(CheckNodeJSVersion)" off \
         "Oracle_Java_8" "$(CheckJavaVersion)" off \
         "Yarn" "$(CheckYarnVersion)" off \
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
        "Ansible")
            echo "Install Ansible"
            InstallAnsible
            ;;
        "Git")
            echo "Install Git"
            yum -y install git
            ;;
        "NodeJS")
            echo "X-NodeJS"
            InstallNodeJs
            ;;
        "Oracle_Java_8")
            echo "X-Oracle_Java_8"
            InstallOracleJava8
            ;;
        "Yarn")
            echo "X-Yarn"
            InstallYarn
            ;;
    esac
done

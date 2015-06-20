#! /bin/bash
if [ "root" != $USER ];
then
    echo Must run setup at \'root\', please use \'sudo bash\'.
    exit
fi

function InstallUpdates {
    echo Start Updates
    apt-get update
    apt-get upgrade -y
    echo Finished Updates
}

function InstallVMWareTools {
    echo Installing VMWare Tools
    echo    Extracting VMware Tools
    #tar -xvzf /media/mshea/VMware\ Tools/VMwareTools-9.9.3-2759765.tar.gz -C /home/mshea/Downloads/

    echo Installing VMWare Tools
    #/home/mshea/Downloads/vmware-tools-distrib/vmware-install.pl -d

    echo clean up VMWare Folder
    #rm -rf /home/mshea/Downloads/vmware-tools-distrib
}


DIALOG=${DIALOG=dialog}
tempfile=`tempfile 2>/dev/null` || tempfile=/tmp/test$$
trap "rm -f $tempfile" 0 1 2 5 15

$DIALOG --backtitle "Check what you would like installed" \
	--title "Developer Setup" --clear \
        --checklist "Hi, you can select your favorite singer here  " 20 61 13 \
         "General_Updates" "General Updates" off \
         "VMWare_Tools" "VMWare Tools" off \
         "Terminator" "Terminator" off \
         "Chrome" "Chrome" off \
         "Sublime" "Sublime" off \
         "Atom" "Atom" off \
         "Git" "Git" off \
         "Maven" "Maven" off \
         "Oracle_Java_8" "Oracle Java 8" off \
         "Eclipse" "Eclipse" off \
         "NodeJS" "NodeJS" off \
         "WebStorm" "WebStorm" off \
         "Docker" "Docker" off \
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
            InstallUpdate
            ;;
        "VMWare_Tools")
            echo "X-VMWare Tools"
            ;;
        "Terminator")
            echo "Install Terminator"
            apt-get install -y terminator
            ;;
        "Chrome")
            echo "X-Chrome"
            dpkg -i /home/mshea/Downloads/google-chrome-stable_current_i386.deb
            apt-get -f install
            ;;
        "Sublime")
            echo "X-Sublime"
            ;;
        "Atom")
            echo "X-Atom"
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
            ;;
        "Eclipse")
            echo "X-Eclipse"
            ;;
        "NodeJS")
            echo "Install NodeJS"
            apt-get install -y nodejs
            apt-get install -y npm
            ;;
        "WebStorm")
            echo "X-WebStorm"
            ;;
        "Docker")
            echo "X-Docker"
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


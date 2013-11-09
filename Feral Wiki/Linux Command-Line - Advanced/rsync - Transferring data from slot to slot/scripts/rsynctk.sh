#!/bin/bash
# rsynctk
scriptversion="1.1.3"
scriptname="rsync"
# randomessence
############################
## Version History Starts ##
############################
#
# 0.0.1 Initial Version
# 0.0.8 beta
# 0.0.9 script renamed to rsynctk to avoid conflict with rsync itself.
# 1.0.0 Should be a working, fucntional script
# 1.0.2 various bug fixes, typos and general visual layout
# 1.0.3 echos with custom commands
# 1.0.5 screen exec
# 1.0.6 removed partials
# 1.0.7 screen .... -p 0 was the secret sauce. Otherwise you need to be attached to the screen for the command to work
# 1.0.8 users can run a feral or whatbox version of the script.
# 1.1.1 some visual tweaks and clearer echoes
# 1.1.2 Option to select custom destination. Default is ~/rsync
# 1.1.3 custom destination is created incase it is a nested location and other small tweaks
#
############################
### Version History Ends ###
############################
#
############################
###### Variable Start ######
############################
#
mish="$(shuf -i 1-100 -n 1)"
defaultpath="rsync"
scripturl="https://raw.github.com/feralhosting/feralfilehosting/master/Feral%20Wiki/Linux%20Command-Line%20-%20Advanced/rsync%20-%20Transferring%20data%20from%20slot%20to%20slot/scripts/rsynctk.sh"
#
############################
####### Variable End #######
############################
#
############################
#### Self Updater Start ####
############################
#
mkdir -p "$HOME/bin"
#
if [[ ! -f "$HOME/rsynctk.sh" ]]
then
    wget -qO "$HOME/rsynctk.sh" "$scripturl"
fi
if [[ ! -f "$HOME/bin/rsynctk.sh" ]]
then
    wget -qO "$HOME/bin/rsynctk" "$scripturl"
fi
#
wget -qO "$HOME/000rsynctk.sh" "$scripturl"
#
if ! diff -q "$HOME/000rsynctk.sh" "$HOME/rsynctk.sh" > /dev/null 2>&1
then
    echo '#!/bin/bash
    wget -qO "$HOME/rsynctk.sh" "'$scripturl'"
    wget -qO "$HOME/bin/rsynctk" "'$scripturl'"
    bash "$HOME/rsynctk.sh"
    exit 1' > "$HOME/111rsynctk.sh"
    bash "$HOME/111rsynctk.sh"
    exit 1
fi
if ! diff -q "$HOME/000rsynctk.sh" "$HOME/bin/rsynctk" > /dev/null 2>&1
then
    echo '#!/bin/bash
    wget -qO "$HOME/rsynctk.sh" "'$scripturl'"
    wget -qO "$HOME/bin/rsynctk" "'$scripturl'"
    bash "$HOME/rsynctk.sh"
    exit 1' > "$HOME/222rsynctk.sh"
    bash "$HOME/222rsynctk.sh"
    exit 1
fi
#
echo
echo -e "Hello $(whoami), you have the latest version of the" "\033[36m""$scriptname""\e[0m" "script. This script version is:" "\033[31m""$scriptversion""\e[0m"
#
rm -f "$HOME/000rsynctk.sh" "$HOME/111rsynctk.sh" "$HOME/222rsynctk.sh"
chmod -f 700 "$HOME/bin/rsynctk"
echo
#
############################
##### Self Updater End #####
############################
#
read -ep "The scripts have been updated, do you wish to continue [y] or exit now [q] : " updatestatus
echo
if [[ $updatestatus =~ ^[Yy]$ ]]
then
#
############################
####### Script Start #######
############################
#
read -ep "Do you want to Copy from another Feral server [f] or import from whatbox.ca [w] : " feral
echo
if [[ $feral =~ ^[Ff]$ ]]
then
    mkdir -p ~/rsync
    echo -e "\033[32m""Give the username of the feral account that controls the slot""\e[0m"
    read -ep " What is your username on the old slot? : " username
    echo
    echo -e "\033[32m""Example, if your server is" "\033[31m""hypnos.feralhosting.com" "\033[32m""then" "\033[33m""hypnos" "\033[32m""is the server name""\e[0m"
    read -ep " What is the server name of the slot with your files? : " servername
    echo
    echo -e "\033[31m""IMPORTANT INFO : Please read these comments.""\e[0m"
    echo
    echo -e "\033[32m""Path ends with" "\033[36m""/""\e[0m" "\033[32m""= will copy the all contents of this folder to into" "\033[36m""~/rsync""\e[0m"
    echo -e "\033[33m""Path does not end with" "\033[36m""/""\e[0m" "\033[33m""= the folder you link to and its contents will be copied into" "\033[36m""~/rsync""\e[0m"
    echo
    echo -e "So" "\033[36m""private/rtorrent/""\e[0m" "will copy all the content of the" "\033[36m""rtorrent""\e[0m" "to" "\033[36m""~/rsync/<contents of directory>""\e[0m"
    echo -e "So" "\033[36m""private/rtorrent""\e[0m" "will copy the" "\033[36m""rtorrent""\e[0m" "directory itself to" "\033[36m""~/rsync/rtorrent/<contents of directory>""\e[0m"
    echo -e "\033[33m""Here is a good webpage with examples:""\e[0m" "http://tinyurl.com/nejatwy"
    echo
    read -ep "Are you sure you have understood [y] or do you want to double check [n] : " confirm
    echo
    if [[ $confirm =~ ^[Yy]$ ]]
    then
        read -ep "Please enter the relative path to the folder you wish to copy: ~/" path
        echo
        read -ep "Would you like to select a custom destination for your files? [y]es or [n]o: " customdest
        echo
        if [[ $customdest =~ ^[Yy]$ ]]
        then
            read -ep "Please enter the relative path to the custom destination folder: ~/" defaultpath
            mkdir -p ~/$defaultpath
            echo
        fi
    else
        exit 1
    fi
    echo -e "\033[33m""Here is the command you have just created:""\e[0m"
    echo
    echo -e "\033[31m""rsync" "\033[32m""-avhPSe ssh" "\033[35m""$username""\e[0m""@""\033[35m""$servername""\e[0m""\033[37m"".feralhosting.com:""\033[36m""~/$path ~/$defaultpath""\e[0m"
    echo
    read -ep "Would you like to try and run this command in a screen [y] or exit now [e]: " confirmscreen1
    echo
    if [[ $confirmscreen1 =~ ^[Yy]$ ]]
    then
        if [[ ! -f ~/.ssh/rsynctk_rsa ]]
        then
            ssh-keygen -q -t rsa -b 2048 -f ~/.ssh/rsynctk_rsa -N ''
        fi
        echo -e "Make sure you have copied the contents of the file:" "\033[36m""~/.ssh/rsynctk_rsa.pub""\e[0m" "we just generated, to your OLD slot's" "\033[36m""~/.ssh/authorized_keys""\e[0m" "file."
        echo -e "\033[31m""We can do this while the script is loaded using SSH and the ssh-copy-id command if you have not already done it.""\e[0m"
        echo -e "\033[32m""If you say""\e[0m" "[Y]" "\033[32m""below , please then type" "\033[33m""yes""\e[0m" "\033[32m""in the next step to accept the other slots host key""\e[0m"
        echo
        read -ep "Would you like to do this now via SSH, your OLD slot's SSH password is required [y] or skip [n] : " sshcopy
        echo
        if [[ $sshcopy =~ ^[Yy]$ ]]
        then
            ssh-copy-id -i ~/.ssh/rsynctk_rsa.pub $username@$servername.feralhosting.com
        fi
        read -ep "Have you copied the ~/.ssh/rsynctk_rsa.pub contents to your old slot's ~/.ssh/authorized_keys file [y] or [n] " confirmscreen2
        echo
        if [[ $confirmscreen2 =~ ^[Yy]$ ]]
        then
            echo
            echo -e "\033[32m""I will now attempt to create a screen and start the proccess." "\033[31m""If you have not copied you public key it won't work.""\e[0m"
            #
            screen -dmS rsynctk$mish
            sleep 2
            screen -S rsynctk$mish -p 0 -X exec rsync -avhPSe "ssh -i $HOME/.ssh/rsynctk_rsa" $username@$servername.feralhosting.com:~/$path ~/$defaultpath
            echo
            echo "Here is the screen process"
            echo
            screen -ls | grep rsynctk$mish
            echo
            echo -e "\033[31m""Useful Notes:""\e[0m"
            echo -e "The normal command, requires you create a screen an enter your old slot's SSH password"
            echo -e "\033[31m""rsync" "\033[32m""-avhPSe ssh" "\033[35m""$username""\e[0m""@""\033[35m""$servername""\e[0m""\033[37m"".feralhosting.com:""\033[36m""~/$path ~/$defaultpath""\e[0m"
            echo
            echo -e "The command that uses our public/private key file pair."
            echo -e "\033[31m""rsync" "\033[32m""-avhPSe" "\e[0m""\033[37m""\"ssh -i $HOME/.ssh/rsynctk_rsa\"" "\033[35m""$username""\e[0m""@""\033[35m""$servername""\e[0m""\033[37m"".feralhosting.com:""\033[36m""~/$path ~/$defaultpath""\e[0m"
            echo
            echo -e "\033[33m""The command to copy our public key to the old slot's" "\033[36m""~/.ssh/authorized_keys""\e[0m" "\033[33m""file.""\e[0m"
            echo -e "ssh-copy-id -i ~/.ssh/rsynctk_rsa.pub $username@$servername.feralhosting.com"
            echo
            echo -e "Type:" "\033[33m""screen -r rsynctk$mish""\e[0m" "To attach to the screen"
            echo
        fi
    fi
elif [[ $feral =~ ^[Ww]$ ]]
then
    mkdir -p ~/rsync
    echo -e "\033[32m""Give the username of the whatbox account that controls the slot""\e[0m"
    read -ep " What is your username on the old server? : " username
    echo
    echo -e "\033[32m""Example, if your server is" "\033[31m""rabbit.whatbox.ca" "\033[32m""then" "\033[33m""rabbit" "\033[32m""is the server name""\e[0m"
    read -ep " What is the server name of the server with your files? : " servername
    echo
    echo -e "\033[31m""IMPORTANT INFO : Please read these comments.""\e[0m"
    echo
    echo -e "\033[32m""Path ends with" "\033[36m""/""\e[0m" "\033[32m""= will copy the all contents of this folder to into" "\033[36m""~/rsync""\e[0m"
    echo -e "\033[33m""Path does not end with" "\033[36m""/""\e[0m" "\033[33m""= the folder you link to and its contents will be copied into" "\033[36m""~/rsync""\e[0m"
    echo
    echo -e "So" "\033[36m""private/rtorrent/""\e[0m" "will copy all the content of the" "\033[36m""rtorrent""\e[0m" "to" "\033[36m""~/rsync/<contents of directory>""\e[0m"
    echo -e "So" "\033[36m""private/rtorrent""\e[0m" "will copy the" "\033[36m""rtorrent""\e[0m" "directory itself to" "\033[36m""~/rsync/rtorrent/<contents of directory>""\e[0m"
    echo -e "\033[33m""Here is a good webpage with examples:""\e[0m" "http://tinyurl.com/nejatwy"
    echo
    read -ep "Are you sure you have understood [y] or do you want to double check [n] : " confirm
    echo
    if [[ $confirm =~ ^[Yy]$ ]]
    then
        read -ep "Please enter the relative path to the folder you wish to copy: ~/" path
        echo
        read -ep "Would you like to select a custom destination for your files? [y]es or [n]o: " customdest
        echo
        if [[ $customdest =~ ^[Yy]$ ]]
        then
            read -ep "Please enter the relative path to the custom destination folder: ~/" defaultpath
            mkdir -p ~/$defaultpath
            echo
        fi
    else
        exit 1
    fi
    echo -e "\033[33m""Here is the command you have just created:""\e[0m"
    echo
    echo -e "\033[31m""rsync" "\033[32m""-avhPSe ssh" "\033[35m""$username""\e[0m""@""\033[35m""$servername""\e[0m""\033[37m"".whatbox.ca:""\033[36m""~/$path ~/$defaultpath""\e[0m"
    echo
    read -ep "Would you like to try and run this command in a screen [y] or exit now [e]: " confirmscreen1
    echo
    if [[ $confirmscreen1 =~ ^[Yy]$ ]]
    then
        if [[ ! -f ~/.ssh/rsynctk_rsa ]]
        then
            ssh-keygen -q -t rsa -b 2048 -f ~/.ssh/rsynctk_rsa -N ''
        fi
        echo -e "Make sure you have copied the contents of the file:" "\033[36m""~/.ssh/rsynctk_rsa.pub""\e[0m" "we just generated, to your OLD slot's" "\033[36m""~/.ssh/authorized_keys""\e[0m" "file."
        echo -e "\033[31m""We can do this while the script is loaded using SSH and the ssh-copy-id command if you have not already done it.""\e[0m"
        echo -e "\033[32m""If you say""\e[0m" "[Y]" "\033[32m""below , please then type" "\033[33m""yes""\e[0m" "\033[32m""in the next step to accept the other slots host key""\e[0m"
        echo
        read -ep "Would you like to do this now via SSH, your OLD slot's SSH password is required [y] or skip [n] : " sshcopy
        echo
        if [[ $sshcopy =~ ^[Yy]$ ]]
        then
            ssh-copy-id -i ~/.ssh/rsynctk_rsa.pub $username@$servername.whatbox.ca
        fi
        read -ep "Have you copied the ~/.ssh/rsynctk_rsa.pub contents to your old slot's ~/.ssh/authorized_keys file [y] " confirmscreen2
        echo
        if [[ $confirmscreen2 =~ ^[Yy]$ ]]
        then
            echo
            echo -e "\033[32m""I will now attempt to create a screen and start the proccess." "\033[31m""If you have not copied you public key it won't work.""\e[0m"
            #
            screen -dmS rsynctk$mish
            sleep 2
            screen -S rsynctk$mish -p 0 -X exec rsync -avhPSe "ssh -i $HOME/.ssh/rsynctk_rsa" $username@$servername.whatbox.ca:~/$path ~/$defaultpath
            echo
            echo "Here is the screen process"
            echo
            screen -ls | grep rsynctk$mish
            echo
            echo -e "\033[31m""Useful Notes:""\e[0m"
            echo -e "The normal command, requires you create a screen an enter your old slot's SSH password"
            echo -e "\033[31m""rsync" "\033[32m""-avhPSe ssh" "\033[35m""$username""\e[0m""@""\033[35m""$servername""\e[0m""\033[37m"".whatbox.ca:""\033[36m""~/$path ~/$defaultpath""\e[0m"
            echo
            echo -e "The command that uses our public/private key file pair."
            echo -e "\033[31m""rsync" "\033[32m""-avhPSe" "\e[0m""\033[37m""\"ssh -i $HOME/.ssh/rsynctk_rsa\"" "\033[35m""$username""\e[0m""@""\033[35m""$servername""\e[0m""\033[37m"".whatbox.ca:""\033[36m""~/$path ~/$defaultpath""\e[0m"
            echo
            echo -e "\033[33m""The command to copy our public key to the old slot's" "\033[36m""~/.ssh/authorized_keys""\e[0m" "\033[33m""file.""\e[0m"
            echo -e "ssh-copy-id -i ~/.ssh/rsynctk_rsa.pub $username@$servername.whatbox.ca"
            echo
            echo -e "Type:" "\033[33m""screen -r rsynctk$mish""\e[0m" "To attach to the screen"
            echo
        fi
    fi
else
    echo "I am confused let me start over"
    bash ~/rsynctk.sh
    exit 1
fi
else
    echo -e "You chose to exit after updating the scripts."
    cd && bash
    exit 1
fi
exit 1
#
#
#
############################
####### Script Ends  #######
############################
#
############################
########## Credit ##########
############################
#
#
#
############################
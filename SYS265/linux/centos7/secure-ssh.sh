#!/bin/bash
#secure-ssh.sh
#author samuel barrows
#creates a new ssh user using the $1 parameter
#adds a public key from the local repo or curled from the remote repo
#removes roots ability to ssh in

#test that root is running the script
if [ $(id -u) -ne 0 ]; then
  echo "Please run as root"
  exit
fi

username=$1

#function to make a user and give the public key to them
makeuser(){
  useradd -m -s /bin/bash $username 
  mkdir /home/$username/.ssh
  #appends the public key for our web server into the new users authorized keys
  cat ../public-keys/id_rsa.pub >> /home/$username/.ssh/authorized_keys
  chmod 700 /home/$username/.ssh
  chmod 600 /home/$username/.ssh/authorized_keys
  chown -R $username:$username /home/$username/.ssh
}

makeuser



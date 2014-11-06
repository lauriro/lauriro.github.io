---
layout: post
published: true
title: SSH and GnuPG
summary: Generating keys
tags: [ssh, gnupg]
time: "12:05"
css:
- /css/pygments.css
- /css/gist.css
---

Setup SSH
---------

```bash
# Prepare .ssh folder
mkdir ~/.ssh
chmod 700 ~/.ssh

touch ~/.ssh/authorized_keys
chmod 600 ~/.ssh/authorized_keys
touch ~/.ssh/config
chmod 600 ~/.ssh/config
touch ~/.ssh/known_hosts
chmod 600 ~/.ssh/known_hosts

# Generating SSH keys
ssh-keygen -t rsa -b 2048 -C "me@email.adr"

# for ssh connections multiplexing
mkdir ~/.ssh/connections
chmod 700 ~/.ssh/connections
```


# Pull id_rsa.pub from remote

> $ ssh host "cat ~/.ssh/id_rsa.pub" >> ~/.ssh/authorized_keys 


# Push id_rsa.pub to remote

> $ ssh host "cat - >> ~/.ssh/authorized_keys" < ~/.ssh/id_rsa.pub


Convert SSH keys for GnuPG
--------------------------

```bash
# create a certificate for ssh key:
$ openssl req -new -x509 -key ~/.ssh/id_rsa -out ~/.ssh/id_rsa.pem
# import it in GnuPG
$ openssl pkcs12 -export -in ~/.ssh/id_rsa.pem -inkey ~/.ssh/id_rsa -out ~/.ssh/id_rsa.p12
$ gpg --import ~/.ssh/id_rsa.p12
```

More
----

```bash
chmod 700 ~/.gnupg

chmod 600 ~/.ssh/id_rsa
chmod 644 ~/.ssh/id_rsa.pub  

cat ~/.ssh/id_rsa.pub | ssh remotehost "cat > .ssh/authorized_keys; chmod 600 .ssh/authorized_keys"
ssh-copy-id -i ~/.ssh/id_rsa.pub remotehost
wget -qO - "http://rooden.ee/pub/id_rsa.pub" >> ~/.ssh/authorized_keys
curl -Ls http://www.rooden.ee/pub/id_rsa.pub >> ~/.ssh/authorized_keys

# Create a public SSH key from the private key
ssh-keygen -f ~/.ssh/id_rsa -y > ~/.ssh/id_rsa.pub

# Compare a remote file with a local file
ssh user@host cat /path/remotefile | diff /path/localfile -

# SSH network throughput test
yes | pv | ssh user@host "cat > /dev/null"

```

---
layout: post
title:  "How to add your SSH keys to a server for password-less logins"
date:   2018-07-02 16:54:07 +0100
tags: sysadmin ssh keys
---

SSH keys allow you to login into your SSH server without having to remember passwords and with much stronger security. It's like having a super long password that you never have to remember... Just keep your private keys in a safe place.

## Generate Public and Private Keys

Generate public keys. The command will produce two keys, one public (`~/.ssh/example.com-id.pub`) and one private (`~/.ssh/example.com-id`).

```shell
ssh-keygen -f ~/.ssh/example.com-id
```


## Copy Public Key to the target machine

Your remote server needs to know your public key, so you need to send it there.

```shell
#copy the public key to the target machine
ssh-copy-id -i ~/.ssh/example.com-id.pub exampleuser@example.com
```

## Set appropriate permissions

Your private key should only be visible to you and not other users, otherwise `ssh` will complain and not allow you to use the keys.

```shell
chmod 0700 ~/.ssh/
chmod 0600 ~/.ssh/example.com-id
```

## Create Configuration File for auto login

This config file will tell `ssh` where are the configurations for an alias for your now key-authenticated server.

```shell
vim ~/.ssh/config
```

### Example contents of the new file

```shell
#alias of the machine into which you are logging in
Host example.com

#hostname or ip of the machine
HostName example.com

#the username with which you are logging in
User exampleuser

#the private key, without "-pub"
IdentityFile ~/.ssh/example.com-id
```


### Login using machine identifier

Now you can login using `ssh` and the alias you choose in the config file above.

```shell
ssh example.com
```


### Save your keys and configuration file in a "safe place" for later

You can login from other computers using the same public key without having to configure the server again.
All you need is to copy:

 - The `~/.ssh/config` file
 - The public (`~/.ssh/example.com-id.pub`) and private keys (`~/.ssh/example.com-id`)

into your `~/.ssh` directory in the new machine.

### Disable remote login using passwords

```shell
vim /etc/ssh/sshd_config
```

Search for the line below and uncomment `PasswordAuthentication No`

```shell
# Change to no to disable tunnelled clear text passwords
#PasswordAuthentication no #change to PasswordAuthentication no without the hash
```

Restart the sshd service

```shell
sudo service ssh restart
```

#### Fair warning!
Remember, if others also get these keys and configuration file they can log into your server!

## Tunnel connections

Tunnel connections are really cool if you have a server running somewhere and you need to access that server as if it was running on your own computer!

### Configuring the remote machine

We need to configure the `sshd` service to enable TCP connections forwarding. Start by editing `/etc/ssh/sshd_config`

```shell
sudo vim /etc/ssh/sshd_config
```

Enable these row:

```conf
AllowTcpForwarding yes
TCPKeepAlive yes
```

Restart the `sshd` service:

```shell
sudo service sshd restart
```

### Opening the tunnel

With username + password:

```shell
ssh -L 5901:127.0.0.1:5901 -C -N -l username server_address
```

With with a public key configuration:

```shell
ssh -L 5901:127.0.0.1:5901 -C -N dendro-builder.fe.up.pt -v
```


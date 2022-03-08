---
layout: post
title:  "How to add your SSH keys to a server for password-less logins"
date:   2018-07-02 16:54:07 +0100
tags: sysadmin ssh keys
---

SSH keys allow you to login into your SSH server without having to remember passwords and with much stronger security. It's like having a super long password that you never have to remember... Just keep your private keys in a safe place.

## Generate Public and Private Keys

Generate public-private key pair. The command will produce two keys, one public (`~/.ssh/example.com-id.pub`) and one private (`~/.ssh/example.com-id`).

```shell
ssh-keygen -f ~/.ssh/example.com-id
```

{% include danger.html content="If someone gets your private key and knows your username they can log into the server!!" %}

## Copy Public Key to the target machine

Your remote server needs to know your public key, so you need to send it there.

```shell
#copy the public key to the target machine
ssh-copy-id -i ~/.ssh/example.com-id.pub exampleuser@example.com
```

## Set appropriate permissions in your local ~/.ssh folder

Your private key should only be visible to you and not other users, otherwise `ssh` will complain and not allow you to use the keys.

```shell
chmod 0700 ~/.ssh/
chmod 0600 ~/.ssh/example.com-id
```

## Set appropriate permissions in the remote ~/.ssh folder

```shell

# remove write access to group and others, keep user only
chmod go-w /home/$(whoami) 

# give all permissions to user, none to any others
chmod 700 /home/$(whoami)/.ssh/

# give all permissions except execute to user, none to any others
chmod 600 /home/$(whoami)/.ssh/authorized_keys 
````

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


## Login using machine identifier

Now you can login using `ssh` and the alias you choose in the config file above.

```shell
ssh example.com
```

## Debugging login issues

If you still cannot login, try setting the verbose flag in the ssh client, try to connect again and read the output carefully to find the root issue:

```shell
# Verbose login
ssh -v example.com
````

### An example of debugging

A permissions issue in the remote .ssh directory would make ssh would prompt for the password. The error would only manifest itself after entering the password and continuing with that auth method:

```shell
debug1: Next authentication method: password
user@example.com's password:
debug1: Authentication succeeded (password).
Authenticated to example.com ([100.64.1.29]:22).
debug1: channel 0: new [client-session]
debug1: Requesting no-more-sessions@openssh.com
debug1: Entering interactive session.
debug1: pledge: network
debug1: client_input_global_request: rtype hostkeys-00@openssh.com want_reply 0

# ERROR ONLY LOGGED AFTER LOGIN WITH PASSWORD!
debug1: Remote: Ignored authorized keys: bad ownership or modes for directory /home/user/.ssh 
```

## Save your keys and configuration file in a "safe place" for later

You can login from other computers using the same public key without having to configure the server again.
All you need is to copy:

 - The `~/.ssh/config` file
 - The public (`~/.ssh/example.com-id.pub`) and private keys (`~/.ssh/example.com-id`)

into your `~/.ssh` directory in the new machine.

## Disable remote login using passwords

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

## Removing keys from the SSH agent (GitHub SSH Push)

If you have errors like:

```shell
agent key RSA SHA256:XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX returned incorrect signature type
sign_and_send_pubkey: no mutual signature supported
git@github.com: Permission denied (publickey).
```

Try removing the key from the SSH Agent:

```shell
eval `ssh-agent -s`
ssh-add -D ~/.ssh/privatekey-id
```

And try again to push. 


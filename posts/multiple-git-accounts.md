---
    title: github - accounts
    slug: multiple git accounts
---

# How to maintain multiple git account from one laptop

### ssh-keys-generations 

```shell script
    ssh-keygen -t rsa -C "santhosh.piduri@gmail.com" -f "my_workspace"
    
    Generating public/private rsa key pair.
    Enter passphrase (empty for no passphrase): 
    Enter same passphrase again: 
    Your identification has been saved in my_workspace.
    Your public key has been saved in my_workspace.pub.
    The key fingerprint is:
    SHA256:VDk9us+3K5o9rCIDKrGkVDgDvh5YcKRZZWvmfI3G7Fo santhosh.piduri@gmail.com
    The key's randomart image is:
    +---[RSA 2048]----+
    | .o.o     .o     |
    |o+.. .   .o o    |
    |=o. +   .  o .   |
    | =.* o +  .      |
    |..= o * S  .     |
    |o=  .+    .      |
    |=o.. .E    +     |
    |+..  oo .  o* .  |
    | .  .  o .+o.+oo |
    +----[SHA256]-----+
```

### Add your generated public key to your github account (under Settings -> SSH and GPG keys -> New SSH Key -> Add Key)

```shell script
pbcopy < ~/.ssh/my_workspace.pub
```
### modify ~/.ssh/config file 

```shell script

# Personal account, - the default config
Host github.com
   HostName github.com
   User Venkata-Santhosh
   IdentityFile ~/.ssh/my_workspace

# Office account 
Host github.officeworkspace.com
    HostName github.officeworkspace.com
    User VenkataSanthosh-Piduri
    IdentityFile ~/.ssh/id_rsa
```

### Optional (add your generated keys to ssh-agent)

```shell script
# few useful commands 
ssh-add -l

ssh-add -D # deletes all active keys from ssh-agent

ssh-add ~/.ssh/myworkspace # to attach key to ssh-agent 

```

### Configure github user-names 

```shell script
git config user.name # display username 
```

```shell script

# ~/.gitconfig

[user]
	name = VenkataSanthosh-Piduri
	email = VenkataSanthosh.Piduri@officeworkspace.com
[includeif "gitdir:~/mygit/"]
	path = ~/mygit/.gitconfig

```

```shell script
[user]
	name = Venkata-Santhosh
	email = santhosh.piduri@gmail.com
```
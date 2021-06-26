# Ansible assignment
## Create and deploy your own service
### The development stage:
For the true enterprise grade system we will need Python3, Flask and emoji support. Why on Earth would we create stuff that does not support emoji?!

* the service listens at least on port 80 (443 as an option)
* the service accepts GET and POST methods
* the service should receive `JSON` object and return strings in the following manner:
```sh
curl -XPOST -d'{"animal":"cow", "sound":"moooo", "count": 3}' http://myvm.localhost/
cow says moooo
cow says moooo
cow says moooo
Made with ❤️ by %your_name

curl -XPOST -d'{"animal":"elephant", "sound":"whoooaaa", "count": 5}' http://myvm.localhost/
elephant says whoooaaa
elephant says whoooaaa
elephant says whoooaaa
elephant says whoooaaa
elephant says whoooaaa
Made with ❤️ by %your_name
```
* bonus points for being creative when serving `/`

### The operating stage:
* create an ansible playbook that deploys the service to the VM
* make sure all the components you need are installed and all the directories for the app are present
* configure systemd so that the application starts after reboot
* secure the VM so that our product is not stolen: allow connections only to the ports 22,80,443. Disable root login. Disable all authentication methods except 'public keys'.
* bonus points for SSL/HTTPS support with self-signed certificates
* bonus points for using ansible vault

### Requirements
* Debian 10
* VirtualBox VM



### terms used
\<the target system user> -- user of your VM
\<the target system sudo password> -- sudo password of user on your VM
\<the target system ip> -- the IP address of your VM
\<path to ssh-keys> -- path to ssh keys (for example: ```~/.ssh/example_id_rsa```)
\<the target group name> -- name of your group of instances in hosts file
\<vault file name> -- name of your ansible-vault file with secrets
\<path to your inventory file> -- path to your hosts file
> if user on your VM not in sudo group and no ssh keys

##### install sudo
Go to the superuser with the command:  
```sh
su
```
enter root password then install ```sudo```:
```sh
apt install sudo
```

##### add user to sudo group:
Under the superuser, enter the command:
```sh
/usr/sbin/usermod -aG sudo <the target system user>
```
example:
```sh
/usr/sbin/usermod -aG sudo gizar_devops_course
```
For the changes to take effect, you need to logout.

``ssh-copy-id`` - install your identity.pub in a remote machine's authorized_keys
```ssh-keygen``` generates, manages and converts authentication keys for [ssh](https://www.opennet.ru/cgi-bin/opennet/man.cgi?topic=ssh&category=1)
###### info from [opennet](opennet.ru)
genereating ssh-keys:
1. ```ssh-keygen -q -t rsa -N '' -f <path to ssh-keys> <<<y 2>&1 >/dev/null```

```<<< y``` for overwrite if it needed

for example: 
```ssh-keygen -q -t rsa -N '' -f ~/.ssh/gizar_course_id_rsa <<<y 2>&1 >/dev/null```

install pub to VM:

2. ```ssh-copy-id -i <path to ssh-keys> <the target system user>@<the target system ip>```

for example:
```ssh-copy-id -i ~/.ssh/gizar_course_id_rsa.pub gizar_devops_course@192.168.33.10```

> presetting ansible things

##### hosts:
```
[<the target group name>]
<the target system ip>
[<the target group name>:vars]
ansible_user=<the target system user>
```
example you can view in my hosts file in "ansible_task" directory (or use my hosts file after your editing)

##### ansible.cfg:
```
[defaults]
interpreter_python=/usr/bin/python3
host_key_checking = False
```
##### ansible-vault:
create vault file:

1. ```ansible-vault create <vault file name>```
for example:
```ansible-vault create secret.yml```
2. Enter vault password and write this lines:
```
ansible_sudo_pass: <the target system sudo password>
ansible_ssh_private_key_file: <path to ssh-keys>
```
##### playbook.yml
open ```playbook.yml``` and edit this lines:

```hosts : <the target group name>``` (3rd string in file)

```app_path : /home/<the target system user>/``` (7th string in file)


>deploy

```ansible-playbook -i <path to your inventory file> playbook.yml --ask-vault-pass -e '@<vault file name>'```





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



### Presetting the target system

#### install sudo
Go to the superuser with the command:  
```sh
su
```
enter root password then install ```sudo```:
```sh
apt install sudo
```

#### add user to sudo group:
Under the superuser, enter the command:
```sh
/usr/sbin/usermod -aG sudo <here the target machine user>
```
example:
```sh
/usr/sbin/usermod -aG sudo gizar
```
For the changes to take effect, you need to logout.


### vault
```sh
ansible-vault create secret.yml
```
enter your vault passsword, then add this lines to file:
```
ansible_sudo_pass: <sudo pass of target machine user>
ansible_ssh_private_key_file: ~/.ssh/andersen_id_rsa
```
###### or if you use my secret.yml

my vault password: vault

```sh
ansible-vault edit secret.yml
```
enter my vault passsword, then edit this line:
```ansible_sudo_pass: andersen``` to ```ansible_sudo_pass: <sudo pass of target machine user>```



#### edit my ```hosts``` file
configure the inventory file:
```sh
flasktask ansible_host=<here the target machine ip>
....
ansible_user=<here the target machine user>
```
### Deploy

  1. the 'deploy' script will generate the ssh keys and send them to the target machine 
  2. updating the target system and install python3, python3-pip, python-setuptools, ufw
  3. creating dir for flask application
  4. copy service file
  5. installing flask
  6. installing emoji
  7. copy flask_app.py
  8. enable ufw
  9. creating rules 
  10. copy sshd config
  11. restarting sshd service
  12. enable our service
  13. starting our service

for deploy just:
```sh
./deploy
```



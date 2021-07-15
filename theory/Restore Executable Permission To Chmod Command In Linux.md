### Restore Executable Permission To Chmod Command In Linux


you can use ```setfacl``` utility for restore executable permission to chmod

first of all, u need to install ```acl``` package:
```
apt/dnf/yum install acl
```
then
modify ACL of a chmod binary file for user with read and execute permissions:
```
setfacl -m u::rx /usr/bin/chmod
```
restore chmod permissions back to its original ones:
```
chmod +x $(which chmod)
```
remove all ACL entries of chmod. This is optional.
```
setfacl -b /usr/bin/chmod
```

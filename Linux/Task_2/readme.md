# Linux: Working with users' policies. Configuring sudo and root access

## Task 2

#### Ex. 4.1-2 User policies  
Task was to implement the following policies:
 - require password changing every 3 months;

> Context of **/etc/pam.d/common-password** with the required configuration lines:
```
# Password aging controls:
#
#	PASS_MAX_DAYS	Maximum number of days a password may be used.
#	PASS_MIN_DAYS	Minimum number of days allowed between password changes.
#	PASS_WARN_AGE	Number of days warning given before a password expires.
#
PASS_MAX_DAYS	90
PASS_MIN_DAYS	0
PASS_WARN_AGE	7
```
 - user’s password length 8+ characters;
 - it is not allowed to repeat 3 last passwords;
 - number up case, low case, number digit and special chars;

> Context of **/etc/pam.d/common-password** with the required configuration lines:
```
# here are the per-package modules (the "Primary" block)
password	requisite			pam_pwquality.so retry=3 ucredit=-1 dcredit=-1 ocredit=-1 minclass=3
password	[success=1 default=ignore]	pam_unix.so obscure use_authtok try_first_pass sha512 minlen=8 remember=3
```
> Adding a new user:
```
root@vmi624608:~# adduser example
Adding user `example' ...
Adding new group `example' (1003) ...
Adding new user `example' (1003) with group `example' ...
Creating home directory `/home/example' ...
Copying files from `/etc/skel' ...
New password:
BAD PASSWORD: The password contains less than 1 digits
Retype new password:
Sorry, passwords do not match.
New password:
BAD PASSWORD: The password contains less than 1 uppercase letters
Retype new password:
Sorry, passwords do not match.
New password:
BAD PASSWORD: The password contains less than 1 non-alphanumeric characters
Retype new password:
Sorry, passwords do not match.
passwd: Have exhausted maximum number of retries for service
passwd: password unchanged
Try again? [y/N] y
New password:
BAD PASSWORD: The password is shorter than 8 characters
New password:
BAD PASSWORD: The password is the same as the old one
New password:
```
 - ask password changing when the 1st user login;
> The task requires using command **chage** with **-d** (days) argument.
```
root@vmi624608:~# chage -d 0 example
root@vmi624608:~# chage -l example
Last password change                                    : password must be changed
Password expires                                        : password must be changed
Password inactive                                       : password must be changed
Account expires                                         : never
Minimum number of days between password change          : 0
Maximum number of days between password change          : 90
Number of days of warning before password expires       : 7
root@vmi624608:~# su example
You are required to change your password immediately (administrator enforced)
Changing password for example.
Current password:
```
 - deny executing ‘*sudo su -*’ and ‘*sudo -s*’;
> Context of **/etc/sudoers** with the required configuration lines:
```
# User privilege specification
example ALL= !/bin/su, !/bin/su -
```
> Trying to execute command **sudo su**:
```
example@vmi624608:~$ sudo su
[sudo] password for example:
Sorry, user example is not allowed to execute '/usr/bin/su' as root on vmi624608.contaboserver.net.
example@vmi624608:~$
```
 - prevent accidental removal of */var/log/auth.log* (Debian) or */var/log/secure* (RedHat).
 > The task requires using command **chattr** with **+i** (immutable) argument:
```
root@vmi624608:~# lsattr /var/log/auth.log
--------------e----- /var/log/auth.log
root@vmi624608:~# chattr +i /var/log/auth.log
root@vmi624608:~# lsattr /var/log/auth.log
----i---------e----- /var/log/auth.log
```

#### Ex. 1

Create an user who can execute ‘iptables’ with any command line arguments. Let the user do not type
‘sudo iptables’ every time.

> Completing the task with using the **alias** command for the current user:
```
example@vmi624608:~$ alias sipt="sudo iptables"
example@vmi624608:~$ sipt
[sudo] password for steam:
iptables v1.8.4 (legacy): no command specified
Try `iptables -h' or 'iptables --help' for more information.
example@vmi624608:~$ sipt -L
Chain INPUT (policy DROP)
target     prot opt source               destination
ufw-before-logging-input  all  --  anywhere             anywhere
...
```

> If it's necessary to add an alias for all existing users - create the file with the name **00-aliases.sh** in the path */etc/profile.d/* and add the alias command to it:
```
alias sipt="sudo iptables"
```

#### Ex. 2
Grant access to the user to read file /var/log/syslog (Debian) or /var/log/messages (RedHat) without
using SUDO for the permission.

> Adding user to the file owner group:
```
usermod -aG adm example
```

#### Ex. 3
Write a script to automate applying policies from the 1 and 2. 
> Add the used commands into file-example.sh? If yes:

**file_example.sh**
```
echo "alias sipt='sudo iptables'" > /etc/profile.d/00-aliases.sh
usermod -aG adm $1
# where $1 - user, which require access to the file /var/log/syslog
```
# Python: regex

## TASK:
![](https://github.com/RuslanSerdiuk/DevOps_Tasks_and_solutions/blob/Python/Python/Task_3/Task_3.png)


1) IPv4 address (special address: private network, CIDR notation):


- Any IP address - ```(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9]?[0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9]?[0-9]?)``` 

Description: match 3 instances of numbers from 0 t0 255 separated by dot and then match one instance of numbers of 0 to 255 without a dot.

Output: 

<img src ='./screenshots/IPv4all.PNG'> <br />

- Private networks - ```(?:10(?:\.(?:25[0-5]|2[0-4][0-9]|1[0-9]{1,2}|[0-9]{1,2})){3}|(?:(?:172\.(?:1[6-9]|2[0-9]|3[01]))|192\.168)(?:\.(?:25[0-5]|2[0-4][0-9]|1[0-9]{1,2}|[0-9]{1,2})){2})```

Description: match either 10. and 3 instances of numbers from 0 t0 255 separated by dot or 172.16-31 and 2 instances of numbers from 0 t0 255 separated by dot or 192.168 and 2 instances of numbers from 0 t0 255 separated by dot.

Output: 

<img src ='./screenshots/IPv4private.PNG'> <br />

- CIDR notation - ```(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)(?:\/)(?:(?:3[0-2]|[1-2][0-9]|[1-9]))```

Description: match 3 instances of numbers from 0 t0 255 separated by dot and then match one instance of numbers of 0 to 255 without a dot with the subnet mask of /1-32.

Output: 

<img src ='./screenshots/IPv4CIDR.PNG'> <br />

2) IPv6 address (special address: private network, CIDR notation):

- Any IP address - ```(?:(?:[0-9a-fA-F]{1,4}:){7}[0-9a-fA-F]{1,4})```

Description: match any 1 to 4 hex number from 0 to f 7 times in a row separated by colon and then match any 1 to 4 hex number from 0 to f one time. 

Output: 

<img src ='./screenshots/IPv6all.PNG'> <br />

- Private networks - ```(?:(?:fc|fd)[0-9a-fA-F]{1,2}:(?:[0-9a-fA-F]{1,4}:){6}[0-9a-fA-F]{1,4})```

Description: match fc or fd adress followed by 1 or 2 hex numbers followed by 6 hex numbers from 0 to f separated by colon and 1 instance of 1 to 4 hex numbers without a colon at the end of expression. 

Output: 

<img src ='./screenshots/IPv6private.PNG'> <br />

- CIDR notation - ```(?:(?:[0-9a-fA-F]{1,4}:){7}[0-9a-fA-F]{1,4})(?:\/)(?:1[0-2][0-8]|[1-9][0-9]|[1-9])```

Description: match any 1 to 4 hex number from 0 to f 7 times in a row separated by colon and then match any 1 to 4 hex number from 0 to f one time with the subnet mask of /1-128.

Output: 

<img src ='./screenshots/IPv6CIDR.PNG'> <br />

3) IP mask (any length, given length):

- Any length - ```(?:(?:128|192|224|240|248|252|254|255)\.0\.0\.0)|(?:255\.(?:(?:(?:0|128|192|224|240|248|252|254|255)\.0\.0)|(?:255\.(?:(?:(?:0|128|192|224|240|248|252|254|255)\.0)|255\.(?:0|128|192|224|240|248|252|254|255)))))```

Description: match any number from the subnet mask group (128|192|224|240|248|252|254|255) on 4 positions separated by dot. 

Output: 

<img src ='./screenshots/IPmaskany.PNG'> <br />

- Given length - ```(?:255\.){3}0```

Description: match C class (or /24) mask, which is 255.255.255.0

Output: 

<img src ='./screenshots/IPmaskgiven.PNG'> <br />

4) MAC address (format: general, Linux, Windows, Cisco):

- Linux - ```(?:[0-9a-f]{2}:){5}[0-9a-f]{2}```

Description: match 2 hex numbers from 0 to f 5 times in a row separated by colon and then match one instance of hex numbers from 0 to f, both lowecase and uppercase in all cases. 

Output: 

<img src ='./screenshots/MAClinux.PNG'> <br />

- Windows - ```(?:[0-9A-F]{2}-){5}[0-9A-F]{2}```

Description: match 2 hex numbers from 0 to f 5 times in a row separated by dash and then match one instance of hex numbers from 0 to f, only uppercase in all cases. 

Output: 

<img src ='./screenshots/MACwindows.PNG'> <br />

- Cisco/General - ```(?:[0-9a-fA-F]{4}\.){2}[0-9a-fA-F]{4}```

Description: we take Cisco as a general MAC format and it's 4 hex numbers from 0 to f for 2 times separated by dot and then 4 hex numbers from 0 to f without a dot. 

Output: 

<img src ='./screenshots/MACcisco.PNG'> <br />

5) Domain address (only TLD, first DL, second)

- Only TLD (also the first DL) - ```\.[a-z][-a-z0-9]?[-a-z0-9]{1,63}```

Description: we start at a . followed by any letter, digit or a hyphen, but is cannot start with a hyphen or a digit. The length is up to 63 characters. 

Output: 

<img src ='./screenshots/TLD.PNG'> <br />

- Second DL - ```\.[a-z][-a-z0-9]?[-a-z0-9]{1,63}\.[a-z][-a-z0-9]?[-a-z0-9]{1,63}```

Description: with both domains we start at a . followed by any letter, digit or a hyphen, but it cannot start with a hyphen or a digit. The length is up to 63 characters. 

Output: 

<img src ='./screenshots/2LD.PNG'> <br />

6) Email (get login, get domain): 

- Full address - ```(?:[a-z0-9].{2,64})@[a-z0-9][^\s@]{2,253}\.[^\s@]{2,253}```

Description: login part is up to 64 characters in length and it contains letters and digits. Domain part is up to 253 characters and is separted from the login part by "@". 

Output: 

<img src ='./screenshots/Email-full.PNG'> <br />

- Login - ```(?:[a-z0-9].{2,64})@```

Output: 

<img src ='./screenshots/Email-login.PNG'> <br />

- Domain - ```@[a-z0-9][^\s@]{2,253}\.[^\s@]{2,253}```

Output: 

<img src ='./screenshots/Email-domain.PNG'> <br />

7) URI: ```(?:ftp|telnet|ldap|http[s]?)://(?:[a-zA-Z]|[0-9]|[$-_@.&+#]|[!*\(\),]|(?:%[0-9a-fA-F][0-9a-fA-F]))+```

Description: this regular expression matches ftp, telnet, ldap and http URIs. Keyword is followed by "://" and allowed characters.

Output: 

<img src ='./screenshots/URI.PNG'> <br />

8) URL: ```http[s]?://(?:[a-zA-Z]|[0-9]|[$-_@.&+#]|[!*\(\),]|(?:%[0-9a-fA-F][0-9a-fA-F]))+```

Description: this regular expression matches HTTP URLs. Keyword is followed by "://" and allowed characters.

Output: 

<img src ='./screenshots/URL.PNG'> <br />

9) SSH Key (private, public)

- Public - ```(?:ssh-rsa AAAA[0-9A-Za-z+\/]+[=]{0,3}[^@]+@[^@]{2,63})$```

Description: match "ssh-rsa AAAA" followed by letters, digits and '/' and email adress.

Output: 

<img src ='./screenshots/Public-SSH.PNG'> <br />

- Private - ```-----BEGIN OPENSSH PRIVATE KEY-----\n(?:[0-9a-zA-Z\+\/=]{64}(?:\n))*(?:[0-9a-zA-Z\+\/=]{1,63}\n?-----END OPENSSH PRIVATE KEY-----)```

Description: match opening and ending string and the set of characters contained in a private key. 

Output: 

<img src ='./screenshots/Private-SSH.PNG'> <br />

10) Card number: ```(?:4[0-9]{12}(?:[0-9]{3})?|5[1-5][0-9]{14}|3[47][0-9]{13})```

Description: works for both Visa and Mastercard.

Output: 

<img src ='./screenshots/Cards.PNG'> <br />

11) UUID: ```[a-fa-f0-9]{8}-[a-fa-f0-9]{4}-[a-fa-f0-9]{4}-[a-fa-f0-9]{4}-[a-fa-f0-9]{12}```

Description: UUID forms a group of 8-4-4-4-12 hex digits from 0 to f. 

Output: 

<img src ='./screenshots/UUID.PNG'>

# 1) IPv4 address (special address: private network, CIDR notation):

# Any IP address
# (?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9]?[0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9]?[0-9]?)
# Description: match 3 instances of numbers from 0 t0 255 separated by dot and then match one instance of numbers of 0 to 255 without a dot.

# Code
# import re

# testExp = """
# 40.123.22.203
# 76.129.229.94
# 251.175.18.193
# 249.137.229.108
# 999.999.999.999
# abcd
# """
# regexExp = r'(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9]?[0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9]?[0-9]?)'

# result = re.findall(regexExp, testExp)
# print(result)

# Private networks
# (?:10(?:\.(?:25[0-5]|2[0-4][0-9]|1[0-9]{1,2}|[0-9]{1,2})){3}|(?:(?:172\.(?:1[6-9]|2[0-9]|3[01]))|192\.168)(?:\.(?:25[0-5]|2[0-4][0-9]|1[0-9]{1,2}|[0-9]{1,2})){2})
# Description: match either 10. and 3 instances of numbers from 0 t0 255 separated by dot or 172.16-31 and 2 instances of numbers from 0 t0 255 separated by dot or 
# 192.168 and 2 instances of numbers from 0 t0 255 separated by dot.

# Code
# import re

# testExp = """
# 192.168.0.1
# 172.16.32.15
# 101.32.15.2
# 10.0.0.22
# 192.168.2.1
# """
# regexExp = r'(?:10(?:\.(?:25[0-5]|2[0-4][0-9]|1[0-9]{1,2}|[0-9]{1,2})){3}|(?:(?:172\.(?:1[6-9]|2[0-9]|3[01]))|192\.168)(?:\.(?:25[0-5]|2[0-4][0-9]|1[0-9]{1,2}|[0-9]{1,2})){2})'

# result = re.findall(regexExp, testExp)
# print(result)

# CIDR notation
# (?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)(?:\/)(?:(?:3[0-2]|[1-2][0-9]|[1-9]))
# Description: match 3 instances of numbers from 0 t0 255 separated by dot and then match one instance of numbers of 0 to 255 without 
# a dot with the subnet mask of /1-32.

# Code
# import re

# testExp = """
# 40.123.22.203/12
# 76.129.229.94/24
# 76.129.229.95/0
# 251.175.18.193/32
# 251.175.18.163/
# 249.137.229.108/8
# """
# regexExp = r'(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)(?:\/)(?:(?:3[0-2]|[1-2][0-9]|[1-9]))'

# result = re.findall(regexExp, testExp)
# print(result)

# 2) IPv6 address (special address: private network, CIDR notation):
# Any IP address
# (?:(?:[0-9a-fA-F]{1,4}:){7}[0-9a-fA-F]{1,4})
# Description: match any 1 to 4 hex number from 0 to f 7 times in a row separated by colon and then match any 1 to 4 hex number from 0 to f one time. 

# Code
# import re

# testExp = """
# d0ff:308b:e6e8:15d9:a5bf:7a06:557f:2ef7
# 342d:2e2f:39fa:b9ea:9004:6da5:713f:ddda
# 8a51:8399:a210:ab3c:0bf3:47fa:d2fb:e52e
# e63b:d9ce:09db:353d:8740:2d18:c20c
# 342d:2e2f:39fa:b9ea:9004:6da5:713fff:ddda
# """
# regexExp = r'(?:(?:[0-9a-fA-F]{1,4}:){7}[0-9a-fA-F]{1,4})'

# result = re.findall(regexExp, testExp)
# print(result)

# Private networks
# (?:(?:fc|fd)[0-9a-fA-F]{1,2}:(?:[0-9a-fA-F]{1,4}:){6}[0-9a-fA-F]{1,4})
# Description: match fc or fd adress followed by 1 or 2 hex numbers followed by 6 hex numbers from 0 to f separated by colon and 1 instance of 1 to 4 hex numbers 
# without a colon at the end of expression. 

# Code
# import re

# testExp = """
# 8a51:8399:a210:ab3c:0bf3:47fa:d2fb:e52e
# fc2d:2e2f:39fa:b9ea:9004:6da5:713f:ddda
# fd51:8399:a210:ab3c:0bf3:47fa:d2fb:e52e
# fc3b:d9ce:09db:353d:8740:2d18:01bf:c20c
# """
# regexExp = r'(?:(?:fc|fd)[0-9a-fA-F]{1,2}:(?:[0-9a-fA-F]{1,4}:){6}[0-9a-fA-F]{1,4})'

# result = re.findall(regexExp, testExp)
# print(result)

# CIDR notation
# (?:(?:[0-9a-fA-F]{1,4}:){7}[0-9a-fA-F]{1,4})(?:\/)(?:1[0-2][0-8]|[1-9][0-9]|[1-9])
# Description: match any 1 to 4 hex number from 0 to f 7 times in a row separated by colon and then match any 1 to 4 hex number from 0 to f one time 
# with the subnet mask of /1-128.

# Code
# import re

# testExp = """
# d0ff:308b:e6e8:15d9:a5bf:7a06:557f:2ef7/64
# 342d:2e2f:39fa:b9ea:9004:6da5:713f:ddda/
# 8a51:8399:a210:ab3c:0bf3:47fa:d2fb:e52e/0
# e63b:d9ce:09db:353d:8740:2d18:01bf:c20c/128
# """
# regexExp = r'(?:(?:[0-9a-fA-F]{1,4}:){7}[0-9a-fA-F]{1,4})(?:\/)(?:1[0-2][0-8]|[1-9][0-9]|[1-9])'

# result = re.findall(regexExp, testExp)
# print(result)

# 3) IP mask (any length, given length):

# Any length
# (?:(?:128|192|224|240|248|252|254|255)\.0\.0\.0)|(?:255\.(?:(?:(?:0|128|192|224|240|248|252|254|255)\.0\.0)|(?:255\.(?:(?:(?:0|128|192|224|240|248|252|254|255)\.0)|255\.(?:0|128|192|224|240|248|252|254|255)))))
# Description: match any number from the subnet mask group (128|192|224|240|248|252|254|255) on 4 positions separated by dot. 

# Code
# import re

# testExp = """
# 192.0.12.1
# 255.128.0.0
# 255.232.25w2.0
# 255.255.240.0
# """
# regexExp = r'(?:(?:128|192|224|240|248|252|254|255)\.0\.0\.0)|(?:255\.(?:(?:(?:0|128|192|224|240|248|252|254|255)\.0\.0)|(?:255\.(?:(?:(?:0|128|192|224|240|248|252|254|255)\.0)|255\.(?:0|128|192|224|240|248|252|254|255)))))'

# result = re.findall(regexExp, testExp)
# print(result)

# Given length
# (?:255\.){3}0
# Description: match C class (or /24) mask, which is 255.255.255.0

# Code
# import re

# testExp = """
# 192.0.0.0
# 255.128.0.0
# 255.255.255.0
# 255.255.240.0
# """
# regexExp = r'(?:255\.){3}0'

# result = re.findall(regexExp, testExp)
# print(result)

# 4) MAC address (format: general, Linux, Windows, Cisco):

# Linux
# (?:[0-9a-f]{2}:){5}[0-9a-f]{2}
# Description: match 2 hex numbers from 0 to f 5 times in a row separated by colon and 
# then match one instance of hex numbers from 0 to f, both lowecase and uppercase in all cases. 

# Code
# import re

# testExp = """
# b5:36:d8:54:c7:1e
# 61:04:79:e2:c9:c9
# 60-3A-E6-23-72-79
# 6a:ce:41:49:cc:b6
# """
# regexExp = r'(?:[0-9a-f]{2}:){5}[0-9a-f]{2}'

# result = re.findall(regexExp, testExp)
# print(result)

# Windows
# (?:[0-9A-F]{2}-){5}[0-9A-F]{2}
# Description: match 2 hex numbers from 0 to f 5 times in a row separated by dash and then match 
# one instance of hex numbers from 0 to f, only uppercase in all cases. 

# Code
# import re

# testExp = """
# 49-E4-AC-A4-7F-EA
# 61:04:79:e2:c9:c9
# FC-37-AB-30-51-0C
# 31-FE-FC-D6-5F-A2
# """
# regexExp = r'(?:[0-9A-F]{2}-){5}[0-9A-F]{2}'

# result = re.findall(regexExp, testExp)
# print(result)

# Cisco/General
# (?:[0-9a-fA-F]{4}\.){2}[0-9a-fA-F]{4}
# Description: we take Cisco as a general MAC format and it's 4 hex numbers from 0 to f for 2 times separated by dot and then 4 hex numbers from 0 to f without a dot. 

# Code
# import re

# testExp = """
# 49E4.ACA4.7FEA
# 603A.E623.7279
# 61:04:79:e2:c9:c9
# 31FE.FCD6.5F
# """
# regexExp = r'(?:[0-9a-fA-F]{4}\.){2}[0-9a-fA-F]{4}'

# result = re.findall(regexExp, testExp)
# print(result)

# 5) Domain address (only TLD, first DL, second)

# Only TLD (also the first DL)
# \.[a-z][-a-z0-9]?[-a-z0-9]{1,63}
# Description: we start at a . followed by any letter, digit or a hyphen, but is cannot start with a hyphen or a digit. The length is up to 63 characters.

# Code
# import re

# testExp = """
# commentpicker.ua
# wikipedia.org
# wikipedia.-org
# browserling.1com
# """
# regexExp = r'\.[a-z][-a-z0-9]?[-a-z0-9]{1,63}'

# result = re.findall(regexExp, testExp)
# print(result)

# Second DL
# \.[a-z][-a-z0-9]?[-a-z0-9]{1,63}\.[a-z][-a-z0-9]?[-a-z0-9]{1,63}
# Description: with both domains we start at a . followed by any letter, digit or a hyphen, but it cannot start with a hyphen or a digit. 
# The length is up to 63 characters. 

# Code
# import re

# testExp = """
# commentpicker.c.ua
# wikipedia.22org.pr
# browserling.com.fr
# """
# regexExp = r'\.[a-z][-a-z0-9]?[-a-z0-9]{1,63}\.[a-z][-a-z0-9]?[-a-z0-9]{1,63}'

# result = re.findall(regexExp, testExp)
# print(result)

# 6) Email (get login, get domain):
# Full address
# (?:[a-z0-9].{2,64})@[a-z0-9][^\s@]{2,253}\.[^\s@]{2,253}
# Description: login part is up to 64 characters in length and it contains letters and digits. 
# Domain part is up to 253 characters and is separted from the login part by "@". 

# Code
# import re

# testExp = """
# support@google.com
# support@apple.com
# hello@!!quiz.net
# buy@here.ua
# """
# regexExp = r'(?:[a-z0-9].{2,64})@[a-z0-9][^\s@]{2,253}\.[^\s@]{2,253}'

# result = re.findall(regexExp, testExp)
# print(result)

# Login
# (?:[a-z0-9].{2,64})@

# Code
# import re

# testExp = """
# support@google.com
# random text
# hello@quiz.net
# buy@here.ua
# """
# regexExp = r'(?:[a-z0-9].{2,64})@'

# result = re.findall(regexExp, testExp)
# print(result)

# Domain
# @[a-z0-9][^\s@]{2,253}\.[^\s@]{2,253}

# Code
# import re

# testExp = """
# support@google.com
# support@apple.com
# 1314234544
# buy@here.ua
# """
# regexExp = r'@[a-z0-9][^\s@]{2,253}\.[^\s@]{2,253}'

# result = re.findall(regexExp, testExp)
# print(result)

# 7) URI:
# (?:ftp|telnet|ldap|http[s]?)://(?:[a-zA-Z]|[0-9]|[$-_@.&+#]|[!*\(\),]|(?:%[0-9a-fA-F][0-9a-fA-F]))+
# Description: this regular expression matches ftp, telnet, ldap and http URIs. Keyword is followed by "://" and allowed characters.

# Code
# import re

# testExp = """
# ldap://[2001:db8::7]/c=GB?objectClass?one
# https://commentpicker.com/ip-address-generator.php
# telnet://192.0.2.16:80/
# Not URI 123
# ftp://billgates:moremoney@files.microsoft.com/special/secretplans
# """
# regexExp = r'(?:ftp|telnet|ldap|http[s]?)://(?:[a-zA-Z]|[0-9]|[$-_@.&+#]|[!*\(\),]|(?:%[0-9a-fA-F][0-9a-fA-F]))+'

# result = re.findall(regexExp, testExp)
# print(result)

# 8) URL:
# http[s]?://(?:[a-zA-Z]|[0-9]|[$-_@.&+#]|[!*\(\),]|(?:%[0-9a-fA-F][0-9a-fA-F]))+
# Description: this regular expression matches HTTP URLs. Keyword is followed by "://" and allowed characters.

# Code
# import re

# testExp = """
# ldap://[2001:db8::7]/c=GB?objectClass?one
# https://commentpicker.com/ip-address-generator.php
# http://git-scm.com/
# telnet://192.0.2.16:80/
# ftp://billgates:moremoney@files.microsoft.com/special/secretplans
# """
# regexExp = r'http[s]?://(?:[a-zA-Z]|[0-9]|[$-_@.&+#]|[!*\(\),]|(?:%[0-9a-fA-F][0-9a-fA-F]))+'

# result = re.findall(regexExp, testExp)
# print(result)

# 9) SSH Key (private, public): 
#Public
# (?:ssh-rsa AAAA[0-9A-Za-z+\/]+[=]{0,3}[^@]+@[^@]{2,63})$
# Description: match "ssh-rsa AAAA" followed by letters, digits and '/' and email adress.

# Code
# import re

# testExp = """
# ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEAklOUpkDHrfHY17SbrmTIpNLTGK9Tjom/BWDSU
# GPl+nafzlHDTYW7hdI4yZ5ew18JH4JW9jbhUFrviQzM7xlELEVf4h9lFX5QVkbPppSwg0cda3
# Pbv7kOdJ/MTyBlWXFCR+HAo3FXRitBqxiX1nKhXpHAZsMciLq8V6RjsNAQwdsdMFvSlVK/7XA
# t3FaoJoAsncM1Q9x5+3V0Ww68/eIFmb1zuUFljQJKprrX88XypNDvjYNby6vw/Pb0rwert/En
# mZ+AW4OZPnTPI89ZPmVMLuayrD2cE86Z/il8b+gw3r3+1nKatmIkjn2so1d01QraTlMqVSsbx
# NrRFi9wrf+M7Q== schacon@mylaptop.local

# Pl+nafzlHDTYW7hdI4yZ5ew18JH4JW9jbhUFrviQzM7xlELEVf4h9lFX5QVkbPppSwg0cda3
# Pbv7kOdJ/MTyBlWXFCR+HAo3FXRitBqxiX1nKhXpHAZsMciLq8V6RjsNAQwdsdMFvSlVK/7XA
# t3FaoJoAsncM1Q9x5+3V0Ww68/eIFmb1zuUFljQJKprrX88Xyp

# ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEAklOUpkDHrfHY17SbrmTIpNLTGK9Tjom/BWDSU
# GPl+nafzlHDTYW7hdI4yZ5ew18JH4JW9jbhUFrviQzM7xlELEVf4h9lFX5QVkbPppSwg0cda3
# Pbv7kOdJ/MTyBlWXFCR+HAo3FXRitBqxiX1nKhXpHAZsMciLq8V6RjsNAQwdsdMFvSlVK/7XA
# t3FaoJoAsncM1Q9x5+3V0Ww68/eIFmb1zuUFljQJKprrX88XypNDvjYNby6vw/Pb0rwert/En
# mZ+AW4OZPnTPI89ZPmVMLuayrD2cE86Z/il8b+gw3r3+1nKatmIkjn2so1d01QraTlMqVSsbx
# NrRFi9wrf+M7Q== example@gmail.com 
# """
# spt = testExp.split('\n\n')

# endlist = []
# for line in spt:
    
#     regexExp = r'(?:ssh-rsa AAAA[0-9A-Za-z+\/]+[=]{0,3}[^@]+@[^@]{2,63})$'
#     result = re.findall(regexExp, line)
#     if result != []:
#      endlist.append(result)

# print(endlist)

#Private
# -----BEGIN OPENSSH PRIVATE KEY-----\n(?:[0-9a-zA-Z\+\/=]{64}(?:\n))*(?:[0-9a-zA-Z\+\/=]{1,63}\n?-----END OPENSSH PRIVATE KEY-----)
# Description: match opening and ending string and the set of characters contained in a private key. 

# Code
# import re

# testExp = """
# -----BEGIN OPENSSH PRIVATE KEY-----
# AAABAQCK2q6c4W4OmTQ7hGgGwwczPvusDEpHQDfMKqCHKF/gJrqJ9aTBhNL0d9qJ
# owbrr+4+k3xNjvfmdf5nLO+UOWXLbvU0jAR0dFhlG9N3QZXV6xWRbdxRnpD/Jfy2
# tD9bkuBsru9fM3taOZWbQawxWGVqNSaAwEiPt/OtmoYNIOuDP0ZEcFmDLFGZrUmJ
# /f/UdcbTS06N8DpkfDZMkb3GN1tQ3rFzBgE9W/B9pJw/1dn116qQX2qAZ7E7UKB4
# VQlTdgO94fVDEKqFZ8CEPrFdJe5RGoVbZ80QDp9ehfLS8fF8MoAA5lRZypq8OIcy
# lXLyd0KJWCBobI9vHHM7KdDG2scBAAAAgQD0BonmGAVxUTgdtEhj7aEyWNXlEdZM
# 48nsAZ0iQpW1cTKx+6S+jME+V9raOm4ov8LKjRH8xC1EhAG7lmnR3QJtZBlvkFyt
# BNuhQ4rQGhmRIp7MAEz0hOOz/mRpBe9/9AbeNTMMkB3HIclOjYx//L7d7FBAnBli
# oAC2MXhNyZXUjQAAAIEA6izyPxCzGCxHUKG+U/CFc+P4UkbB8/ZkAql8vuS3jqq+
# wyoT5H6sheFnACcItdFWd4cE8QP+0wdLTvI/RBiz8HF4uONLt4RRjbkuIjtTI/IB
# u6yYRKo96pvDWo+9dgUxZy/TzDAclhr4mJXVjEygrfAx7kiFR4CyDEtKQncVrMEA
# AACAd+Gy5vlWq8z0AopR7+P9I+yerpBuiFGPLDlmGG5zBXAcmtZ8Lvhlq4S/eXzw
# ldyoHzTOxYHlt2G3rpoQxHwqFMzLgPMumSjP/57tg8+3kQ46J9nEI6iqRzDLrsLJ
# eLJisSstJYTbOYhurS82Z38t1Am1AnbvVBeB4kgWQ52fHM8=
# -----END OPENSSH PRIVATE KEY-----

# -----BEGIN OPEfwer4wt411`
# AAABAQCK2q6c4W4OmTQ7hGgGwwczPvusDEpHQDfMKqCHKF/gJrqJ9aTBhNL0d9qJ
# owbrr+4+k3xNjvfmdf5nLO+UOWXLbvU0jAR0dFhlG9N3QZXV6xWRbdxRnpD/Jfy2
# tD9bkuBsru9fM3taOZWbQawxWGVqNSaAwEiPt/OtmoYNIOuDP0ZEcFmDLFGZrUmJ
# BNuhQ4rQGhmRIp7MAEz0hOOz/mRpBe9/9AbeNTMMkB3HIclOjYx//L7d7FBAnBli
# oAC2MXhNyZXUjQAAAIEA6izyPxCzGCxHUKG+U/CFc+P4UkbB8/ZkAql8vuS3jqq+
# wyoT5H6sheFnACcItdFWd4cE8QP+0wdLTvI/RBiz8HF4uONLt4RRjbkuIjtTI/IB
# /f/UdcbTS06N8DpkfDZMkb3GN1tQ3rFzBgE9W/B9pJw/1dn116qQX2qAZ7E7UKB4
# VQlTdgO94fVDEKqFZ8CEPrFdJe5RGoVbZ80QDp9ehfLS8fF8MoAA5lRZypq8OIcy
# lXLyd0KJWCBobI9vHHM7KdDG2scBAAAAgQD0BonmGAVxUTgdtEhj7aEyWNXlEdZM
# 48nsAZ0iQpW1cTKx+6S+jME+V9raOm4ov8LKjRH8xC1EhAG7lmnR3QJtZBlvkFyt
# u6yYRKo96pvDWo+9dgUxZy/TzDAclhr4mJXVjEygrfAx7kiFR4CyDEtKQncVrMEA
# AACAd+Gy5vlWq8z0AopR7+P9I+yerpBuiFGPLDlmGG5zBXAcmtZ8Lvhlq4S/eXzw
# ldyoHzTOxYHlt2G3rpoQxHwqFMzLgPMumSjP/57tg8+3kQ46J9nEI6iqRzDLrsLJ
# eLJisSstJYTbOYhurS82Z38t1Am1AnbvVBeB4kgWQ52fHM8=
# -----END OPENSSH PRIVATE KEY-----
# """
# regexExp = r'-----BEGIN OPENSSH PRIVATE KEY-----\n(?:[0-9a-zA-Z\+\/=]{64}(?:\n))*(?:[0-9a-zA-Z\+\/=]{1,63}\n?-----END OPENSSH PRIVATE KEY-----)'

# result = re.findall(regexExp, testExp)
# print(result)

# 10) Card number:
# (?:4[0-9]{12}(?:[0-9]{3})?|5[1-5][0-9]{14}|3[47][0-9]{13})
# Description: works for both Visa and Mastercard.

# Code
# import re

# testExp = """
# 4608517851486788
# 6916376178553888
# 5366396225230928
# 8231179920038710
# """
# regexExp = r'(?:4[0-9]{12}(?:[0-9]{3})?|5[1-5][0-9]{14}|3[47][0-9]{13})'

# result = re.findall(regexExp, testExp)
# print(result)

# 11) UUID:
# [a-fa-f0-9]{8}-[a-fa-f0-9]{4}-[a-fa-f0-9]{4}-[a-fa-f0-9]{4}-[a-fa-f0-9]{12}
# Description: UUID forms a group of 8-4-4-4-12 hex digits from 0 to f. 

# Code
# import re

# testExp = """
# 633e64e2-3523-4f62-92ff-12db48d4fc01
# 10f46a65-e119--482e-8521-5af0b783cfd9
# 052356f2-c869-4ae0-98c8-cb589ce5dbc1
# fa4b7de6-189640dc-85fd-995d44f5c3c1
# """
# regexExp = r'[a-fa-f0-9]{8}-[a-fa-f0-9]{4}-[a-fa-f0-9]{4}-[a-fa-f0-9]{4}-[a-fa-f0-9]{12}'

# result = re.findall(regexExp, testExp)
# print(result)

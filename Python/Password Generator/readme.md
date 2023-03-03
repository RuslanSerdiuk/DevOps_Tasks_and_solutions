# Python: Password Generator
## TASK:
![](https://github.com/RuslanSerdiuk/DevOps_Tasks_and_solutions/blob/Python/Python/Task_1/Task_1.png)

### Default mode
By running the script without any arguments, we will get a ten-character password, that contains all listed tokens.
```
$ py .\genpasswd.py
7(W=#6qsHz
```

### Commands
**Help** option
```
$ python gen_passwd.py -h
usage: gen_passwd.py [-h] [-l] [-t] [-f] [-c] [-v]

optional arguments:
  -h, --help        show this help message and exit
  -l , --length     length of password
  -t , --template   template of password
  -f , --file
  -c , --count      number of passwords to generate
  -v, --verbose     verbose mode

```

Let's get 10 passwords with count **option**
```
$ py .\genpasswd.py -c 10         
jsv6C3Gz;R
-{QhNN12Ig
8Vuhu2H<x-
=x8J2~4<1s
E8D-=vK1@&
f9/1ChdL@g
h~17-s@u1^
2^J\mP8a'X
VU]n5!P-;H
3z.-8G@78p

```

Let's specify the **length** of password, 100 symbols will be enough :smile:
```
$ py .\genpasswd.py -l 100
9y~6K+:KX6t+LCALrOKF:cl3YIMeVcJsVVde7\3x89yWF.%~0[z1AT2R4=,I>w8unEfdw054*=26Q15hix.6@NsTATa5z,7MPu5x
```

We also can use ours **template** e.g. generate password which contains only of upper case letters
```
$ py .\genpasswd.py -t A15%
FNAZHPPQQSIQHKX
```

Also, we can use **[ set ]** in ours trunk_template
```
$ py .\genpasswd.py -t A15%[d%a%]10%
IXYGNRAKNNINAJAddj4ec3qp7
```

If you want to use templates from the **file**, specify -f option and filename
```
$ py .\genpasswd.py -f test.txt
PVE8-hv
4714055343
;~]&?_?02@95vkojgf
HDQ19$
```
If you need more information use **verbose** mode
```
$ py .\genpasswd.py -v -c 3
4&1Ockn?/,
91v-J^f7JY
7.2n-PEB\.
```
And take a look to `log.log` file
```
2021-12-23 16:11:41.441 - Starting password generating process...
2021-12-23 16:11:41.441 - Cutting tokens
2021-12-23 16:11:41.441 - Tokens: [A%a%d%p%-%@%]10
2021-12-23 16:11:41.442 - Starting password generating process...
2021-12-23 16:11:41.442 - Cutting tokens
2021-12-23 16:11:41.442 - Tokens: [A%a%d%p%-%@%]10
2021-12-23 16:11:41.442 - Starting password generating process...
2021-12-23 16:11:41.442 - Cutting tokens
2021-12-23 16:11:41.442 - Tokens: [A%a%d%p%-%@%]10
```

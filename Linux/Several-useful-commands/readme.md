# Linux: several useful commands

#### Task 1
Найти все системные группы и получить только их уникальные имена и id. Сохранить в файл
```
$ cat /etc/group | grep -Po "\A([A-Za-z_\-])+|[0-9]*" > /home/user/group_id
```
Odd lines - group name, even lines - group id.

#### Task 2
Найти все файлы и директории, который имеют права для доступа соответствующих user и group
```
$ ls -l | sudo grep -Pro "\Adrwxrwx" /
```

#### Task 3
Найти все скрипты в указанной директории и ее поддиректориях
```
$ ls -a | sudo grep -Pro "\.sh|\.py|\.exe" ./
```

#### Task 4
Выполнить поиск файлов скриптов из-под определенного пользователя
```
$find -user user | sudo grep -Pro "\.sh|\.py|\.exe" ./

$ su -u user | ls -l | sudo grep -Pro "\.sh|\.py|\.exe" ./
```

#### Task 5
Выполнить рекурсивный поиск слов или фразы для определенного типа файлов
```
$ grep -wrn "Task" ./
```
Grep word "Task" in this directory, and its subdirectories.

#### Task 6
Найти дубликаты файлов в заданных каталогах. Вначале сравнивать по размеру, затем по варианту (выбрать хешь функцию: CRC32, MD5, SHA-1, sha224sum). Результат должен быть отсортирован по имени файла
```
$ find -name '*.py' | xargs grep "Task"
```

#### Task 7
Найти по имени файла и его пути все символьные ссылки на него.
```
$ find -L /path/where/search/sumboliclink -samefile /path/to/file
```
Also you can use `ls -i` to find inode of the file. And use `find . -follow -inum $file inode`.

#### Task 8
Найти по имени файла и его пути все жесткие ссылки на него.
```
$ find /path/where/search/hardlink -samefile /path/to/file
```

#### Task 9
Имеется только inode файла найти все его имена.
```
$ find /path/where/search/ -inum <inode>

$ find /home/user -inum 6947895
/home/user/diplom
/home/user/DIPLOM
```

#### Task 10
Имеется только inode файла найти все его имена. Учтите, что может быть примонтированно несколько разделов
```
$ find . -inum <inode>
```

#### Task 11
Корректно удалить файл с учетом возможности существования символьных или жестких ссылок
```
find /home/user -inum <inod> -exec rm -f {} \;
```

#### Task 12
Рекурсивно изменить права доступа к файлам (задана маска файла) в заданной директории
```
$ chmod -R <mode> <directory>
$ ls -li cli_test/
total 12
7216500 drwxr-xr-x 2 user user 4096 Dec 22 19:20 a
7216502 drwxr-xr-x 2 user user 4096 Dec 22 19:20 b
7216530 drwxr-xr-x 2 user user 4096 Dec 22 19:20 c
$ chmod -R g+w cli_test/
$ ls -li cli_test/
total 12
7216500 drwxrwxr-x 2 user user 4096 Dec 22 19:20 a
7216502 drwxrwxr-x 2 user user 4096 Dec 22 19:20 b
7216530 drwxrwxr-x 2 user user 4096 Dec 22 19:20 c

```

#### Task 13
* Сравнить рекурсивно две директории и отобразить только отличающиеся файлы. * (вывести
до 2 строки и после 3 строки относительно строки в которой найдено отличие).
```
diff -aqr /home/ubuntu/sub6/sub6_1 /home/ubuntu/sub6/sub6_2
```

#### Task 14
Получить MAC-адреса сетевых интерфейсов
```
ip a | grep ether | grep -oE "\w{2}:\w{2}:\w{2}:\w{2}:\w{2}:\w{2}[^ff:ff:ff:ff:ff:ff]"
```

#### Task 15
Вывести список пользователей, авторизованных в системе на текущий момент
```
who
```

#### Task 16
Вывести список активных сетевых соединений в виде таблицы: тип состояния соединения и их
количество
```
netstat -tunp
```

#### Task 17
Переназначить существующую символьную ссылку.
```
mv -T <newlink> <linkname>
```

#### Task 18
Имеется список файлов с относительным путем и путем к каталогу, в котором должна храниться символьная ссылка на файл. Создать символьные ссылки на эти файлы
```
ln -s /home/ubuntu/sub6/sub6_1/* /home/ubuntu/sub6/sub6_2
```

#### Task 19
Скопировать директорию с учетом, что в ней существуют как прямые так относительные символьные ссылки на файлы и директории. Предполагается, что копирование выполняется for backup on a removable storage. (сделать в двух вариантах, без rsync и с rsync) Скопировать директорию с учетом, что в ней существуют прямые символьные относительные символьные ссылки
```
$ rsync -ah /path/to/copy /copied/path
$ rsync -ah /home/user/Desktop /home/user/Desk_copy

```

#### Task 20
Скопировать директорию с учетом, что в ней существуют прямые символьные относительные
символьные ссылки
```
cp -rp sub20 sub20_11
```

#### Task 21
Скопировать все файлы и директории из указанной директории в новое расположение с сохранением атрибутов и прав
```
$ cp -pr ~/* ~/folder_to_copy
$ cp -pr /home/user/cli_test/* /home/user/Desktop
```

#### Task 22
В директории проекта преобразовать все относительные ссылки в прямые.
```
$ find -type l -exec bash -c 'ln -f "$(readlink -m "$0")" "$0"' {} \;
```

#### Task 23
В директории проекта преобразовать все прямые ссылки в относительные для директории проекта.
```
$ find -type f -links +1 -exec bash -c 'ln -s -f "$(readlink -m "$0")" "$0"' {} \;
```

#### Task 24
В указанной директории найти все сломанные ссылки и удалить их.
```
$ find . -xtype l -exec bash -c 'rm "$(readlink -m "$0")" "$0"' {} \;
```

#### Task 25
Распаковать из архива tar, gz, bz2, lz, lzma, xz, Z определенный каталог/файл в указанное место.
```
$ tar -xvjf archive.tar.bz2 "file1" -C /home/user/Desktop/Archieve # bz2
# tar xvf archive.tar # tar
$ tar -xvJf archive.tar.xz  #  xz
$ tar --lzma -xvf archive.tar.lzma #lzma
$ tar xvzf archive.tar.gz #gz
$ uncompress archive.Z #Z
```

#### Task 26
Упаковать структуру директорию с файлами с сохранением всех прав и атрибутов
```
$ tar --same-owner -xvf file.tar
```
By default, tar will preserve file permissions and ownership when creating the archive.

#### Task 27
Рекурсивно скопировать структуру каталогов из указанной директории. (без файлов)
```
$ find . -type d -exec mkdir -p /path/to/copy/directory/tree/{} \;
```

#### Task 28
Вывести список всех пользователей системы (только имена) по алфавиту
```
$ compgen -u | sort
```


#### Task 29
Вывести список всех системных пользователей системы отсортированных по id, в формате:
login id
```
cat /etc/passwd | cut -d":" -f 1 && cat /etc/passwd | cut -d":" -f 3
```


#### Task 30
Вывести список всех пользователей системы (только имена) отсортированные по id в обратном порядке
```
cat /etc/passwd | cut -d : -f 1,3 | sort -t ":" -nk2 | egrep -x "[_*a-z0-9-]*:[0-9]{1,3}" | sort -t ":" -nrk2 | cut -d : -f 1
```

#### Task 31
Вывести всех пользователей, которые не имеют право авторизовываться или не имеют право авторизовываться в системе. (две команды)
```
a) - cat /etc/passwd | cut -d : -f 1,7 | egrep "[a-z]*:/bin/[a-z]*" <br>
b) - cat /etc/passwd | cut -d : -f 1,7 | egrep -x "[-_a-z0-9]*:/usr/sbin/nologin"
```

#### Task 32
Вывести всех пользователей, которые (имеют/не имеют) терминала (bash, sh, zsh and etc.) (две команды)
```
a) - cat /etc/passwd | cut -d : -f 1,7 | egrep -x "[a-z]*:/bin/bash|sh|zsh" <br>
b) - cat /etc/passwd | cut -d : -f 1,7 | egrep -x "[-_a-z0-9]*:/usr/sbin/nologin"
```

#### Task 33
Со страницы из интернета закачать все ссылки на ресурсы href, которые на странице.
a) Использовать curl и wget. Закачивать параллельно.
b) Дать рекомендации по использованию.
```
wget -rE https://site.com
```

#### Task 34
Остановить процессы, которые работают больше 5 дней.
a) использовать killall;
b) команду ps / killall не использовать.
```
killall -o 5d -r '.*'
```

#### Task 35
Имеется директория, в которой, существуют папки и файлы (*.txt & *.jpeg). Файлы *.txt и *.jpeg
однозначно связаны между собой по префиксу имени. Файлы могут находиться в различном
месте данной директории. Нужно удалить все *.jpeg для которых не существует файла *.txt.
```
rm -r $(find . -type f -exec basename {} \; | cut -d. -f1 | sort | uniq -u).*
```

#### Task 36
Find your IP address using the command line
```
ifconfig -a | grep -oE "inet\s([0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3})" | cut -c 6- > ips_list
```

#### Task 37
Получить все ip-адресса из текстового файла
```
grep -oE "([0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3})" ips_list
```

#### Task 38
Найти все активные хосты в:
- заданной сети,
- списке IP (hosts-server.txt)
используя/не используя nMAP;
```
cat hosts-server.txt | xargs nmap -Ps
```

#### Task 39
Используя результат таска 36. Получить ip поднятых хостов
```
hostname -I | nmap -Ps
```

#### Task 40
Получить все поддомены из SSL сертификата.
```
nmap -p 443 --script ssl-cert google.com 2>/dev/null | grep -Po ":[*]{1,}(\.[a-z0-9]{1,}){1,}" | grep -Po "(\.[a-z0-9]{1,}){1,}"
```

#### Task 41
Достать из файла с переменными только названия этих переменных (предположим, что имя каждой переменной идет в самом начале строки).
```
cat <your_file> | awk '{print$1}' > /File_with_your_variables.txt

cat tag_Role_notification-backend-service-ci.yml | awk '{print $1}' > \Variables_test_ci.txt
```
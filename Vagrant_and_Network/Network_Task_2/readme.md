## Network Task 2. HTTP&curl. Working with GitLab API

1. Найти в интернете 8 различных status code HTTP. В запросе и ответе должно содержаться не
менее 5 header’s атрибутов.

```
1)
Request Method: GET
Status Code: 302 

RESPONSE
content-length: 0
date: Thu, 13 Jan 2022 12:26:51 GMT
linkedin-action: 1
location: https://p.adsymptotic.com/d/px/?_pid=16218&_psign=0aa5badf92527f7732e22463d6fa4dbc&coopa=0&gdpr=0&gdpr_consent=&_puuid=ddba0b90-0f59-4700-b0b1-cc3172c92031&_umid=6b39fa878cfbfcfb1f4317c8e8b5b95d69d75f0ea068486dad2e4bcc653eae19
set-cookie: li_sugr=ddba0b90-0f59-4700-b0b1-cc3172c92031; Max-Age=7776000; Expires=Wed, 13 Apr 2022 12:26:52 GMT; SameSite=None; Path=/; Domain=.linkedin.com; Secure
x-cache: CONFIG_NOCACHE

REQUEST
:authority: px.ads.linkedin.com
:method: GET
:path: /collect?v=2&fmt=js&pid=846204&time=1642076812288&url=https%3A%2F%2Fumbraco.com%2Fknowledge-base%2Fhttp-status-codes%2F
:scheme: https
accept: image/avif,image/webp,image/apng,image/svg+xml,image/*,*/*;q=0.8

2) 
Request Method: GET
Status Code: 200 

RESPONSE
access-control-allow-headers: accept, accept-langauge, content-language, content-type, fa-kit-token
access-control-allow-methods: GET, OPTIONS
access-control-allow-origin: *
access-control-max-age: 3000
cache-control: max-age=60, public, must-revalidate

REQUEST
:authority: kit.fontawesome.com
:method: GET
:path: /124f9865ce.js
:scheme: https
accept: */*

3)
Request Method: POST
Status Code: 204 

RESPONSE
alt-svc: h3=":443"; ma=2592000,h3-29=":443"; ma=2592000,h3-Q050=":443"; ma=2592000,h3-Q046=":443"; ma=2592000,h3-Q043=":443"; ma=2592000,quic=":443"; ma=2592000; v="46,43"
bfcache-opt-in: unload
content-length: 0
content-type: text/html; charset=UTF-8
date: Thu, 13 Jan 2022 12:47:46 GMT

REQUEST
:authority: www.google.com
:method: POST
:path: /gen_204?s=web&t=aft&atyp=csi&ei=cR_gYYXRHIuUkwWD1Jv4AQ&rt=wsrt.115,aft.612,frt.597,sct.595&frtp=657&wh=937&imn=3&ima=0&imad=0&aftp=-1&r=1&bl=4JUY
:scheme: https
accept: */*

4) 
Request Method: GET
Status Code: 301 

RESPONSE
cache-control: max-age=21600
content-length: 241
content-security-policy: upgrade-insecure-requests
content-type: text/html; charset=iso-8859-1
date: Thu, 13 Jan 2022 12:55:23 GMT

REQUEST
:authority: www.w3.org
:method: GET
:path: /Icons/WWW/w3c_home
:scheme: https
accept: image/avif,image/webp,image/apng,image/s

5)
Request Method: GET
Status Code: 403 
content-type: application/xml
date: Thu, 13 Jan 2022 13:04:24 GMT
server: AmazonS3
via: 1.1 d2f47ea7c79de35229ffbfc6942082c0.cloudfront.net (CloudFront)
x-amz-cf-id: j-x-HKKQ-WTtyF1knDVjHv7qrNyUdoB3-sEUEcm6ZUutk8TFBKk_zA==

RESPONSE
content-type: application/xml
date: Thu, 13 Jan 2022 13:04:24 GMT
server: AmazonS3
via: 1.1 d2f47ea7c79de35229ffbfc6942082c0.cloudfront.net (CloudFront)
x-amz-cf-id: j-x-HKKQ-WTtyF1knDVjHv7qrNyUdoB3-sEUEcm6ZUutk8TFBKk_zA==

REQUEST
:authority: www.restapitutorial.com
:method: GET
:path: /favicon.ico
:scheme: https
accept: image/avif,image/webp,image/apng,image/s

6) 
Request Method: GET
Status Code: 404 

RESPONSE
accept-ranges: bytes
age: 28920
cache-control: max-age=604800
content-encoding: gzip
content-length: 648

REQUEST
:authority: example.com
:method: GET
:path: /favicon.ico
:scheme: https
accept: image/avif,image/webp,image/apng,image/s

7)

Request Method: GET
Status Code: 304

RESPONSE
accept-ranges: bytes
age: 534933
cache-control: max-age=604800
date: Thu, 13 Jan 2022 13:07:59 GMT
etag: "3147526947"

REQUEST
:authority: example.com
:method: GET
:path: /
:scheme: https
accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9

8)
Request Method: GET
Status Code: 101 Switching Protocols

RESPONSE
Connection: upgrade
Date: Thu, 13 Jan 2022 13:17:49 GMT
Sec-WebSocket-Accept: Y/achak14WKXs9WypWeNkC2ojIs=
Server: nginx
Upgrade: websocket

REQUEST
Accept-Encoding: gzip, deflate, br
Accept-Language: en-US,en;q=0.9
Cache-Control: no-cache
Connection: Upgrade
Host: nexus-websocket-a.intercom.io
```

2. Описать назначение всех атрибутов в client request and server response. На примере одного из
HTTP request/response описать все header’s атрибуты.
```
Request Method: GET
Status Code: 200 

RESPONSE
access-control-allow-headers: accept, accept-langauge, content-language, content-type, fa-kit-token
access-control-allow-methods: GET, OPTIONS
access-control-allow-origin: *
access-control-max-age: 3000
cache-control: max-age=60, public, must-revalidate
```

Заголовок ответа **Access-Control-Allow-Headers** используется в ответ на preflight request (en-US), чтобы указать, какие заголовки HTTP могут использоваться во время фактического запроса.

**Access-Control-Allow-Methods** это заголовок ответа, который определяет метод или методы доступа к ресурсам.

Заголовок ответа **Access-Control-Allow-Origin** показывает, может ли ответ сервера быть доступен коду, отправляющему запрос с данного источника origin.

Заголовок ответа сервера **Access-Control-Max-Age** сообщает браузеру насколько предзапрос (эта информация содержится в заголовках Access-Control-Allow-Methods и Access-Control-Allow-Headers) может быть кеширован и опущен при запросах к серверу.

Общий заголовок **Cache-Control** используется для задания инструкций кеширования как для запросов, так и для ответов. Инструкции кеширования однонаправленные: заданная инструкция в запросе не подразумевает, что такая же инструкция будет указана в ответе.

```
REQUEST
:authority: kit.fontawesome.com
:method: GET
:path: /124f9865ce.js
:scheme: https
accept: */*
```

3. Найти еще 7 различных status code. Выполнять только после выполнения задания 1. 

102	Processing

206	Partial Content

307	Temporary Redirect

401	Unauthorized

414	URI Too Long

500	Internal Server Error

502	Bad Gateway

4. Произвести фильтрацию трафика протокола HTTP с помощью tcpdump. Написать два фильтра:

a. фильтровать по методам протокола HTTP.
```
GET:
sudo tcpdump -i eth0 -s 0 -A 'tcp[((tcp[12:1] & 0xf0) >> 2):4] = 0x47455420'
POST:
sudo tcpdump -i eth0 -s 0 -A 'tcp[((tcp[12:1] & 0xf0) >> 2):4] = 0x504F5354'
```
b. фильтровать по методу и header’s атрибуту в response протокола HTTP

c. фильтровать по методу и header’s атрибуту в request протокола HTTP
```
REQUEST and RESPONSE
tcpdump -A -s 0 'tcp port 80 and (((ip[2:2] - ((ip[0]&0xf)<<2)) - ((tcp[12]&0xf0)>>2)) != 0)'
tcpdump -X -s 0 'tcp port 80 and (((ip[2:2] - ((ip[0]&0xf)<<2)) - ((tcp[12]&0xf0)>>2)) != 0)'
```

### _API GitLab:_

1) Cоздание нового проекта. Сначала нужно выполнить экспорт нашего токена: `export API_KEY="your token"`
```
python gitlabAPI.py create_project --project_name network_task_2
```
2) Удаление проекта

Но сначала, получение id проекта:
```
#!/bin/bash

# 1-st arg - Type of resource to create
# 2-nd arg - Name of resource
# For example: bash get_id.sh projects new_project

curl -s --header "PRIVATE-TOKEN: $API_KEY" "https://git.epam.com/api/v4/search?scope=$1&search=$2" | jq '.[].id' 2> /dev/null
```
Теперь удаление:
```
curl --request DELETE --header "PRIVATE-TOKEN: $API_KEY" "https://git.epam.com/api/v4/projects/134402" | ./jq-win64.exe '.'
```

Чтобы получить необходимую информацию о пользователе, можно выполнить запрос: `curl --header "PRIVATE-TOKEN: $API_KEY" "https://git.epam.com/api/v4/users?search=andrii_kurapov@epam.com" | ./jq-win64.exe '.'`


3) Добавление пользователей в проект с различными ролями
```
python gitlabAPI.py role --action add --access_level 20 --project_id 119684 --user_id 63813
python gitlabAPI.py role --action update --access_level 30 --project_id 119684 --user_id 63813
python gitlabAPI.py role --action del --access_level 30 --project_id 119684 --user_id 63813
```

4) Получение списка веток
```
curl --header "PRIVATE-TOKEN: $API_KEY" "https://git.epam.com/api/v4/projects/119684/repository/branches/" | ./jq-win64.exe '.[] | .name'
```

5) Получение списка слитых веток (getting list of merged branches)
```
curl --header "PRIVATE-TOKEN: $API_KEY" "https://git.epam.com/api/v4/projects/119684/repository/branches/" | ./jq-win64.exe '.[] | select(.merged=true)'
```

6) Получить список тегов
```
curl --header "PRIVATE-TOKEN: $API_KEY" "https://git.epam.com/api/v4/projects/119684/repository/tags" | ./jq-win64.exe '.'
```

7) Создание issue и назначить его определенному пользователю
```
python gitlabAPI.py issue --project_id 119684 --title issue#1 --user_id 63813 --due_date 2022-07-22 --description "hello Andrii please fix" | ./jq-win64.exe '.'
```
8) Создание ветки с идентификатором issue
```
curl --request POST --header "PRIVATE-TOKEN: $API_KEY" "https://git.epam.com/api/v4/projects/119684/repository/branches?branch=issue&ref=master" | ./jq-win64.exe '.'
```
9-10) Запрос подтверждения слияния ветки с удаление/без удаления ветки
```
curl --request POST --header "PRIVATE-TOKEN: $API_KEY" "https://git.epam.com/api/v4/projects/119684/merge_requests?source_branch=issue&target_branch=master&title=testMR&remove_source_branch=false" | ./jq-win64.exe '.'

or

curl --request POST --header "PRIVATE-TOKEN: $API_KEY" "https://git.epam.com/api/v4/projects/122669/merge_requests?source_branch=issue&target_branch=master&title=testMR&remove_source_branch=true" | ./jq-win64.exe '.'
```
11) Поставить тег на commit
```
python gitlabAPI.py tag --action add --tag_name TAG1 --project_id 119684 --reference "b7b13d9f9a5050c18715d8e38e48783897f5dc59"
python gitlabAPI.py tag --action del --tag_name TAG1 --project_id 119684 --reference "b7b13d9f9a5050c18715d8e38e48783897f5dc59"
```

12) Получение списка пользователей
```
curl --header "PRIVATE-TOKEN: $API_KEY" "https://git.epam.com/api/v4/projects/119684/users" | ./jq-win64.exe '.'
```
13) Работа с коммитами

- Получить список всех комментариев коммита в запросе слияния
```
curl --header "PRIVATE-TOKEN: $API_KEY" "https://git.epam.com/api/v4/projects/119684/merge_requests/2/notes" | ./jq-win64.exe '.'
```

- Оставить комментарий в commit в определённую строку от имени пользователя 
```
curl --request POST --header "PRIVATE-TOKEN: $API_KEY" \
     --form "note=My Test Comment\!" --form "path=master/README.md" --form "line=19" --form "line_type=new" \
     "https://git.epam.com/api/v4/projects/119684/repository/commits/b7b13d9f9a5050c18715d8e38e48783897f5dc59/comments" | ./jq-win64.exe '.'
```


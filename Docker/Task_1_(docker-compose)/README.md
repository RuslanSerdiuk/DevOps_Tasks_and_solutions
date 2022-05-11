#  Docker-compose and dockerfile

## Task 1 (Working with docker-compose)
> Write a docker-compose for https://github.com/FaztWeb/php-mysql-crud which:
> - run a web server in one container
> - run the database in another container
> - uses a bridge network
> - Apache port must be not 80

### My docker-compose file:
```
version: '3.9'  

networks:
  app-tier:
    driver: bridge
    ipam:
      config:
        - subnet: 172.20.0.0/24
          gateway: 172.20.0.1

services:

  db:
    image: mysql
    restart: always
    command: --default-authentication-plugin=mysql_native_password  
    ports:
      - 3306:3306
    volumes:
      - ./php-mysql-crud/database/script.sql:/docker-entrypoint-initdb.d/dump.sql
    environment:
      MYSQL_ROOT_PASSWORD: "${DB_PW}"

    networks:
      app-tier:
        ipv4_address: 172.20.0.2

  web:
    build:
      context: ./
      dockerfile: Dockerfile
    depends_on:    
    restart: always
    ports:
      - 8100:8888
    volumes:
      - ./php-mysql-crud:/var/www/html/
    networks:
      app-tier:
        ipv4_address: 172.20.0.3
    depends_on:
      - "db"
```

### _To run my solution, you need to do 4 steps:_
#### 1. Have Docker Desktop on the windows)
#### 1. Open disk C: and create folder "test"
#### 2. Open folder "test" with cmd and clone my repository to yourself with command: 
> git clone -b m5-Docker-Task-01 --single-branch https://git.epam.com/ruslan_serdiuk/devops-21q4-22q1-serdiuk-ruslan.git
#### 3. Navigate to the copied repository using command:
> cd C:\test\devops-21q4-22q1-serdiuk-ruslan\Module-05_Docker\Task-01
#### 4. Run the command: *"docker-compose up"*
### After that open http://localhost:8100/ in browser.

> The following sources of information were also used in this assignment:
> - https://learn.acloud.guru/course/6b00566d-6246-4ebe-8257-f98f989321cf/learn/4849ea83-4ecb-459c-bdb0-72487b63082f/e437b424-3fb8-4da7-bee1-8db548a2be59/watch
> - https://www.youtube.com/watch?v=NRcpqse2zBo
> - https://www.youtube.com/watch?v=4KbL5lbjK-M
> - https://hub.docker.com/_/mysql
> - https://stackoverflow.com/questions/39493490/provide-static-ip-to-docker-containers-via-docker-compose
> - https://www.youtube.com/playlist?list=PLxeQ-jZjcEf2HI9B0l1YuUy_-iAjlydwR
> - https://videoportal.epam.com/playlist/mYR6ZoYW
> - https://docs.docker.com/develop/develop-images/dockerfile_best-practices/

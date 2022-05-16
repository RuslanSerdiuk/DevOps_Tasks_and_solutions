# CI/CD - Task_01: Jenkins


> #### *This task was only done to demonstrate some of the capabilities of the Jenkins server and config it. Plus writing some standard pipelines.*

### Preparation:
- I used Vagrant to quickly get a Jenkins server machine up and running + automated jdk installation and doker



## Task Desription

### Part 1:
```
Поднять и настроить Jenkins сервер.
1. Настроить агенты
1.1 статический (windows vs linux)
1.2 динамический (например, [https://www.jenkins.io/doc/book/pipeline/docker/ )
2. Поместить sensitive данные в credentials (github/gitlab connection details, etc)
3. Настроить права доступа. Создать три группы (dev, qa, devops и предоставить различные права доступа)

```
- 2 static agent: 1 - windows (label 'windows'), and Linux (label 'ubuntu') and 1 dynamic: pipeline 'dynamic_agent' with dyanmic windows agent
- all sensitive data in Jenkins Credentials
- were created 3 groups(roles) : dev, qa, devops, with their own permissions + add 2 users, Olga and Georgii

### Part 2:
```
Создать мультибранч пайплайн, который бы:
1. Тригерился на изменение в любой ветке гит репозитория, для ветки создается отдельный пайплайн
2. Пайплайн состоит из шагов
a. Клонировать репозиторий с feature ветки
b. Опционально: проверить коммит сообщение на соответствие best practice (длина сообщения, вначале код джира тикета)
c. Линтинг Dockerfiles
3. В случае фейла пайплайна - заблокировать возможность мержа feature ветки в основную ветку.
```
- Created 'Multibranch_Pipeline'
- Trigger on push in each branch into repository
- each pipeline has steps: Git clone(Clone project), Linting Dockerfiles(Check all Docker files in project), Test project (Start project and test. If test fail, all next stages won't be deployed)
- merge and push changes from 'feature' branch into 'main' branch

### Part 3:
```
Создать CI пайплайн:
1. Смотрит на основную ветку репозитория (main/master/whatever)
2. Тригерится на мерж в основную ветку
3. Клонирует репозиторий
4. Запускает статический анализ кода, Bugs, Vulnerabilities, Security Hotspots, Code Smells доступны на SonarQube сервере
5. Билдит Docker образ
6. Тегируем 2 раза образ (latest и версия билда)
7. Пушим образ в Docker Hub
```
- Created pipeline Pipeline_CI with:
- webhook triggered on push event of main bransh 'main'
- clone repo with project
- scan code quality with sonarqube 
- build docker image with project artifact 
- tags docker container with 2 tags
- push docker container to Docker Hub

### Part 4:
```
Создать CD пайплайн:

Параметры при запуске:
Имя энва (dev/qa)
Номер версии (т.е. тег образа, версия или latest). Будет плюсом, если этот список будет динамически подтягиваться из Dockerhub
Деплой образа на выбранный энвайронмент
Стейдж с healthcheck задеплоенногоо энва (curl endpoint or smth else)
```
- created pipeline Pipeline_CD with:
- two "Choise" parameters: enviroment (qa,dev)[enviroment for deploying projects], version (latest)[verson of docker images with project]
- when build pipeline can choose enviroment. 'qa' - windows, 'dev' - 'ubuntu.
- check health of deployd image using 'curl'
- when all checks successed, remove docker container


## _The End_
> You can check your work to your Jenkins server address. `(For example http://10.23.12.16:8080)`

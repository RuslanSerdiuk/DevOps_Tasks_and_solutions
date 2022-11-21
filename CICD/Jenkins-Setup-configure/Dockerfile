#Deriving the latest base image
FROM python:latest

WORKDIR /usr/app/src

#to COPY the remote file at working directory in container
COPY trigger-lambda.py ./

#CMD instruction should be used to run the software
#contained by your image, along with any arguments.

CMD [ "python", "./trigger-lambda.py"]
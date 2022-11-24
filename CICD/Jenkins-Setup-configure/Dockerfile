# python3.8 lambda base image
FROM public.ecr.aws/lambda/python:3.8

# Copy function code to container
COPY lambda.py /

# setting the CMD to your handler file_name.function_name
CMD [ "lambda.handler" ]
FROM python:3.9.7

WORKDIR /app

COPY requirements.txt requirements.txt

RUN pip3 install --no-cache-dir --requirement requirements.txt

COPY . .

CMD ["python3", "-m" , "flask", "run", "--host=0.0.0.0"]

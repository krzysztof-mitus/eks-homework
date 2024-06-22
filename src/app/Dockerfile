FROM python:3.8-slim-buster

WORKDIR /app

ADD . .

RUN pip install --no-cache-dir -r requirements.txt

ENV ENV_NAME="DEFAULT"
EXPOSE 8080

CMD ["python", "app.py"]
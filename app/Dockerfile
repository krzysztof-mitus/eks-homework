FROM python:3.8-slim-buster

WORKDIR /app

COPY src/app.py .
COPY requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt

ENV ENV_NAME="DEFAULT"
EXPOSE 80

CMD ["python", "/app/app.py"]
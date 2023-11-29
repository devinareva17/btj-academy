FROM python:3.9-alpine

WORKDIR /app
COPY . .
EXPOSE 5051
RUN pip install -r requirements.txt
CMD ["python", "app.py"]

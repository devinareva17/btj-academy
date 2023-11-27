FROM ubuntu:20.04
LABEL Name="Devina"
LABEL Version="0.1.0"
RUN apt-get update
ENTRYPOINT ["/bin/bash"]

FROM python:3.8
WORKDIR /app
COPY . /app
EXPOSE 8081
CMD ["python", "code.py"]

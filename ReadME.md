# Simple Task

Devina Reva Kusuma



## Dockerfile
step pertama yang dilakukan adalah dengan membuat dockerfile.
```bash
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
```
setelah dockerfile dibuat, file akan di-add, commit, dan push menuju repository.

Setelah itu, repository yang sudah ada dockerfile diclone.


## Build Docker
setelah clone repository, masuk ke folder clone dan buat image dan container dengan command dibawah.
```bash
docker build -t python-app:3.8 .
docker run -it -d --name devina python-app:3.8

```


## IP whoami
dengan menggunakan docker inspect whoami,
IP Address dari whoami adalah 172.17.0.2

## Volume mount
```bash
docker ps
docker inspect f301b98cba61
cd /home/local/.docker
cat whoami
```

maka isi file tersembunyi yang diambil dari source Mount adalah:
Oofooni1eeb9aengol3feekiph6fieve


## Image whoami
image yang digunakan pada docker container whoami adalah secret:aequaix9De6dii1ay4HeeWai2obie6Ei


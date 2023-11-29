# Simple Task 2

- pada example python app, tambahkan beberapa routing kemudian custom port yang di listen
- buatlah satu playbook dengan beberapa task yaitu:
1. menyalin file dari local ke server btj-academy
2. build docker image untuk example python app
3. jalankan container yang sudah dibuild

## app.py
pertama, file dari [github](https://github.com/rrw-bangunindo/btj-academy ) disalin ke local. selanjutnya, 
example python app diedit menggunakan vim text editor untuk ditambahkan route dan port.
```bash
from flask import Flask
app = Flask(__name__)

@app.route('/')
def hello_world():
    return 'Hello, Docker!'
 
@app.route('/home')
def home():
    return 'Ini adalah page /home'
 
@app.route('/about')
def about():
    return 'Ini adalah page /about'
 
if __name__ == '__main__':
    app.run(debug=True,host='0.0.0.0', port=5051)
```

## Dockerfile

pada direktori yang sama dengan app.py dan requirements.txt, dockerfile dibuat menggunakan text editor vim dengan script sebagai berikut.

```bash
FROM python:3.9-alpine

WORKDIR /app
COPY . .
EXPOSE 5051
RUN pip install -r requirements.txt
CMD ["python", "app.py"]

```

## Inventory

pembuatan inventory dilakukan dengan text editor vim, yaitu dengan command vim inventory.yaml pada terminal linux.

```bash
vim inventory2.yaml
```

```bash
all:
  vars:
    vm_path: /home/devinareva/btj-academy/simpletask_2
  hosts:
    btj-academy:
      ansible_host: 10.184.0.100
```
pada inventory ini didefinisikan variabel vm_path yang menyimpan direktori path server.

## Playbook

pembuatan playbook dilakukan dengan text editor vim, yaitu dengan command vim playbook2.yaml pada terminal linux.

```bash
vim playbook.yaml
```

```bash
---  
  - name: simpletask-2
    hosts: btj-academy
    tasks:
    - name: copy file to server
      copy:
        src: /root/btj-academy/btj-academy/simpletask_2
        dest: "{{vm_path}}"
    - name: build container image
      docker_image:
        name: app-dvn:0.1.0
        build:
          path: "{{vm_path}}"
        source: build
        state: present
    - name:  start container
      docker_container:
        name: flaskapp-dvnrv
        image: app-dvn:0.1.0
        interactive: true
        tty: true
        published_ports: '5051:5051'             
``` 
pada playbook ini, terdapat 3 task yang dilakukan. modul yang digunakan adalah copy, docker_image, dan docker_container. 

module copy digunakan untuk menyalin file dari local ke server. terdapat dua parameter yaitu scr yang menyimpan direktori source/sumber, serta dest yang menyimpan direktori tujuan. dest didefinisikan dengan variabel vm_path yang telah dideklarasi di file inventory2.yaml.

module docker_image digunakan untuk membuild docker image. terdapat 4 parameter yang digunakan yaitu name untuk mendefinisikan nama image, build:path yang menyimpan path docker file dan context yang digunakan untuk build image, source yang menentukan dari mana modul akan mencoba mengambil gambar, serta state yang berisi pernyataan tentang keadaan suatu gambar.

module docker_container digunakan untuk memnjalankan container. terdapat 5 parameter yaitu name untuk mendefinisikan nama container, image untuk mendefinisikan docker image yang sebelumnya telah dibuild, interactive dan tty yang diset dengan true agar container dapat interaktif, serta published_ports untuk list port yang akan dipublikasikan dari container ke host.


## ansible-playbook
setelah selesai membuat playbook dan inventory, ansible dijalankan.
```bash
ansible-playbook -i inventory2.yaml playbook2.yaml --user devinareva
```
selanjutnya, cek di server apakah task menghasilkan output yang sesuai dengan task ansible.

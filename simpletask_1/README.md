# Simple Task 1

- buatlah sebuah inventory, pada inventory tersebut mendefinisikan daftar variabel dan host
- buatlah satu playbook task menjalankan sebuah docker container dengan kriteria yaitu terdapat image, port, dan environment variables

## Inventory

pembuatan inventory dilakukan dengan text editor vim, yaitu dengan command vim inventory.yaml pada terminal linux.

```bash
vim inventory.yaml
```

```bash
all:
  vars:
    ubuntu_image: ubuntu:latest
  hosts:
    btj-academy:
      ansible_host: 10.184.0.100
```
pada inventory ini didefinisikan variabel ubuntu-image yang berisi nama docker image untuk playbook, serta target hosts yaitu btj-academy.

## Playbook

pembuatan playbook dilakukan dengan text editor vim, yaitu dengan command vim playbook.yaml pada terminal linux.

```bash
vim playbook.yaml
```

```bash
---
  - name: menjalankan docker container
    hosts: all
    become: true
    tasks:
    - docker_container:
        name: ubuntu-dvn
        image: "{{ubuntu_image}}"
        interactive: true
        tty: true
        exposed_ports: '6652'               
``` 
pada playbook ini, modul yang digunakan adalah docker_container dengan nama containernya adalah ubuntu-dvn, dengan image dari variabel ubuntu_image pada inventory.yaml, dan port 6652.

## ansible-playbook
setelah selesai membuat playbook dan inventory, ansible dijalankan.
```bash
ansible-playbook -i inventory.yaml playbook.yaml --user devinareva
```
setelah task berhasil dijalankan, seharusnya akan ada docker container dengan nama ubuntu-dvn.
cek dengan menggunakan command docker ps -a

```bash
docker ps -a
```

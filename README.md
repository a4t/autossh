# autossh

## Introduction
This is ssh proxy.

## Installation

```
$ git clone https://github.com/a4t/autossh
```

## Usage

### Configuration

#### Setting docker-compose.yml

./docker-compose.yml

```
networks: {}
version: '2.0'

services:
  autossh:
    build:
      context: ./
      dockerfile: ./Dockerfile
    volumes:
      - $HOME/.ssh/id_rsa:/home/proxy/.ssh/id_rsa # Remote host access private key
    ports:
      - "9998:9998"
    environment:
      - TUNNEL_USER=moge
      - TUNNEL_HOST=mogemoge.com
      - REMOTE_HOST=hogehoge.com
      - REMOTE_PORT=3306
```

### Sample

```
$ docker-compose up -d
$ mysql -h 127.0.0.1 -P 9998 -u mysql_user -p
```

### +passphrase

docker-compose.yml
```
networks: {}
version: '2.0'

volumes:
  ssh:

services:
  autossh:
    build:
      context: ./
      dockerfile: ./Dockerfile
    volumes:
      - $HOME/.ssh/id_rsa:/home/proxy/.ssh/id_rsa
      - ssh:/ssh
    ports:
      - "9998:9998"
    environment:
      - TUNNEL_USER=moge
      - TUNNEL_HOST=mogemoge.com
      - REMOTE_HOST=hogehoge.com
      - REMOTE_PORT=3306
    depends_on:
      - ssh-agent

  ssh-agent:
    container_name: ssh-agent
    image: whilp/ssh-agent:latest
    volumes:
      - ssh:/ssh
```

```
$ docker-compose run --entrypoint "" autossh ssh-add /home/proxy/.ssh/id_rsa
Starting ssh-agent ... done
Enter passphrase for /home/proxy/.ssh/id_rsa: xxxxxxxxxxxxxxxxxxxxxx
$ docker-compose up -d
$ mysql -h 127.0.0.1 -P 9998 -u mysql_user -p
```

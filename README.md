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
      - ~/.ssh/id_rsa:/home/proxy/.ssh/id_rsa # Remote host access private key
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

#  [skaro13/mediadrop](https://github.com/skaro13/docker-mediadrop)

MediaDrop is a open source online video platform for managing and delivering video, audio and podcasts.

<div style="text-align:center"><img src="https://mediadrop.video/images/layout/logo.jpg"/></div>

## Usage
Here are some example snippets to help you get started creating a container.
### docker
```
docker create \
  --name=mediadrop \
  -e DB_HOST=<mysql host> \
  -e DB_NAME=<mysql database name> \
  -e DB_USER=<mysql database user> \
  -e DB_PASSWORD=<mysql database password> \      
  -p 8080:8080 \
  --link <mysql container>
  -v path/to/data:/data \
  --restart unless-stopped \
  skaro13/mediadrop
```

### docker-compose
Compatible with docker-compose v2 schemas.

```
version: '2'
services:
  mediadrop:
    container_name: mediadrop
    image: skaro13/mediadrop
    environment:
      - DB_HOST=mysql
      - DB_NAME=mediadrop
      - DB_USER=mediadrop
      - DB_PASSWORD=changeit
    volumes:
      - ./data:/data
    ports:
      - "8080:8080"
    depends_on:
      - db
    restart: always
  db:
    container_name: mysql
    image: mysql:5.7
    restart: always
    environment:
      - MYSQL_ROOT_PASSWORD=changeit
      - MYSQL_DATABASE=mediadrop
      - MYSQL_USER=mediadrop
      - MYSQL_PASSWORD=changeit
    volumes:
      - ./db/:/var/lib/mysql
```

## Parameters

| Parameter        | Function           | 
| :------------- |:-------------|
| -e DB_HOST    | Host on which mysql is running |
| -e DB_NAME    | Database to use on the mysql instance      |
| -e DB_USER    | Mediadrop database user      |
| -e DB_PASSWORD    |  Mediadrop database password      |
| -v /data    | Mediadrop data folder. This is where config and uploaded media will be stored      |

## Application Setup

Webui can be found at your-ip:8080

** Note: Mediadrop is only compatible with mysql v5.7 **

## Building locally

If you want to make local modifications to these images for development purposes or just to customize the logic: 

```
git clone https://github.com/skaro13/docker-mediadrop.git
cd mediadrop-dockerfile
docker build \
  --no-cache \
  --pull \
  -t skaro13/mediadrop:latest .
```

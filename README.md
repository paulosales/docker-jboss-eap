# jboss-eap

Jboss EAP Docker imagens

## Supported tags and respective `Dockerfile` links

* [`7.3.0`, `7.3.0-alpine`, `latest`](https://github.com/paulosales/docker-jboss-eap/blob/master/7.3/Dockerfile) - JBoss EAP 7.3.0 over Openjdk 11 and Alpine Linux
* [`7.2.0`, `7.2.0-alpine`](https://github.com/paulosales/docker-jboss-eap/blob/master/7.2/Dockerfile) - JBoss EAP 7.2.0 over Openjdk 11 and Alpine Linux

## Usage

### Command line

```bash
docker run -p 8080:8080 -p 9990:9990 -p 8443:8443 -d prsales/jboss-eap:7.3-alpine
```

### Docker composer

```yml
version: '3.1'

services:
  jboss:
    image: prsales/jboss-eap:7.2.0-alpine
    restart: always
    environment:
      ADMIN_USER: admin
      ADMIN_PASSWORD: admin
    volumes:
      - ./standalone.xml:/home/jboss/jboss-eap-7.2/standalone/configuration/standalone.xml
    ports:
      - 8080:8080
      - 9990:9990
```


The web application and the management console will be available in `http://localhost:8080` and `http://localhost:9990`

## The default management user and password

The default management username is `admin` and his password is `Admin.123`. You can customize these by the respective environments variables `ADMIN_USER` and `ADMIN_PASSWORD` like that:

```bash
docker run -p 8080:8080 -p 9990:9990 -p 8443:8443 -e ADMIN_USER="master" -e ADMIN_PASSWORD="passwd" -d prsales/jboss-eap:7.3-alpine
```

## The optional application user and password

Optionally, you can specify the application user and password to ApplicationRealm. You can do this by setting the environment variables `APP_USER`, `APP_PASSWORD`, and `APP_USER_ROLE`.

## JBOSS configuration

You can use Docker volumes configure Jboss-EAP `standalone.xml` file.

The Jboss configuration file can be found at directory `/home/jboss/jboss-eap-<JBOSS_VERSION>/standalone/configuration/standalone.xml`

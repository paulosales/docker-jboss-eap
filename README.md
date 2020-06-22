# jboss-eap

Jboss EAP Docker imagens

## Supported tags and respective `Dockerfile` links

* [`7.3.0`, `7.3.0-alpine`, `latest`](https://github.com/paulosales/docker-jboss/blob/master/Dockerfile) - JBoss EAP 7.3.0 over Openjdk 11 and Alpine Linux
* [`7.2.0`, `7.2.0-alpine`](https://github.com/paulosales/docker-jboss/blob/master/Dockerfile) - JBoss EAP 7.2.0 over Openjdk 11 and Alpine Linux

## Usage

```bash
docker run -p 8080:8080 -p 9990:9990 -p 8443:8443 -d prsales/jboss-eap:7.3-alpine
```

The web application and the management console will be available in `http://localhost:8080` and `http://localhost:9990`

## The default admin password

The default admin username is `admin` and his password is `Admin.123`. You can customize these by the respective environments variables `ADMIN_USER` and `ADMIN_PASSWORD` like that:

```bash
docker run -p 8080:8080 -p 9990:9990 -p 8443:8443 -e ADMIN_USER="master" -e ADMIN_PASSWORD="passwd" -d prsales/jboss-eap:7.3-alpine
```

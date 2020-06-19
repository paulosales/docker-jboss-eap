# https://github.com/keckelt/openjdk11-alpine/blob/master/Dockerfile
# https://github.com/daggerok/jboss-eap-7.2/blob/7.2.5-alpine/Dockerfile
# https://github.com/Scalified/docker-jboss-eap/blob/master/Dockerfile
# http://www-padraotic/index.php/pti-red-hat-jboss-eap-7/


FROM alpine:3

LABEL MAINTAINER="Paulo Rogério Sales Santos"

ARG JBOSS_ARCHIVE_URL

ENV PRODUCT="jboss-eap-7.2" \
  JBOSS_USER="jboss" \
  ADMIN_USER="admin" \
  ADMIN_PASSWORD="Admin.123"

ENV JBOSS_USER_HOME="/home/${JBOSS_USER}"

ENV JBOSS_HOME="${JBOSS_USER_HOME}/${PRODUCT}" \
  JAVA_HOME="/usr/lib/jvm/default-jvm"

ENV PATH="${JAVA_HOME}/bin:${JBOSS_HOME}/bin:/tmp:${PATH}"

USER root

RUN ( apk fix --no-cache || echo "cannot fix." ) && \
    ( apk upgrade --no-cache || echo "cannot upgrade." ) && \
      apk add --no-cache --update --upgrade \
      openjdk11 busybox-suid bash wget ca-certificates unzip sudo openssh-client shadow curl && \
    echo "${JBOSS_USER} ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers && \
    sed -i "s/.*requiretty$/Defaults !requiretty/" /etc/sudoers && \
    addgroup --system -g 1001 -S ${JBOSS_USER} && \
    adduser --system -h ${JBOSS_USER_HOME} -s /bin/ash -D -u 1001 ${JBOSS_USER} ${JBOSS_USER} && \
    usermod -a -G ${JBOSS_USER} ${JBOSS_USER}

USER ${JBOSS_USER}

WORKDIR /tmp

RUN wget ${JBOSS_ARCHIVE_URL} \
          -q --no-cookies --no-check-certificate -O /tmp/jboss-eap-7.2.0.zip && \
    unzip -q /tmp/jboss-eap-7.2.0.zip -d ${JBOSS_USER_HOME} && \
    add-user.sh ${ADMIN_USER} ${ADMIN_PASSWORD} --silent && \
    echo 'JAVA_OPTS="-Djava.io.tmpdir=/tmp -Djava.net.preferIPv4Stack=true -Djboss.bind.address=0.0.0.0 -Djboss.bind.address.management=0.0.0.0"' \
     >> ${JBOSS_HOME}/bin/standalone.conf

USER root

RUN apk del --no-cache --no-network --purge busybox-suid unzip openssh-client shadow && \
    ( rm -rf /tmp/* /var/cache/apk /var/lib/apk /etc/apk/cache || echo "cleanup!" )

WORKDIR ${JBOSS_USER_HOME}

ENTRYPOINT ["/bin/ash", "-c"]

EXPOSE 8080 8443 9990

CMD ["${JBOSS_HOME}/bin/standalone.sh -b 0.0.0.0"]

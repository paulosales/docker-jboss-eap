${JBOSS_HOME}/bin/add-user.sh ${ADMIN_USER} ${ADMIN_PASSWORD} --silent
if [ ! -z "$APP_USER" ]
then
  ${JBOSS_HOME}/bin/add-user.sh ${APP_USER} ${APP_PASSWORD} --silent -a -g ${APP_USER_ROLE}
fi
${JBOSS_HOME}/bin/standalone.sh -b 0.0.0.0

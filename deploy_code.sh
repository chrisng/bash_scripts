#!/bin/bash
# ---------------------------------------------
# Description:
#   Script used to deploy code
#
# Notes:
#
#
# Author:
#  Chris Ng
#
# Version 1.0
#   - Inital Version
# ---------------------------------------------

# ----------
# Set Vars
# ---------
WEB_SERVERS=("web1")
APP_SERVERS=("app")
STATIC_FILES=static.zip
TODAY_DATE=$(date +%Y_%m_%d-%H%M%S)
WEB_SRV_PATH=/home/nginx/companyNews/
APP_SRV_PATH=/opt/tomcat/webapps
# Set the number of backups to keep
WEB_DEPLOY_PATH="$WEB_SRV_PATH/$TODAY_DATE"

# Deploy Static Assets
for WEBSVR in "${WEB_SERVERS[@]}" ; do
  echo $WEBSVR
  ssh $WEBSVR "mkdir -p ${WEB_SRV_PATH}/${TODAY_DATE}"
  scp -rp $STATIC_FILES ${WEBSVR}:${WEB_DEPLOY_PATH}
  ssh ${WEBSVR} "cd ${WEB_DEPLOY_PATH} ; unzip $STATIC_FILES ; ln -sfn ${WEB_DEPLOY_PATH} ${WEB_SRV_PATH}/current"
done


# Deploy .war file
for APPSVR in "${APP_SERVERS[@]}" ; do
  ssh $APPSVR "mkdir -p /home/tomcat/backups/${TODAY_DATE} ; rm `ls -t | tail -n +${NUM_OF_BACKUPS}` ; cp ${APP_DEPLOY_PATH}/*.war /home/tomcat/backups/${TODAY_DATE}"
  scp -rp companyNews.war ${APP}:${APP_DEPLOY_PATH}
done


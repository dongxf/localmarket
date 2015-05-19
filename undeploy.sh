#!/bin/bash

# Un-deploy a mup-deployed Meteor app.
# Does not touch MongoDB databases.

# These commands must be run directly on the server with the
# mup-deployed Meteor app.

set -o nounset

app=$1

if [[ -z "$app" ]] # $app is an empty string.
then
  echo $0 error: Must pass in mup app name. 
  exit 1
fi

if ! [[ -d /opt/$app && -f /etc/init/${app}.conf ]]
then
  echo $0 error: Cannot find deployed app named $app
  exit 1
fi

set -o xtrace

# Stop running app.
sudo stop $app

# Create place to trash un-deployed app. This is just in case you
# change your mind.
trash=/tmp/${app}-trash
sudo mkdir $trash

# Remove logs.
sudo mv /var/log/upstart/${app}.log* $trash

# Remove start/stop script.
sudo mv /etc/init/${app}.conf $trash

# Delete deployed app.
sudo mv /opt/${app} $trash

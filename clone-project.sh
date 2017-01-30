#!/bin/bash
#Clone all git repositories from a given Bitbucket project.
#Usage: clone-project.sh [repository manager URL] [project key] [username]

REPO_URL=$1
API_URL=$REPO_URL/rest/api/1.0/projects
PROJECT_URL=$API_URL/$2/repos
USERNAME=$3

if [ "$(expr substr $(uname -s) 1 5)" == "MINGW" ]; then
	CURL=/usr/bin/curl.exe
else
	CURL=curl
fi

REPO_LIST=`$CURL -s -u $USERNAME $PROJECT_URL | sed -e 's/,/\n/g' | grep -Po '"href":"ssh:.*?[^\\\\]"' | cut -d \" -f 4`

for REPO in $REPO_LIST
do
	git clone $REPO
done


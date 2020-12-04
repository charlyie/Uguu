#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
CONF_SAVED="false"
GREEN="\033[0;32m"
WHITE="\033[1;37m"
NC="\033[0m" # No Color

printf "${WHITE}[${GREEN}UGUU${WHITE}] Lauching installation of File sharing...${NC}\n"
cd $DIR
if [[ ! -f "data.sq3" ]]; then
    touch data.sq3
	sqlite3 data.sq3 < sqlite_schema.sql
fi
mkdir dist/data -p

if [[ -f "dist/includes/settings.inc.php" ]]; then

	printf "${WHITE}[${GREEN}UGUU${WHITE}] Preserving configuration file...${NC}\n"
    yes | cp dist/includes/settings.inc.php ../settings.inc.php
    CONF_SAVED="true"
fi

make
make install 

if [[ "$CONF_SAVED" == "true" ]]; then
	printf "${WHITE}[${GREEN}UGUU${WHITE}] Restoring configuration file...${NC}\n"
	yes | cp ../settings.inc.php dist/includes/settings.inc.php
fi
printf "${WHITE}[${GREEN}UGUU${WHITE}] Application is installed!${NC}\n"

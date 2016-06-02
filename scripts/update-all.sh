#!/bin/bash

pull_if_exists() {
	if [ -d $1 ]; then
		pushd $1
		git pull
		popd
	fi
}


git pull

php composer.phar update -o


pull_if_exists module/MonarcCore
pull_if_exists module/MonarcBO
pull_if_exists node_modules/ng_backoffice

php ./vendor/robmorgan/phinx/bin/phinx migrate -c ./module/MonarcCore/migrations/phinx.php
php ./vendor/robmorgan/phinx/bin/phinx migrate -c ./module/MonarcBO/migrations/phinx.php

if [ -d node_modules/ng_backoffice ]; then
	cd node_modules/ng_backoffice
	npm install
	cd ../..
fi

./scripts/link_modules_resources.sh

#!/bin/bash

set -eu

MAGENTO_EDITION="${MAGENTO_EDITION:=community}"
MAGENTO_VERSION="${MAGENTO_VERSION:=2.4.5-p1}"

cd ${CODESPACES_REPO_ROOT}
# Temporarily use an empty config.yaml to get ddev to use defaults
# so we can do composer install. If there's already one there,
# this does no harm.
mkdir -p .ddev && touch .ddev/config.yaml

# If there's a composer.json, do `ddev composer install` (which auto-starts projct)
if [ -f composer.json ]; then
  ddev start
  ddev composer install
else
  ddev composer config -g -a http-basic.repo.magento.com ${MAGENTO_COMPOSER_AUTH_USER} ${MAGENTO_COMPOSER_AUTH_PASS}
  ddev composer create --no-interaction --no-progress --repository-url=https://repo.magento.com/ magento/project-${MAGENTO_EDITION}-edition=${MAGENTO_VERSION}
  git reset && git checkout . && git checkout -- .gitignore;
fi

sed -i "s/AUTH_USER/${MAGENTO_COMPOSER_AUTH_USER}/g" ${CODESPACES_REPO_ROOT}/auth.json &&
sed -i "s/AUTH_PASS/${MAGENTO_COMPOSER_AUTH_PASS}/g" ${CODESPACES_REPO_ROOT}/auth.json &&

if [ ! -f bin/magerun2 ]; then
  ddev exec curl -L https://files.magerun.net/n98-magerun2.phar --output bin/magerun2
  ddev exec chmod +x bin/magerun2
fi

ddev get drud/ddev-redis
ddev get drud/ddev-elasticsearch
ddev stop -a
ddev start -y

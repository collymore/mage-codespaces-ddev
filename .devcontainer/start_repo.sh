#!/bin/bash

set -eu

MAGENTO_EDITION="${MAGENTO_EDITION:=community}"
MAGENTO_VERSION="${MAGENTO_VERSION:=2.4.6}"

cd ${CODESPACES_REPO_ROOT}

# Wait for Docker to be ready
until docker info >/dev/null 2>&1; do
    echo "Waiting for Docker to start..."
    sleep 1
done
echo "Docker is ready."

# Temporarily use an empty config.yaml to get ddev to use defaults
# so we can do composer install. If there's already one there,
# this does no harm.
mkdir -p .ddev && touch .ddev/config.yaml

# If there's a composer.json, do `ddev composer install` (which auto-starts project)
if [ -f composer.json ]; then
  ddev start
  ddev composer install
else
  ddev composer config -g -a http-basic.repo.magento.com ${MAGENTO_COMPOSER_AUTH_USER} ${MAGENTO_COMPOSER_AUTH_PASS}
  ddev composer create --no-interaction --no-progress --repository-url=https://repo.magento.com/ magento/project-${MAGENTO_EDITION}-edition=${MAGENTO_VERSION}
  git reset && git checkout . && git checkout -- .gitignore;
fi

if [ ! -f bin/magerun2 ]; then
  ddev exec curl -L https://files.magerun.net/n98-magerun2.phar --output bin/magerun2
  ddev exec chmod +x bin/magerun2
fi

ddev get drud/ddev-redis
ddev get drud/ddev-elasticsearch
ddev stop -a
ddev start -y

# Magento 2 GitHub Codespaces Cloud Environment using ddev

Spin up a Magento Open Source instance on GitHub Codespaces using ddev. Using [ddev](https://ddev.com/) greatly simplifies the setup and maintenance of a dev environment.

Or, with Adobe Commerce and/or Hyvä Themes in [3 simple steps](#getting-started).

Note: This project is inspired by [magento-gitpod](https://github.com/fisheyehq/magento-gitpod) repository.

My Gitpod version of this project is [mage-gitpod-ddev](https://github.com/jasonevans1/mage-gitpod-ddev)

## Overview

This repository contains a GitHub Codespaces configuration for a Magento 2 cloud environment that can be used for multiple purposes, such as:
* To demo sites to merchants during sales pitches
* To provide merchant training sessions
* Quick access to a blank Magento instance to test/debug default configuration options
* For a demo instance to help revise for Adobe Commerce certifications (e.g. Business Practitioner)
* For a quick, disposable development environment to 'hack around' on (great for developer training sessions)
* For those new to Magento 2 to quickly get hands-on and play around with the platform

## Key Benefits/Features
* Environments are quick to create (~5 mins) and even faster to restart, once created, after being stopped (<1 min)
* Each environment allows you full access to the storefront, admin panel, codebase, command line and more, and can even be connected to VS Code or PHPStorm remotely
* Everything is cloud hosted, so it takes up no space or resource on your machine (bar another browser tab)

## Roadmap
* Add option to install Adobe Live Search and Product Recommendations to the Adobe Commerce build
* Add option to install Varnish
* Add option to install RabbitMQ
* Add option to install Adobe Commerce CLI tools and configuration.
* Add documentation for the following: cron, Mailhog for email, PHPUnit.

## Getting Started

### Prerequisites
* Ensure you have a GitHub account and are logged in
* Install the GitHub CLI ([GitHub CLI](https://docs.github.com/en/codespaces/developing-in-codespaces/using-github-codespaces-with-github-cli)). Use the GitHub CLI to view the codespace logs and SSH into the codespace environment.
* Ensure you have the relevant license keys to hand (for Adobe Commerce and Hyvä Themes only)

### Magento Open Source:
1. Add variables to your account at [adding a secret](https://docs.github.com/en/codespaces/managing-your-codespaces/managing-encrypted-secrets-for-your-codespaces#adding-a-secret) for `MAGENTO_COMPOSER_AUTH_USER` and `MAGENTO_COMPOSER_AUTH_PASS` with composer credentials that have access to Magento open source.
2. See the codespaces documentation for the steps to start a new codespaces environment. ([create a codespace for a repository](https://docs.github.com/en/codespaces/developing-in-codespaces/creating-a-codespace-for-a-repository#creating-a-codespace-for-a-repository)).
3. Run the `gh codespace ports` . Open the 8080 port URL in a browser to view the Magento frontend.

### Adobe Commerce (installs the B2B extension):
1. Add variables to your account at [adding a secret](https://docs.github.com/en/codespaces/managing-your-codespaces/managing-encrypted-secrets-for-your-codespaces#adding-a-secret) for `MAGENTO_EDITION` set to "enterprise",  `MAGENTO_COMPOSER_AUTH_USER` and `MAGENTO_COMPOSER_AUTH_PASS` with composer credentials that have access to the Adobe Commerce repos.
2. See the codespaces documentation for the steps to start a new codespaces environment. ([create a codespace for a repository](https://docs.github.com/en/codespaces/developing-in-codespaces/creating-a-codespace-for-a-repository#creating-a-codespace-for-a-repository)). 
3. Run the `gh codespace ports` . Open the 8080 port URL in a browser to view the Magento frontend.

> \*Note: you must supply your own composer credentials to allow install of Adobe Commerce.

### Hyvä Themes (Magento Open Source):
1. Add variables to your account at [adding a secret](https://docs.github.com/en/codespaces/managing-your-codespaces/managing-encrypted-secrets-for-your-codespaces#adding-a-secret) for `INSTALL_HYVA` set to YES, `HYVA_COMPOSER_TOKEN` and `HYVA_COMPOSER_PROJECT` with your Hyvä Themes composer token and project name (see [Hyvä's install docs](https://docs.hyva.io/hyva-themes/getting-started/index.html) for more detail).
2. See the codespaces documentation for the steps to start a new codespaces environment. ([create a codespace for a repository](https://docs.github.com/en/codespaces/developing-in-codespaces/creating-a-codespace-for-a-repository#creating-a-codespace-for-a-repository)). 
3. Run the `gh codespace ports` . Open the 8080 port URL in a browser to view the Magento frontend.


> \*Note: you must supply your own Hyvä credentials that where provided to you when purchased a license. Installing Hyvä Themes via git is not supported.

### Hyvä Themes (Adobe Commerce):
1. Follow the Adobe Commerce and Hyvä Themes steps to add the correct variables.secrets.
2. See the codespaces documentation for the steps to start a new codespaces environment. ([create a codespace for a repository](https://docs.github.com/en/codespaces/developing-in-codespaces/creating-a-codespace-for-a-repository#creating-a-codespace-for-a-repository)).
3. Run the `gh codespace ports` . Open the 8080 port URL in a browser to view the Magento frontend.


## Accessing the Magento Admin Panel
The Magento Admin Panel is is available at `/admin` and the username and password are `admin` and `password1` respectively.

## ddev Notes
ddev is installed and configured within the codespaces environment. .devcontainer/devcontainer.json file is configured install ddev features. See the ddev documentation for more information ([ddev Codespaces Installation](https://ddev.readthedocs.io/en/stable/users/install/ddev-installation/#github-codespaces)). 

* .ddev/config.yaml - ddev configuration file. Configured with: PHP 8.1, MariaDB 10.4, Composer 2, Nginx, node.js v16, xdebug is disabled.
* Elasticsearch and Redis containers are installed. See the .devcontainer/start_repo.sh script
* Run `ddev ssh` from the terminal to SSH to the nginx docker container.

### xdebug
Steps to enable xdebug:

* Run command: `ddev xdebug on`
* PHPStorm: Open Settings > PHP > Servers. Add a server with the name of the codespaces URL on port 80. Map the Magento root directory to `/var/www/html`. Start Listenting for debug connections. See the ddev documentation for more information. https://ddev.readthedocs.io/en/stable/users/debugging-profiling/step-debugging/

### blackfire.io
Steps to enable blackfire.io for profiling

* Run command: `ddev config global --web-environment-add="BLACKFIRE_SERVER_ID=<id>,BLACKFIRE_SERVER_TOKEN=<token>,BLACKFIRE_CLIENT_ID=<id>,BLACKFIRE_CLIENT_TOKEN=<token>` . Replacing the <id> and <token> with your blackfire credentials. Note: you only need the client_id and client_token set if you are profiling CLI commands.
* Run command: `ddev blackfire on`
* Use the blackfire.io browser extension to profile a Magento page on your codespaces workspace.
* See the ddev documentation for more information. https://ddev.readthedocs.io/en/stable/users/debugging-profiling/blackfire-profiling/

## GitHub Codespaces Notes

### Recommendations
* Create a codespace with a 4 core and 8GB memory machine type.
* Use the `gh codespace logs -f` command to tail the logs when starting a codespace.
* Use the `gh codespace ssh` command to ssh into the codespace.

### Overriding Environment Variables
There are multiple ways to override environment variables, [which are outlined in this guide](https://docs.github.com/en/codespaces/managing-your-codespaces/managing-encrypted-secrets-for-your-codespaces#adding-a-secret), and which option you should choose depends on whether you want to override the configuration for a specific environment only, or every environment you create with GitHub Codespaces.

## Using mage-codespaces-ddev for an existing Magento project
You could use this project as a starting point for running an existing Magento project on GitHub Codespaces using ddev. Here are the steps:

* Copy the files into your existing Magento repository: .ddev/config.yaml, .devcontainer/install_magento.sh, .devcontainer/start_repo.sh, .devcontainer/devcontainer.json.
* Change the .ddev/config.yaml and .devcontainer/devcontainer.json as needed.
* Set these GitHub Codespaces environment variables `INSTALL_MAGENTO=NO`, `INSTALL_SAMPLE_DATA=NO`, `MAGENTO_EDITION=existing` and set the Magento/Hyva composer key variables as needed.
* Commit a database dump here `.devcontainer/magento-db.sql.zip` . This database dump will be imported on the initial start of the workspace.
* Commit a `.devcontainer/files.tgz` if you want to load media files.
* Commit a composer.json and composer.lock file.
* Customize .devcontainer/install_magento.sh as needed. Example customizations: change how the database file is stored and loaded, change the magento settings on start. 
* TODO: Add option to load an existing app/etc/env.php file on workspace start.


# Apache Airflow example

[Apache Airflow](https://airflow.apache.org/) is a python-based tool for programmatically developing, scheduling and monitoring workflows.

## Environment setup

This repository is intended to allow the user to duplicate the environment used for this walkthrough. It requires [Vagrant](https://www.vagrantup.com/) and a virtualisation provider such as [VirtualBox](https://www.virtualbox.org) and all commands below are for a bash-like shell.

It is also possible to install Airflow through [`pip`](#Installing-with-pip).

```bash

$ git clone 

# install the docker-compose plugin
$ vagrant plugin install vagrant-docker-compose

$ vagrant up

# to enter VM
$ vagrant ssh 

```

### Installing with pip

Airflow can also be installed as a local instance using [`pip`](https://airflow.apache.org/docs/apache-airflow/stable/start/local.html) the python package manager. It is a little more involved than just `pip install airflow` so the official steps are included below for reference.

```bash
# Airflow needs a home. `~/airflow` is the default, but you can put it
# somewhere else if you prefer (optional)
export AIRFLOW_HOME=~/airflow

# Install Airflow using the constraints file
AIRFLOW_VERSION=2.2.3
PYTHON_VERSION="$(python --version | cut -d " " -f 2 | cut -d "." -f 1-2)"
# For example: 3.6
CONSTRAINT_URL="https://raw.githubusercontent.com/apache/airflow/constraints-${AIRFLOW_VERSION}/constraints-${PYTHON_VERSION}.txt"
# For example: https://raw.githubusercontent.com/apache/airflow/constraints-2.2.3/constraints-3.6.txt
pip install "apache-airflow==${AIRFLOW_VERSION}" --constraint "${CONSTRAINT_URL}"

# The Standalone command will initialise the database, make a user,
# and start all components for you.
airflow standalone

# Visit localhost:8080 in the browser and use the admin account details
# shown on the terminal to login.
# Enable the example_bash_operator dag in the home page
```

## Extra: Configure VSCode Remote SSH to use Vagrant Box

If you'd rather use VSCode for exploring and editing this repository you can configure the Remote SSH plugin for VSCode to use your running Vagrant box with the following steps.

1. Install [VSCode Remote SSH](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-ssh)

2. Get vagrant SSH config details
    ```
    $ vagrant ssh-config
    ```

3. Add these details to your default `.ssh/config` file or another config file you wish to use

4. Start up your vagrant VM
    ```
    $ vagrant up
    ```

5. Start a remote session via VSCode and select the name of the vagrant host

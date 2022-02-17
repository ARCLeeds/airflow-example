# Apache Airflow example

[Apache Airflow](https://airflow.apache.org/) is a python-based tool for programmatically developing, scheduling and monitoring workflows.

## Environment setup

This repository is intended to allow the user to duplicate the environment used for this walkthrough. It requires [Vagrant](https://www.vagrantup.com/) and a virtualisation provider such as [VirtualBox](https://www.virtualbox.org) and all commands below are for a bash-like shell.

**This vagrantfile is set up to attempt to create a VM with 8GB of RAM, edit the Vagrantfile if your system doesn't have this much memory!**

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

## Running the docker-compose example

Now the pipeline defined in `dafs/pipeline.py` isn't really a good example of a pipeline. It'll run once and work but subsequent runs will fail, but it roughly gives you a look at how airflow works. Maybe you can get it behaving like it should?

To spin it all up:

```bash
$ cd /home/vagrant/airflow

# this will run and exit with 0 if successful
$ docker-compose up airflow-init

$ docker-compose up
```
This will spin up all services and you should then navigate to https://localhost:8080 and log in with `airflow` for both the username and password. You can then trigger the run by Unpausing the `etl_pipeline` in the DAGS menu, or clicking the play button to the right hand side of the `etl_pipeline` row.

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

## Airflow Architecture concepts

_Adapted from [Airflow Docs](https://airflow.apache.org/docs/apache-airflow/stable/concepts/overview.html)_

Airflow is a tool that lets you build and run **workflows** which are based on a **directed-acyclic-graph** which contain individual **tasks** which have dependencies and data flows.

The **DAG** specifies all **task** dependencies, the order of tasks, and whether to attempt retries. The **tasks** describe themselves and their specific job be it fetching data, running analysis, detecting a change.

### Airflow components

![](https://airflow.apache.org/docs/apache-airflow/stable/_images/arch-diag-basic.png)

General components of an Airflow installation:

- A scheduler, handles triggering scheduled workflows, and submitting tasks to executors
- An executor, handles running tasks, can be run inside the scheduler, or in production pushes tasks out to workers to run
- A webserver, presents the UI
- A folder of DAG files, to be read by the scheduler and executor
- A metadata database, used by the scheduler, executor and webserver to store state

### Task types

A task may be one of a number of common types:

- An [Operator](https://airflow.apache.org/docs/apache-airflow/stable/concepts/operators.html), a predefined template for a task that can quickly be configured 
- A [Sensor](https://airflow.apache.org/docs/apache-airflow/stable/concepts/sensors.html) task, a task that waits for something to occur, once they succeed they allow downstream tasks to run
- A [TaskFlow](https://airflow.apache.org/docs/apache-airflow/stable/concepts/taskflow.html), a pure python function that uses the `@task` decorator and takes care of extra DAG boilerplate

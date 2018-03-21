# Jenkins-ansible-docker proof of concept
POC to orchestrate tests by using Jenkins + Ansible executed by our beloved Pyroute Testing Automation Framework Edit
Add topics

## Getting Started

Make sure you run Jenkins server as sudo, in order to let ansible perform all the indicated tasks.
Make sure you have the right packages for ansible by checking the python version ansible is using.

### Prerequisites

Any python version is sufficients as long as it matches the version of ansible you got.
We recommend the latest version of Ansible.
Python package installes tool pip.
Docker, and selenium server standalone with firefox image.
Openjdk version "1.8.0_151"

```
sudo java -jar jenkins.war --httpPort=8080
```
This command make jenkins server go up and running. The address to start the set up is `localhost:8080`

```
docker pull mariobd7/prueba_5:first
``` 
With this command we download the image used by ansible

```
docker pull selenium/standalone-firefox:3.10.0-argon
```

This line allow us to download of the selenium server stand-alone.

Ideally, one could run the ansible playbook with the following line:

```
ansible-playbook dockerplayb.yml --extra-vars "ansible_sudo_pass=YOUR_ACTUAL_PASSWORD"
```
and then excute:

```
docker exec -ti ansible_container pyroute run
```

This should be enough in order to perform a basic test on a file already in place. One thing to improve.

### Set up of Jenkins
Make sure you have the ansible, docker and git plugins.

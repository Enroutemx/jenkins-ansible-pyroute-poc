FROM ubuntu:latest

# SETTING UP ENVIRONMENT

COPY ./ /root/pyroute
WORKDIR /root/pyroute

# INSTALLING REQUIRED PACKAGES

RUN apt-get update && apt-get install -y \
xauth \
nano \
unzip \
python \
wget \
software-properties-common \
acl \
curl \
firefox \
dbus-x11 \
libcanberra-gtk*

# Installing python 3.6 and pipenv
RUN add-apt-repository -y ppa:jonathonf/python-3.6
RUN apt-get update
RUN apt-get -y install python3.6
RUN apt -y install python3-pip
RUN pip3 install pipenv==8.2.7

# Installing Geckodriver
RUN wget https://github.com/mozilla/geckodriver/releases/download/v0.19.1/geckodriver-v0.19.1-linux64.tar.gz
RUN sh -c 'tar -x geckodriver -zf geckodriver-v0.19.1-linux64.tar.gz -O > /bin/geckodriver'
RUN chmod +x /bin/geckodriver
RUN rm geckodriver-v0.19.1-linux64.tar.gz

# Installing Seleninum standalone

RUN wget "https://selenium-release.storage.googleapis.com/3.5/selenium-server-standalone-3.5.0.jar" && \
mv selenium-server-standalone-3.5.0.jar /bin/selenium-standalone.jar && \
chmod +x /bin/selenium-standalone.jar

ENV LANG=C.UTF-8
ENV LC_ALL=C.UTF-8
RUN cd pyroute/
RUN pip3 install --editable pyroute/

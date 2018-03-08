FROM ubuntu:latest

# SETTING UP ENVIRONMENT

COPY ./ /root/pyroute
WORKDIR /root/pyroute


# INSTALLING REQUIRED PACKAGES

RUN apt-get update && apt-get install -y \
xauth \
nano \
unzip \
default-jdk \
python \
wget \
software-properties-common \
acl \
curl \
firefox \
dbus-x11 \
libcanberra-gtk*
RUN xauth add $(cat magic-cookie)


# Installing python 3.6 and pipenv
RUN add-apt-repository -y ppa:jonathonf/python-3.6
RUN apt-get update
RUN apt-get -y install python3.6
RUN apt -y install python-pip
RUN pip install pipenv==8.2.7

# Installing Geckodriver
RUN wget https://github.com/mozilla/geckodriver/releases/download/v0.19.1/geckodriver-v0.19.1-linux64.tar.gz
RUN sh -c 'tar -x geckodriver -zf geckodriver-v0.19.1-linux64.tar.gz -O > /bin/geckodriver'
RUN chmod +x /bin/geckodriver
RUN rm geckodriver-v0.19.1-linux64.tar.gz

# Installing Chromedriver
RUN wget "http://chromedriver.storage.googleapis.com/2.35/chromedriver_linux64.zip"
RUN unzip chromedriver_linux64.zip
RUN mv chromedriver /bin/chromedriver
RUN chmod +x /bin/chromedriver
RUN rm chromedriver_linux64.zip

# Installing Seleninum standalone

RUN wget "https://selenium-release.storage.googleapis.com/3.5/selenium-server-standalone-3.5.0.jar" && \
mv selenium-server-standalone-3.5.0.jar /bin/selenium-standalone.jar && \
chmod +x /bin/selenium-standalone.jar

# Installing Chrome

RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -
RUN echo 'deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main' | tee /etc/apt/sources.list.d/google-chrome.list
RUN apt-get update
RUN apt-get -y install google-chrome-stable
RUN sed -i "49s|$| --no-sandbox|" /opt/google/chrome/google-chrome

# Creating startup file

RUN touch startup.sh
RUN echo "#!/bin/sh" >> startup.sh
RUN echo "pipenv --python 3.6" >> startup.sh
RUN echo "cd pyroute/" >> startup.sh
RUN echo "pipenv install --system" >> startup.sh
RUN echo "pipenv install --dev" >> startup.sh
RUN echo "export LC_ALL=C.UTF-8" >> startup.sh
RUN echo "export LANG=C.UTF-8" >> startup.sh
RUN echo "export SHELL=/bin/bash" >> startup.sh
RUN echo "java -jar /bin/selenium-standalone.jar &" >> startup.sh
RUN echo "pipenv shell" >> startup.sh
RUN chmod +x startup.sh

# Deleting unnecesary files
RUN rm /root/pyroute/magic-cookie

# Starting up the virtual environment of pyroute
ENTRYPOINT ["./startup.sh"]


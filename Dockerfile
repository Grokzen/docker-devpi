FROM phusion/baseimage:0.9.15

# Ensure UTF-8 lang and locale
RUN locale-gen en_US.UTF-8
ENV LANG       en_US.UTF-8
ENV LC_ALL     en_US.UTF-8
ENV DEBIAN_FRONTEND noninteractive

# Initial update and install of dependency that can add apt-repos
RUN apt-get update -qqy && apt-get install -qqy software-properties-common python-software-properties wget

# Update repo list and install all new packages that can be upgraded
RUN add-apt-repository -y "deb http://archive.ubuntu.com/ubuntu precise universe" && \
    add-apt-repository -y "deb http://archive.ubuntu.com/ubuntu precise main restricted universe multiverse" && \
    add-apt-repository -y "deb http://archive.ubuntu.com/ubuntu precise-updates main restricted universe multiverse" && \
    add-apt-repository -y "deb http://archive.ubuntu.com/ubuntu precise-backports main restricted universe multiverse"
RUN apt-get -qqy update && apt-get -qqy --force-yes upgrade && echo "UPDATED 2014-11-25"

# Install python
RUN apt-get update -q && apt-get install -y netbase python

# Update pip to latest version
ADD https://raw.github.com/pypa/pip/master/contrib/get-pip.py /get-pip.py    
RUN python /get-pip.py

RUN pip install devpi-server devpi-client requests

EXPOSE 3141
ADD run.sh /
CMD ["/run.sh"]

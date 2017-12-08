# base image
FROM python:3

# update and install
RUN apt-get update && apt-get install -y \
  curl \
  openssl \
  nano \
  wget \
  vim

# copy source
WORKDIR /usr/src
COPY tinderGetPhotos.py .
COPY scrape.sh .
COPY requirements.txt .

# install requirements
RUN pip install -r requirements.txt

# link tndrscrpr
RUN ln /usr/src/scrape.sh /usr/bin/scrape

# make working dir
RUN mkdir -p /home/tndrscrpr
WORKDIR /home/tndrscrpr

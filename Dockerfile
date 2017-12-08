# base image
FROM python:3

# update and install
RUN apt-get update && apt-get install -y \
  curl \
  lynx \
  nano \
  openssl \
  pandoc \
  wget \
  vim

# copy source
WORKDIR /usr/src
COPY README.md .
COPY tinderGetPhotos.py .
COPY scrape.sh .
COPY extract_token.sh .
COPY requirements.txt .

# install requirements
RUN pip install -r requirements.txt

# link scripts
RUN ln /usr/src/scrape.sh /usr/bin/scrape
RUN ln /usr/src/extract_token.sh /usr/bin/extract_token

# setup env
ENV FACEBOOK_TOKEN=''
ENV FACEBOOK_ID=''
ENV TINDERPICS_DIR=''

# make working dir
RUN mkdir -p /home/tndrscrpr
WORKDIR /home/tndrscrpr

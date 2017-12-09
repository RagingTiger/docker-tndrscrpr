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

# install python requirements
RUN pip install -r requirements.txt

# link scripts
RUN ln /usr/src/scrape.sh /usr/bin/scrape
RUN ln /usr/src/extract_token.sh /usr/bin/extract_token

# setup env
ENV FACEBOOK_TOKEN=''
ENV FACEBOOK_ID=''
ENV TINDERPICS_DIR=''

# setup rc file
RUN printf "\n# functions for setting shell env variables\n" >> ~/.bashrc
RUN echo 'fbid(){ if [ "$1" ]; then export FACEBOOK_ID="$1"; fi }' >> ~/.bashrc
RUN echo 'fbtoken(){ if [ "$1" ]; then export FACEBOOK_TOKEN="$1"; fi }' >> \
          ~/.bashrc
RUN echo 'picdir(){ if [ "$1" ]; then export TINDERPICS_DIR="$1"; fi }' >> \ 
          ~/.bashrc
RUN echo 'set_token(){ if [ "$1" ]; then fbtoken $(extract_token "$1"); \
          fi }' >> ~/.bashrc

# make working dir
RUN mkdir -p /home/tndrscrpr
WORKDIR /home/tndrscrpr

FROM ubuntu:20.04

WORKDIR /usr/src/app/

# chromium
RUN apt-get update
RUN apt-get install -y default-jre
RUN apt-get install -y unzip
RUN apt-get install -y wget
RUN apt-get -f install
RUN apt-get install -y software-properties-common
RUN add-apt-repository universe
RUN apt-get -y update
RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -
RUN sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'
RUN apt-get -y update
RUN apt-get install -y google-chrome-stable
RUN ls /etc/apt/sources.list.d/google*
RUN rm -rf /etc/apt/sources.list.d/google.list
#RUN apt-get install -y google-chrome-stable
#apt-get install -y chromium-browser

RUN apt-get install -yqq unzip curl
RUN wget -O /tmp/chromedriver.zip http://chromedriver.storage.googleapis.com/`curl -sS chromedriver.storage.googleapis.com/LATEST_RELEASE`/chromedriver_linux64.zip
RUN unzip /tmp/chromedriver.zip chromedriver -d /usr/local/bin/ 

RUN apt-get install -y python3 python3-pip
RUN pip3 install selenium

# Node.js
RUN apt-get install -y curl
RUN curl -sL https://deb.nodesource.com/setup_14.x | bash
RUN apt-get install -y nodejs

COPY package*.json ./
RUN npm install -D
COPY . .
RUN mkdir -p ./dist
RUN npm run build


EXPOSE 80

CMD npm run start
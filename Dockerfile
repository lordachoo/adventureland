FROM node:16

# update base image
RUN apt-get update && apt-get upgrade -y

RUN apt-get install python2-dev -y

RUN apt-get install curl -y

RUN apt-get install git -y

RUN git clone https://github.com/kaansoral/adventureland-appserver appserver

RUN sed -i 's/192.168.1\\..?.?.?/192\\.168\\.(0\\.([1-9]|[1-9]\\d|[12]\\d\\d)|([1-9]|[1-9]\\d|[12]\\d\\d)\\.([1-9]?\\d|[12]\\d\\d))/' /appserver/sdk/lib/cherrypy/cherrypy/wsgiserver/wsgiserver2.py
RUN sed -i 's/allowed_ips=\[/allowed_ips=["^172\\.(16\\.0\\.([1-9]|[1-9]\\d|[12]\\d\\d)|16\\.([1-9]|[1-9]\\d|[12]\\d\\d)\\.([1-9]?\\d|[12]\\d\\d)|(1[7-9]|2\\d|3[01])(\\.([1-9]?\\d|[12]\\d\\d)){2})$",/g'  /appserver/sdk/lib/cherrypy/cherrypy/wsgiserver/wsgiserver2.py

RUN curl https://bootstrap.pypa.io/pip/2.7/get-pip.py --output get-pip.py

RUN python2 get-pip.py

RUN apt-get install libxml2-dev libxslt-dev

RUN pip install lxml

RUN mkdir adventureland && cd adventureland

COPY . /adventureland

WORKDIR /adventureland/scripts

RUN npm install

WORKDIR /adventureland/node

RUN npm install

EXPOSE 8082
EXPOSE 8083
EXPOSE 43291
EXPOSE 8000

RUN chmod +x /adventureland/docker-entrypoint.sh
RUN chmod +x /adventureland/node-entrypoint.sh

ENTRYPOINT ["/adventureland/docker-entrypoint.sh"]

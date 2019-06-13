FROM ubuntu:latest

COPY requirements.txt requirements.txt

RUN apt-get update && apt-get -y upgrade
RUN apt-get install -y build-essential python-dev
RUN apt-get install -y python2.7 python-distribute python-pip
RUN pip install --upgrade pip==9.0.3

RUN pip install -r requirements.txt

COPY . /csp
COPY ~/work/CSP/data /csp
WORKDIR /csp

EXPOSE 8888

CMD python ./app.py

FROM perl:5.20.0

RUN apt-get install -y netcat

COPY cpanfile /srv/basicapp/
WORKDIR /srv/basicapp

RUN cpanm local::lib
RUN cpanm -nq App::cpm

RUN eval $( perl -Mlocal::lib=./local )
RUN cpm install

COPY . /srv/basicapp

CMD ["perl", "-Mlocal::lib=local", "script/basic_app", "daemon"]

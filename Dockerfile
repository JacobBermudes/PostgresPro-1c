FROM ubuntu:jammy

LABEL maintainer="JacobBermudes"

VOLUME /var/lib/pgpro/1c-15/data

RUN apt-get update && apt-get install -y locales wget  \
        && locale-gen ru_RU ru_RU.UTF-8 en_US.UTF-8 \
        && update-locale LANG=ru_RU.UTF-8 

ENV LANG ru_RU.UTF-8 \
    PG_USER postgres \
    PG_DIR /var/lib/pgpro/1c-15 \
    PG_DATA ${PG_DIR}/data 

WORKDIR /tmp

RUN wget https://repo.postgrespro.ru/1c/1c-15/keys/pgpro-repo-add.sh \
        && DEBIAN_FRONTEND=noninteractive \
        && sh pgpro-repo-add.sh \
        && apt-get install -y postgrespro-1c-15      

COPY entrypoint.sh /sbin/entrypoint.sh

RUN chmod 755 /sbin/entrypoint.sh

EXPOSE 5432/tcp

WORKDIR /var/lib/pgpro/1c-15

ENTRYPOINT ["entrypoint.sh"]

CMD ["postgres"]

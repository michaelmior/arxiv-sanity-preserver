FROM python:2.7-alpine

RUN echo -e 'http://dl-cdn.alpinelinux.org/alpine/edge/community' >> /etc/apk/repositories

RUN apk add --update --no-cache \
        imagemagick \
        poppler-utils \
        openblas-dev \
        build-base \
    && ln -s /usr/include/locale.h /usr/include/xlocale.h \
    && pip install --upgrade pip \
    && pip install virtualenv

COPY . /app

RUN virtualenv /app/env \
    && /app/env/bin/pip install -r /app/requirements.txt

WORKDIR /app

EXPOSE 80
CMD ["./env/bin/python", "serve.py", "--prod", "--port", "80"]

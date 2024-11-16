FROM python:3.13.0-alpine

ARG SHODO_PYTHON_VERSION=1.1.0

RUN pip install -U pip
RUN pip install shodo=="${SHODO_PYTHON_VERSION}"

RUN mkdir -p /root/.config/shodo

ENV XDG_CONFIG_HOME=/

WORKDIR /shodo

ENTRYPOINT ["shodo"]

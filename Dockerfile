FROM python:3.13.3-alpine

ARG SHODO_PYTHON_VERSION=1.1.0

RUN pip install -U pip
RUN pip install shodo=="${SHODO_PYTHON_VERSION}"

ENV XDG_CONFIG_HOME=/

WORKDIR /shodo

ENTRYPOINT ["shodo"]

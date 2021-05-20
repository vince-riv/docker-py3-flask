# syntax=docker/dockerfile:1
FROM python:3.8-slim
# COPY . /app
# RUN make /app
#CMD python /app/app.py

COPY requirements.txt /

RUN set -ex; \
  pip install -r /requirements.txt; \
  mkdir /app

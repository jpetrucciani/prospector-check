FROM python:3.11-alpine

LABEL "maintainer"="Jacobi Petrucciani <j@cobi.dev>"

ADD requirements.txt /requirements.txt
ADD entrypoint.sh /entrypoint.sh
ADD github.py /github.py

RUN apk add gcc musl-dev && \
    pip install -r requirements.txt && \
    pip install pylint==2.15.6  # this is pinned to stop the broken lookup

ENTRYPOINT ["/entrypoint.sh"]

FROM python:3.11-alpine

LABEL "maintainer"="Jacobi Petrucciani <j@cobi.dev>"

ADD requirements.txt /requirements.txt
ADD entrypoint.sh /entrypoint.sh
ADD github.py /github.py

RUN apk add gcc musl-dev && \
    pip install -r requirements.txt && \
    pip install bandit==1.7.4 && \
    pip install vulture==2.6 && \
    pip install mypy==0.991 && \
    pip install pyroma==4.1

ENTRYPOINT ["/entrypoint.sh"]

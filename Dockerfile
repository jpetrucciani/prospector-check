FROM python:3.13-slim-bookworm

LABEL "maintainer"="Jacobi Petrucciani <j@cobi.dev>"

ADD requirements.txt /requirements.txt
ADD entrypoint.sh /entrypoint.sh
ADD github.py /github.py

RUN pip install -r requirements.txt

ENTRYPOINT ["/entrypoint.sh"]

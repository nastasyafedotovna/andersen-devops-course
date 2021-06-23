FROM alpine:3.14
MAINTAINER Gizar Zigangirov 'gizar.zigangirov@gmail.com'
COPY flask_app.py .
RUN apk add --no-cache python3 && \
    if [ ! -e /usr/bin/python ]; then ln -sf python3 /usr/bin/python ; fi && \
    python3 -m ensurepip && \
    rm -r /usr/lib/python*/ensurepip && \
    pip3 install --no-cache --upgrade pip setuptools wheel && \
    if [ ! -e /usr/bin/pip ]; then ln -s pip3 /usr/bin/pip ; fi && \
    pip3 install --no-cache flask==2.0.0 emoji==1.2.0
ENTRYPOINT ["python3"]
CMD ["flask_app.py"]

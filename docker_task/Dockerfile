FROM python:3.9-alpine AS build-stage
COPY requirements.txt flask_app.py ./
RUN pip3 install -r requirements.txt && \
    rm -rf /.cache/* /tmp/* /var/cache/apk/* \
    /lib/libcrypto.so.1.1 /lib/libssl.so.1.1 /etc/ssl/*  \
    /usr/lib/python*/ensurepip /usr/local/include/python*/* \
    /usr/local/lib/python*/idlelib/* /usr/local/lib/python*/ensurepip \
    /usr/local/lib/python*/xml/* /usr/local/lib/python*/xmlrpc/* \
    /usr/local/lib/python*/asyncio/* /usr/local/lib/python*/ctypes/* \
    /usr/local/share/* /usr/share/ca-certificates/* /usr/local/lib/python*/lib2to3/* \
    /usr/local/lib/python*/sqlite3/* /usr/local/lib/python*/distutils/* \
    /usr/local/lib/python*/__pycache__/* /usr/local/lib/python*/*/pip/* \
    /usr/local/lib/python*/*/wheel/* /usr/local/lib/python*/*/setuptools/* \
    /usr/local/lib/python*/*/pkg_resources/* /usr/local/lib/python*/turtledemo/* \
    /usr/local/lib/python*/concurrent/* /usr/local/lib/python*/unittest/* \
    /usr/local/lib/python*/multiprocessing/* /usr/local/lib/python*/pydoc_data/* \
    /usr/local/lib/python*/*/werkzeug/debug* /usr/local/lib/python*/*/werkzeug/middleware* \
    /usr/local/lib/python*/site-packages/*/__pycache__/*


FROM alpine
MAINTAINER Gizar Zigangirov 'gizar.zigangirov@gmail.com'
COPY --from=build-stage . .
ENTRYPOINT ["python3"]
CMD ["flask_app.py"]

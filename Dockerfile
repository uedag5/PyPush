FROM python:2.7

ENV PORT=5000
ENV DEVICE="/dev/ttyACM*"
ENV APPLICATION_ROOT=""

RUN mkdir -p /usr/src
COPY ./ /usr/src/PyPush

RUN mkdir /usr/src/PyPush/host_mounted
VOLUME [ "/usr/src/PyPush/host_mounted" ]
WORKDIR /usr/src/PyPush

RUN rm -rf .git
RUN pip install --no-cache-dir -r requirements.txt

EXPOSE $PORT
CMD [ "sh", "-c", "./bin/serve.sh --host 0.0.0.0 --port \"${PORT}\" --ble_device \"${DEVICE}\" --application_root \"${APPLICATION_ROOT}\" --db_uri \"sqlite:////usr/src/PyPush/host_mounted/py_push_db.sqlite\" " ]
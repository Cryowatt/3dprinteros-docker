ARG BALENA_MACHINE_NAME=raspberrypi3
FROM balenalib/${BALENA_MACHINE_NAME}-alpine:build AS download
RUN apk add unzip
RUN wget https://client-cdn-3dprinteros.azureedge.net/releases/3DPrinterOS_Client_6.0.15stable.105_stable.zip -O /tmp/3DPrinterOS_Client_6.0.15stable.105_stable.zip
RUN unzip /tmp/3DPrinterOS_Client_6.0.15stable.105_stable.zip -d /opt/3dprinteros
RUN chmod +x /opt/3dprinteros/launcher.py

ARG BALENA_MACHINE_NAME=raspberrypi3
FROM balenalib/${BALENA_MACHINE_NAME}-ubuntu-python:2.7-xenial
WORKDIR /opt/3dprinteros
COPY --from=download /opt/3dprinteros .
RUN sed -i 's/^REMOTE_IP\s=\s".*"/REMOTE_IP = "0.0.0.0"/' config.py
CMD [ "/opt/3dprinteros/launcher.py" ]
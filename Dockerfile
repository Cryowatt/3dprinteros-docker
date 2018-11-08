FROM alpine AS package
RUN apk add unzip
ADD https://client-cdn-3dprinteros.azureedge.net/releases/3DPrinterOS_Client_6.0.16.107_dev.zip 3dprinteros_client.zip
RUN unzip 3dprinteros_client.zip -d extract

FROM resin/raspberrypi3-ubuntu-python:2.7.15-xenial
RUN apt-get update && apt-get install -y --no-install-recommends \
    python-numpy \
    xterm \
    && rm -rf /var/lib/apt/lists/*
COPY --from=package extract /opt/3dprinteros-client
WORKDIR /opt/3dprinteros-client/
ENTRYPOINT [ "python", "launcher.py" ]
EXPOSE 80
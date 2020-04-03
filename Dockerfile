# syntax=docker/dockerfile-upstream:experimental
FROM alpine AS package
RUN apk add unzip
ARG CLIENT_VERSION
ADD https://client-cdn-3dprinteros.azureedge.net/releases/3DPrinterOS_Client_${CLIENT_VERSION}.zip 3dprinteros_client.zip
RUN unzip 3dprinteros_client.zip -d extract

FROM python:2.7
RUN apt-get update && apt-get install -y --no-install-recommends \
	libopencv-dev \
    libusb-dev \
    python-numpy \
	python-opencv \
    xterm \
    && apt-get clean
COPY --from=package extract /opt/3dprinteros-client
WORKDIR /opt/3dprinteros-client/
RUN sed -i 's/^REMOTE_IP\s=\s".*"/REMOTE_IP = "0.0.0.0"/' config.py
ENTRYPOINT [ "python", "launcher.py" ]
EXPOSE 80 443
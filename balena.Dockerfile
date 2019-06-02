ARG BALENA_MACHINE_NAME=raspberrypi3
FROM balenalib/${BALENA_MACHINE_NAME}-alpine:build AS download
RUN wget https://client-cdn-3dprinteros.azureedge.net/releases/3DPrinterOS_Client_6.0.15stable.105_stable.deb -O /tmp/3DPrinterOS_Client_6.0.15stable.105_stable.deb

ARG BALENA_MACHINE_NAME=raspberrypi3
FROM balenalib/${BALENA_MACHINE_NAME}-ubuntu:run
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install --yes --no-install-recommends \
    python2.7 \
	python-opencv \
	python-numpy \
    xterm
COPY --from=download /tmp/3DPrinterOS_Client_6.0.15stable.105_stable.deb /tmp/3DPrinterOS_Client_6.0.15stable.105_stable.deb
RUN dpkg -i /tmp/3DPrinterOS_Client_6.0.15stable.105_stable.deb
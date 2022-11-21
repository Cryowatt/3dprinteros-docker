# syntax=docker/dockerfile:1

FROM buildpack-deps AS package
ARG CLIENT_VERSION
ADD "https://client-cdn-3dprinteros.azureedge.net/releases/3DPrinterOS_Client_${CLIENT_VERSION}_stable3.zip" "3dprinteros_client.zip"
RUN unzip 3dprinteros_client.zip -d extract

FROM python:3-slim-bullseye
RUN apt-get update && apt-get install -y --no-install-recommends \
#     gfortran \
#     libsm6 \
# 	libglib2.0-0 \
    libusb-1.0-0 \
#     libxext6 \
#     libxrender-dev \
#     net-tools \
#     procps \
#     python3-opencv \
    && apt-get clean
COPY --from=package extract /opt/3dprinteros-client
WORKDIR /opt/3dprinteros-client/
# RUN python -m pip install --target . \
#     numpy \
#     #opencv-python \
#     pyserial \
#     requests
RUN sed -i 's/^REMOTE_IP\s=\s".*"/REMOTE_IP = "0.0.0.0"/' config.py
ENTRYPOINT [ "python", "launcher.py" ]
EXPOSE 80 443

# FROM python:2.7-slim-buster AS python2
# RUN apt-get update && apt-get install -y --no-install-recommends \
#     gfortran \
#     libsm6 \
# 	libglib2.0-0 \
#     libusb-1.0-0 \
#     libxext6 \
#     libxrender-dev \
#     net-tools \
#     procps \
#     python-opencv \
#     && apt-get clean
# COPY --from=package extract /opt/3dprinteros-client
# WORKDIR /opt/3dprinteros-client/
# RUN python -m pip install --target . numpy
# RUN python -m pip install --target . pyserial
# RUN python -m pip install --target . requests
#     #numpy \
#     ##opencv-python \
#     #pyserial \
#     #requests
# RUN sed -i 's/^REMOTE_IP\s=\s".*"/REMOTE_IP = "0.0.0.0"/' config.py
# ENTRYPOINT [ "python", "launcher.py" ]
# EXPOSE 80 443
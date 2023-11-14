FROM node:21-bookworm
ARG LENS_VERSION=6.5.2-366

ENV DISPLAY=:0
ENV PORT=8080
ENV DEBIAN_FRONTEND=noninteractive

COPY --from=mattipaksula/wait-for:sha-2a34cde /wait-for /usr/bin

RUN apt-get update && apt-get install -y \
  curl git \
  xvfb x11vnc \
  libnss3 libglib2.0-0 libgdk-pixbuf2.0-0 libgtk-3-0 libx11-xcb1 libasound2 libxss1 libgbm1

WORKDIR /opt
RUN git clone https://github.com/novnc/websockify-js.git \
  && cd websockify-js/websockify && npm install

RUN curl -LO https://github.com/MuhammedKalkan/OpenLens/releases/download/v${LENS_VERSION}/OpenLens-${LENS_VERSION}.x86_64.AppImage

RUN  chmod +x OpenLens-${LENS_VERSION}.x86_64.AppImage \
  && ./OpenLens-${LENS_VERSION}.x86_64.AppImage --appimage-extract \
  && mv ./squashfs-root /opt/lens

WORKDIR /app
COPY app .

ENTRYPOINT [ "/app/entrypoint.sh" ]

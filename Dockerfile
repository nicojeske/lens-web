FROM jlesage/baseimage-gui:debian-11-v4
ARG LENS_VERSION=6.5.2-366

RUN add-pkg curl libnss3 libglib2.0-0 libgdk-pixbuf2.0-0 libgtk-3-0 libx11-xcb1 libasound2 libxss1 libgbm1

RUN  curl -LOk https://github.com/MuhammedKalkan/OpenLens/releases/download/v${LENS_VERSION}/OpenLens-${LENS_VERSION}.x86_64.AppImage \
  && mv OpenLens-${LENS_VERSION}.x86_64.AppImage lens.AppImage \
  && chmod +x lens.AppImage \
  && ./lens.AppImage --appimage-extract \
  && mv squashfs-root /opt/lens \
  && chmod +x /opt/lens/open-lens \
  && rm lens.AppImage \
  && take-ownership /opt/lens

RUN set-cont-env APP_NAME "Lens"

COPY startapp.sh /startapp.sh
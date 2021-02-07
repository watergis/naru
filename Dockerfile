FROM node:12
WORKDIR /usr/src/app

RUN apt-get update && apt-get -y upgrade &&\
  apt-get install -y \
  curl \
  autoconf \
  automake \
  libboost-program-options-dev \
  libbz2-dev \
  cmake \
  expat \
  gdal-bin \
  git \
  libsqlite3-dev \
  libtool \
  nginx \
  nodejs \
  pandoc \
  rapidjson-dev \
  ruby \
  sqlite3 \
  tmux \
  vim \
  xrdp \
  yarn \
  zip \
  zlib1g-dev

RUN apt-get install -y \
  libnss3-tools \
  linuxbrew-wrapper && \
  brew install mkcert

RUN mkdir osmium &&\
  cd osmium &&\
  git clone https://github.com/mapbox/protozero &&\
  git clone https://github.com/osmcode/libosmium &&\
  git clone https://github.com/osmcode/osmium-tool &&\
  cd osmium-tool &&\
  mkdir build &&\
  cd build &&\
  cmake .. &&\
  make  &&\
  make install &&\
  cd /usr/src/app &&\
  rm -rf usmium

RUN git clone https://github.com/mapbox/tippecanoe &&\
  cd tippecanoe; make -j3 LDFLAGS="-latomic"; make install; cd .. &&\
  rm -rf tippecanoe

RUN yarn global add browserify budo hjson pm2 rollup @mapbox/mapbox-gl-style-spec @pushcorn/hocon-parser

RUN git clone https://github.com/ibesora/vt-optimizer &&\
  cd vt-optimizer; npm install; cd ..

RUN gem install mdless hocon launchy

COPY . /usr/src/app/

WORKDIR /usr/src/app/

RUN rake inet:install

CMD ["/bin/bash"]
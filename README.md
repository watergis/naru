*This project is not actively maintained at present. However, opteo/kokoromi-\* series are developed using naru.*

# naru
Vector Tile Academy (VTA) code for Raspberry Pi

# Background
This repository is the Raspberry Pi implementation for [Vector Tile Academy](https://unvt.github.io/vta).

# Use
Log in to your Raspbian and then execute the following.

## Install and download (requires internet connection)
```zsh
curl -sL https://unvt.github.io/equinox/install.sh | bash -
git clone https://github.com/unvt/naru.git
cd naru
rake inet:install # install extra software
vi .env #specify OSM regison and area for tiles
set -a && source .env && set +a
rake inet:download # donwload source geospatial data for exercise
```

## First time exercise
```zsh
rake tiles
rake style
rake host
```

## Advanced exercise
```zsh
rake inet:mbgljs
rake js
rake inet:fonts
rake inet:sprite
rake optimizer
rake shaver
```

## Shutdown Raspberry Pi
```zsh
sudo poweroff
```
Now it is OK to disconnect Raspberry Pi. 

# Implementation details
## List of software installed by `rake inet:install`
### Node.js
- [@mapbox/vtshaver](https://github.com/mapbox/vtshaver)
### Ruby
- [mdless](https://github.com/ttscoff/mdless)
- [launchy](https://rubygems.org/gems/launchy)
### SSL for localhsot
- [mkcert](https://github.com/FiloSottile/mkcert)
### policy
the list shall be minimized, moving items to `equinox`.

## Run on Docker

- for creating `tiles.mbtiles` from the latest osm.pbf
```
docker build . --tag unvt/naru
docker run -v $(pwd):/usr/src/app -it unvt/naru

cd /usr/src/app
vi .env #specify OSM regison and area for tiles
set -a && source .env && set +a
rake inet:download # download osm.obf
rake tiles # create mbtiles under src folder
rake style # create style.json
```

- for hosting tiles after creating by UNVT
```
docker build . --tag unvt/naru
cp .env.example .env
vi .env # specify your target REGION and AREA on .env file
docker-compose up
```

# About the name
*naru* means "to be implemented" in traditional Japanese. It was taken from "いづ方をも捨てじと心にとり持ちては、一事もなるべからず" of 徒然草 一八八, which roughly means "If you try to take care of everything, nothing can be implemented." 

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
rake inet:download # donwload source geospatial data for exercise
rake inet:sprite # download and generate sprite files
```

## First time exercise
```zsh
rake inet:download # download osm.pbf
rake inet:mbgljs # download mapbox-gl-js package
rake js # rollup javascript code
rake inet:sprite # download maki and build sprite
rake inet:fonts # download fonts and create glyphs
rake tiles # create mbtiles under src folder
rake style # create style.json
rake host # host unvt on budo
```

## Advanced exercise
```zsh
rake inet:mbgljs
rake js
rake inet:fonts
rake inet:sprite
rake optimizer # analyze tiles.mbtiles
rake shaver
rake maputnik:start # launch maputnik editor on localhost:8888
rake maputnik:open # open style.json by maputnik editor
rake maputnik:stop # stop mapunik editor server
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
- [vt-optimizer](https://github.com/ibesora/vt-optimizer)
### Ruby
- [mdless](https://github.com/ttscoff/mdless)
- [launchy](https://rubygems.org/gems/launchy)
- [dotenv](https://github.com/bkeepers/dotenv)
### policy
the list shall be minimized, moving items to `equinox`.

## Run on Docker

- for creating `tiles.mbtiles` from the latest osm.pbf
```zsh
docker build . --tag unvt/naru
docker run -v $(pwd):/usr/src/app -p 9966:9966 -it unvt/naru

cd /usr/src/app
vi .env #specify OSM regison and area for tiles
rake inet:download # download osm.pbf
rake inet:mbgljs # download mapbox-gl-js package
rake js # rollup javascript code
rake inet:sprite # download maki and build sprite
rake inet:fonts # download fonts and create glyphs
rake tiles # create mbtiles under src folder
rake style # create style.json
rake optimizer # analyze tiles.mbtiles
```

- for hosting tiles after creating by UNVT
```
docker build . --tag unvt/naru
cp .env.example .env
vi .env # specify your target REGION and AREA on .env file
docker-compose up
```

## Edit style.json on [maputnik editor](https://github.com/maputnik/editor)

### A. Use docker-compose

```
docker-compose up
```

Then, open the below URL in your browser.
```
http://localhost:8888?style=http://localhost:9966/style.json
```

### B. Manually launch maputnik editor locally

1. launch budo to host tiles and style.json
```zsh
rake host 
```
Before run `rake host`, make sure all of components (tiles, style.json, sprite, glyphs, js) are generated under `docs` folder.

2. Use different terminal to launch maputnik editor server with port 8888
```zsh
rake maputnik:start
```
It will launch `maputnik editor` by using Docker, so it can't run without installing Docker on the machine.

3. Open editor with style.json
```zsh
rake maputnik:open
```

4. Make sure stopping maputnik editor server after editing style.json
```zsh
rake maputnik:stop
```

# About the name
*naru* means "to be implemented" in traditional Japanese. It was taken from "いづ方をも捨てじと心にとり持ちては、一事もなるべからず" of 徒然草 一八八, which roughly means "If you try to take care of everything, nothing can be implemented." 

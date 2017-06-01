Author: @mrummuka

Description: Docker image for minimal *remote* execution of geo-* Linux geocaching tools (tools by Rick Rickhardson).

# Usage:

## Prepare image
Downloads and installs necessary dependencies, builds geo-* tools and installs them into Docker container

### Clone repo
`$ git clone git@github.com:mrummuka/geo-tools-docker-rest.git`

### Set config
* Create/edit .georc config file (geo-* tools require credentials to enable logging in) before building image and place it to same directory

### Build image
`$ docker build -t mrummuka/geo-tools-docker-rest .`

## Running
### Start container
`$ docker run --rm --restart=always mrummuka/geo-tools-docker-rest`

### Run scripts through rest apis (atm, only geo-gid supported)
* With Web browser / your code / curl call
* http://<docker_ip>:9900/geo/gid/<gccode>?format=<outputformat>, where
..* gccode = gid e.g. GC40 (obs! only CAPITALS allowed )
..* outputformat = one of the formats supported by geo-gid -o

For example, to get geocache data for "Shortcut to Subway (GC4N37J)" in csv format, presuming that
container is started and running at 172.17.0.2 and username/password was correctly configured in .georc
then browsing to
http://172.17.0.2:9900/geo/gid/GC4N37J?format=unicsv
should produce
```json
{ "message" : "OK",
  "result" : {
    "format" : "text",
    "message" : "OK",
    "result" : "No,Latitude,Longitude,Name,Description,Symbol,URL,Container,Terrain\r\n1,60.156450,24.721667,\"GC4N37J\",\"Shortcut to subway by sm07\",\"Geocache\",\"24.721667http://www.geocaching.com/seek/cache_details.aspx?log=y\u0026wp=GC4N37J\",\"Unknown\",5.0"
    },
  "status" : 200
}
```


# See also
* Docker wrapper for geo-* tools (executable from command-line) here https://github.com/mrummuka/geo-tools-docker
* Origin of geo-* (Linux geocaching) tools:  http://geo.rkkda.com/

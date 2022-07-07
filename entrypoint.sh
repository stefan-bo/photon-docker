#!/bin/bash


# Download elasticsearch index
if [ ! -d "/photon/photon_data/elasticsearch" ]; then
    echo "Downloading search index"

    # Let graphhopper know where the traffic is coming from
    USER_AGENT="docker: thomasnordquist/photon-geocoder"
    # Download whole planet
    # wget --user-agent="$USER_AGENT" -O - http://download1.graphhopper.com/public/photon-db-latest.tar.bz2 | bzip2 -cd | tar x
    # Download only Germany
    wget --user-agent="$USER_AGENT" -O - https://download1.graphhopper.com/public/extracts/by-country-code/de/photon-db-de-latest.tar.bz2 | bzip2 -cd | tar x
fi

# Start photon if elastic index exists
if [ -d "/photon/photon_data/elasticsearch" ]; then
    echo "Start photon"
    java -Xms2g -Xmx2g -jar photon.jar -cors-any $@
else
    echo "Could not start photon, the search index could not be found"
fi

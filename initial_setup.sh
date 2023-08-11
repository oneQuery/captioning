#!/bin/bash

FILE_ID="1q7K0Tv43dkEjN4fU-UmpQ-pzfP6i8_8-"
DESTINATION="videos.zip"
UNZIP_DESTINATION="videos"  # Directory where you want to unzip the files

# Check if the file already exists
if [ ! -f "${DESTINATION}" ]; then
    CONFIRM=$(curl -sc /tmp/gcookie "https://drive.google.com/uc?export=download&id=${FILE_ID}" | grep -o 'confirm=[^&]*' | sed 's/confirm=//')
    curl -Lb /tmp/gcookie "https://drive.google.com/uc?export=download&confirm=${CONFIRM}&id=${FILE_ID}" -o ${DESTINATION}
    echo "File downloaded as ${DESTINATION}"
else
    echo "${DESTINATION} already exists. Skipping download."
fi

# Unzip the downloaded file
if [ -f "${DESTINATION}" ]; then
    unzip -o "${DESTINATION}" -d "${UNZIP_DESTINATION}"
    echo "Unzipped the file to ${UNZIP_DESTINATION}"
fi

pip install -r requirements.txt

#!/bin/sh

for dir in ./playlists/*
do
    cd "${dir}"
    ./_download.sh
    cd ../..
done

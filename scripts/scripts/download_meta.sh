#!/bin/bash


wget -nc https://storage.googleapis.com/openimages/2018_04/train/train-annotations-bbox.csv -P /opt/data/meta
wget -nc https://storage.googleapis.com/openimages/2018_04/validation/validation-annotations-bbox.csv -P /opt/data/meta
wget -nc https://storage.googleapis.com/openimages/2018_04/test/test-annotations-bbox.csv -P /opt/data/meta
wget -nc https://storage.googleapis.com/openimages/2018_04/class-descriptions-boxable.csv -P /opt/data/meta

wget -nc http://pjreddie.com/media/files/darknet53.conv.74 -P /opt/data/meta
#!/bin/bash
set -e

#
# Download the openimages csv files that describe the images
#
/opt/scripts/scripts/scripts/download_meta.sh

#
# Create a subset list based on the images we want
#
python3 /opt/scripts/scripts/scripts/subset_openimages.py /opt/data/meta/class-descriptions-boxable.csv /opt/data/meta/train-annotations-bbox.csv /opt/data/build/train_descriptions.csv

#
# Create a list of jpg files from the subset that we will download
#
cat /opt/data/build/train_descriptions.csv | cut -d \, -f 1 | sort | uniq | awk '{print $0".jpg"}' > /opt/data/build/subset-train-files.txt

#
# Download the subset
#
/opt/scripts/scripts/scripts/download_subset.sh

#
# 
#
python3 /opt/scripts/scripts/scripts/convert_annotations.py /opt/data/build/train_descriptions.csv /opt/data/train/


#
#
#
cd /opt/data/build/
ls /opt/data/train/*jpg > train.txt


echo "apple" > obj.names

echo "classes= 1
train  = /opt/data/build/train.txt
valid  = /opt/data/build/train.txt 
names = /opt/data/build/obj.names
backup = backup/" > obj.data



/darknet/darknet detector train /opt/data/build/obj.data /opt/scripts/yolov3-obj.cfg /opt/data/meta/darknet53.conv.74

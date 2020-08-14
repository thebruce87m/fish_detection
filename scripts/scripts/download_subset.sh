#!/bin/bash


# AWS is extremely slow for me and seems to have limited capability for
# downloading files individually. We therefore spawn N threads to download
# a batch of files at a time.

N=10 # Download batch size
(
for file in $(</opt/data/train_images_subset.txt); do 
   ((i=i%N)); ((i++==0)) && wait
   aws s3 --no-sign-request cp s3://open-images-dataset/train/$file /opt/data/train/ & 
done
)

aws s3 --no-sign-request sync s3://open-images-dataset/validation /opt/data/validation/
aws s3 --no-sign-request sync s3://open-images-dataset/test /opt/data/test/

cd /opt/data/

wget https://storage.googleapis.com/openimages/2018_04/train/train-annotations-bbox.csv
wget https://storage.googleapis.com/openimages/2018_04/validation/validation-annotations-bbox.csv
wget https://storage.googleapis.com/openimages/2018_04/test/test-annotations-bbox.csv
wget https://storage.googleapis.com/openimages/2018_04/class-descriptions-boxable.csv

echo "Done!"
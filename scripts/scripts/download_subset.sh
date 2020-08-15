#!/bin/bash


# AWS is extremely slow for me and seems to have limited capability for
# downloading files individually. We therefore spawn N threads to download
# a batch of files at a time.

N=10 # Download batch size
(
for file in $(</opt/data/build/subset-train-files.txt); do 
   ((i=i%N)); ((i++==0)) && wait
   if [ ! -f /opt/data/train/$file ]; then
     aws s3 --no-sign-request cp s3://open-images-dataset/train/$file /opt/data/train/ & 
   fi
done
)

#aws s3 --no-sign-request sync s3://open-images-dataset/validation /opt/data/validation/
#aws s3 --no-sign-request sync s3://open-images-dataset/test /opt/data/test/
FROM nvidia/cuda:9.1-cudnn7-devel-ubuntu16.04

RUN apt-get update && apt-get install -y wget git awscli python3-pip && apt-get clean && rm -rf /var/cache/apt
RUN apt-get -y autoremove && apt-get -y autoclean
RUN rm -rf /var/cache/apt

RUN pip3 install --upgrade pip
RUN pip3 install pandas
RUN python3 -m pip install -U matplotlib

RUN git clone https://github.com/pjreddie/darknet.git /darknet
WORKDIR /darknet
RUN sed -i s/GPU=0/GPU=1/g Makefile
RUN sed -i s/CUDNN=0/CUDNN=1/g Makefile
RUN sed -i s/OPENMP=0/OPENMP=1/g Makefile
RUN make
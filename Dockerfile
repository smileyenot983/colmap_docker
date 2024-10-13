# FROM nvidia/cuda:11.7.0-devel-ubuntu20.04
FROM nvidia/cuda:11.7.1-devel-ubuntu20.04

ENV DEBIAN_FRONTEND=noninteractive 

RUN apt-get update && apt-get install -y \
    git \
    cmake \
    ninja-build \
    build-essential \
    libboost-program-options-dev \
    libboost-filesystem-dev \
    libboost-graph-dev \
    libboost-system-dev \
    libeigen3-dev \
    libflann-dev \
    libfreeimage-dev \
    libmetis-dev \
    libgoogle-glog-dev \
    libgtest-dev \
    libsqlite3-dev \
    libglew-dev \
    qtbase5-dev \
    libqt5opengl5-dev \
    libcgal-dev \
    libceres-dev 
    

# \
# nvidia-cuda-toolkit \
# nvidia-cuda-toolkit-gcc

RUN apt-get install gcc-10 g++-10 -y
RUN export CC=/usr/bin/gcc-10
RUN export CXX=/usr/bin/g++-10
RUN export CUDAHOSTCXX=/usr/bin/g++-10

WORKDIR /home
RUN git clone https://github.com/colmap/colmap.git
WORKDIR /home/colmap
RUN mkdir build 
WORKDIR /home/colmap/build
# RUN ls
RUN cmake ..
RUN make
RUN make install 

RUN apt-get install -y python3.8 \
    python3-pip

COPY /images /home/images
COPY prep_data.py /home/prep_data.py
RUN chmod +x /home/prep_data.py

COPY run_colmap.py /home/run_colmap.py
RUN chmod +x /home/run_colmap.py
# CMD ["python3", "/home/run_colmap.py"]
RUN ls



# runs whole colmap(up to undistorted images)
# RUN colmap feature_extractor --image_path /home/images/input --database_path /home/images/database.db
# RUN colmap exhaustive_matcher --database_path home/images/database.db
# RUN mkdir home/images/sparse/
# RUN colmap mapper --database_path home/images/database.db --image_path home/images/input --output_path home/images/sparse/
# RUN colmap image_undistorter --image_path home/images/input --input_path /home/images/sparse/0/ --output_path home/images/dense




# 1. build: 
# sudo docker build -t docker_colmap:1 .
# 2. run:
# sudo docker run --rm --gpus all -it -v /home/zotac/colmap_docker/images/:/home/images/ docker_colmap:1

FROM resin/raspberry-pi-openjdk

RUN apt-get update
RUN apt-get install -y git
RUN apt-get install -y bluez
RUN apt-get install -y build-essential
RUN apt-get install -y cmake
RUN apt-get install -y pkg-config
RUN apt-get install -y libglib2.0-dev
RUN apt-get install -y doxygen

RUN mkdir app && \
    cd app && \
    git clone https://github.com/intel-iot-devkit/tinyb.git && \
    cd tinyb && \
    mkdir build && \
    cd build && \
    cmake .. && \
    make && \
    make install

CMD ["sleep", "30m"]

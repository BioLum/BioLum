FROM resin/raspberry-pi-openjdk

RUN mkdir /app

RUN apt-get update
RUN apt-get install -y git
RUN apt-get install -y libdbus-1-dev
RUN apt-get install -y libudev-dev
RUN apt-get install -y libical-dev
RUN apt-get install -y build-essential
RUN apt-get install -y cmake
RUN apt-get install -y pkg-config
RUN apt-get install -y libglib2.0-dev
RUN apt-get install -y doxygen

# Install bluez with experimental features
RUN cd /app && \
    wget https://www.kernel.org/pub/linux/bluetooth/bluez-5.43.tar.gz && \
    tar xvf bluez-5.43.tar.gz && \
    cd bluez-5.43 && \
    export LDFLAGS=-lrt && \
    ./configure --prefix=/usr --sysconfdir=/etc --localstatedir=/var --enable-library -disable-systemd && \
    make && \
    make install && \
    cp attrib/gatttool /usr/bin/ && \
    cp ./src/bluetoothd /usr/local/bin/ && \
    hash -r && \
    echo "/usr/local/bin/bluetoothd --experimental &" >> /etc/rc.local && \
    rm -rf /app/bluez-5.43.tar.gz

RUN cd /app && \
    git clone https://github.com/intel-iot-devkit/tinyb.git && \
    cd tinyb && \
    mkdir build && \
    cd build && \
    cmake .. && \
    make && \
    make install

CMD ["sleep", "30m"]

FROM ubuntu:bionic as builder
RUN apt update && apt install -qy git
RUN git clone -b master --single-branch --progress https://github.com/google/protobuf.git
RUN git clone -b master --single-branch --progress https://github.com/grpc/grpc.git
WORKDIR /grpc
RUN git submodule update --init
RUN apt install -qy \
	build-essential \
	libgflags-dev \
	autoconf \
  	make \
  	libtool
RUN make --quiet grpc_cli

FROM ubuntu:bionic
LABEL maintainer="https://github.com/VladikAN/grpc-cli-docker"
RUN apt update && apt install -qy libgflags2v5
WORKDIR /root/
COPY --from=builder /grpc/bins/opt .
COPY --from=builder /protobuf/src/google/protobuf/*.proto google/protobuf/
ENTRYPOINT ["./grpc_cli"]
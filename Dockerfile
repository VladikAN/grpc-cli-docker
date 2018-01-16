FROM ubuntu:latest as builder
RUN apt-get update && apt-get install -qq git
RUN git clone -b master --single-branch https://github.com/google/protobuf.git
RUN git clone -b master --single-branch https://github.com/grpc/grpc.git
WORKDIR /grpc
RUN git submodule update --init
RUN apt-get install -qq \
	libgflags-dev \
	autoconf \
  	make \
  	build-essential \
  	libtool
RUN make --quiet grpc_cli

FROM ubuntu:latest
MAINTAINER Vladislav Nekhaychik <vladislavnekhaichik@gmail.com>
RUN apt-get update && apt-get install -qq libgflags2v5
WORKDIR /root/
COPY --from=builder /grpc/bins/opt .
COPY --from=builder /protobuf/src/google/protobuf/*.proto google/protobuf/
ENTRYPOINT ["./grpc_cli"]
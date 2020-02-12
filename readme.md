Image is based on ubuntu 18.04 (bionic) with the precompiled version of the official grpc-cli-tool.

# Use
Call service on 50050 and invoke SayHello method:
```sh
docker run --rm vladikan/grpc-cli-tool call localhost:50050 SayHello
```

Call service on the host machine and invoke SayHello with name=John parameter: 
```sh
docker run --rm --add-host="localhost:192.168.33.31" vladikan/grpc-cli-tool call localhost:50050 SayHello "name: 'John'" --enable_ssl=false
```
For the last sample, you will need to put your host machine IP address instead of mine.

# Links
 - https://github.com/grpc/grpc/blob/master/doc/command_line_tool.md official documentation of the underlying utility
 - https://grpc.io/
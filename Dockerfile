FROM alpine as build

RUN \
    apk --no-cache add curl g++ gcc git make parallel &&\
    curl -s https://raw.githubusercontent.com/ioquake/ioq3/master/misc/linux/server_compile.sh -o /tmp/compile.sh &&\
    echo "y" | sh /tmp/compile.sh &&\
    seq 0 8 |xargs -I{} -P10 -- curl -sL 'https://github.com/nrempel/q3-server/blob/master/baseq3/pak{}.pk3?raw=true' -o '/root/ioquake3/baseq3/pak{}.pk3'


FROM alpine:latest

RUN adduser ioquake3 -D
COPY --from=build --chown=ioquake3 /root/ioquake3 /home/ioquake3/ioquake3
COPY --chown=ioquake3 config/* /home/ioquake3/ioquake3/baseq3/
COPY bin/entrypoint.sh /entrypoint.sh

USER ioquake3
EXPOSE 27960/udp
ENTRYPOINT ["/entrypoint.sh"]

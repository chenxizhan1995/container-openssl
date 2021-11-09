FROM centos:8
SHELL ["/usr/bin/bash", "-c"]
COPY build.sh openssl-3.0.0.tar.gz /
# 中国大陆，需要更换CentOS镜像不然
ARG switch_mirror=yes
RUN chmod u+x /build.sh && /build.sh
CMD ["/usr/bin/bash", "-l"]

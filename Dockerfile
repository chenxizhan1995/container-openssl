FROM centos:8
SHELL ["/usr/bin/bash", "-c"]
COPY build.sh openssl-3.0.0.tar.gz /
RUN chmod u+x /build.sh && /build.sh

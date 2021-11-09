#!/usr/bin/env bash
set -xe
sed -e 's|^mirrorlist=|#mirrorlist=|g' \
         -Ee 's,^#\s*baseurl=http://mirror.centos.org,baseurl=https://mirrors.tuna.tsinghua.edu.cn,g' \
         -i.bak \
         /etc/yum.repos.d/CentOS-*.repo
yum makecache
yum install -y gcc make perl glibc-langpack-en.x86_64 bash-completion

tar -xzf /openssl-3.0.0.tar.gz
cd /openssl-openssl-3.0.0
./config --prefix=/opt/openssl --openssldir=/opt/openssl enable-fips

con=$(($(nproc)+1))
make -sj $con
make -sj $con install

echo /opt/openssl/lib64 >> /etc/ld.so.conf && ldconfig
echo 'export PATH=/opt/openssl/bin:$PATH' >> ~/.bash_profile

cd /
rm -rf /openssl-3.0.0.tar.gz /openssl-openssl-3.0.0
yum autoremove gcc make perl -y
yum clean all -y

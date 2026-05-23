# FROM gitea/runner-images:ubuntu-latest
FROM ghcr.io/xu-cheng/texlive-debian

WORKDIR /root

RUN apt-get update && apt-get install -y make zip tidy wget
RUN wget https://archive.org/download/kindlegen_linux_2_6_i386_v2_9/kindlegen_linux_2.6_i386_v2_9.tar.gz
RUN tar xzf kindlegen_linux_2.6_i386_v2_9.tar.gz
RUN mv kindlegen /usr/bin

WORKDIR /opt/mondoblack

COPY . .

CMD ["/bin/sh"]

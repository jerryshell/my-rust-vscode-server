FROM debian:bookworm-slim

USER root
WORKDIR /root

RUN sed -i 's/deb.debian.org/mirrors.ustc.edu.cn/g' /etc/apt/sources.list.d/debian.sources
RUN apt update &&  apt install openssh-server ca-certificates curl wget gcc git -y && rm -rf /var/lib/apt/lists/*

ENV RUSTUP_DIST_SERVER="https://rsproxy.cn"
ENV RUSTUP_UPDATE_ROOT="https://rsproxy.cn/rustup"
RUN curl --proto '=https' --tlsv1.2 -sSf https://rsproxy.cn/rustup-init.sh | sh -s -- -y
RUN mkdir -p /root/.cargo
RUN echo '[source.crates-io]\n\
registry = "sparse+https://rsproxy.cn/index/"\n\
[net]\n\
git-fetch-with-cli = true\n'\
>> /root/.cargo/config.toml

RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN echo 'root:123456' | chpasswd

RUN service ssh start

EXPOSE 22

CMD ["/usr/sbin/sshd","-D"]

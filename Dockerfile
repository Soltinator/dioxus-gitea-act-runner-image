FROM gitea/runner-images:ubuntu-latest AS setup

WORKDIR /root

#updating (optional)
RUN apt update && apt upgrade -y

#download and install rustup using script
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs > rustup.sh
RUN chmod +x rustup.sh
RUN ./rustup.sh -y -v --no-update-default-toolchain --default-toolchain none 

#install rust toolchain 
RUN rustup default 1.96.0
RUN rustup target add wasm32-unknown-unknown

#adding it all to path
ENV PATH="$PATH:/root/.cargo/bin"
ENV CARGO_HOME="/root/.cargo" 

#install dioxus-cli
RUN cargo install dioxus-cli@0.7.10 --locked
ENV DX_HOME="/root/.local/share/.dx/"

#dummy project build to install wasm
RUN dx new --subtemplate Workspace -y dummy 
WORKDIR /root/dummy
RUN dx build --package web

#deleting dummy
WORKDIR /root
RUN rm -r dummy

#clearing cache
RUN cargo install cargo-cache
RUN cargo-cache -a

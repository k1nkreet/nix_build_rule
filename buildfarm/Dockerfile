from ubuntu:18.04

run apt-get update
run apt-get install --no-install-recommends -y \
  bash-completion \
  openjdk-8-jdk-headless \
  g++ \
  git \
  patch \
  unzip \
  wget \
  zlib1g-dev \
  python \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

RUN wget https://github.com/bazelbuild/bazel/releases/download/5.0.0/bazel-5.0.0-linux-x86_64 && \
    mv bazel-5.0.0-linux-x86_64 /usr/local/bin/bazel && \
    chmod +x /usr/local/bin/bazel

RUN git clone https://github.com/bazelbuild/bazel-buildfarm.git /bazel-buildfarm

WORKDIR /bazel-buildfarm

RUN bazel build //src/main/java/build/buildfarm:buildfarm-server
RUN bazel build //src/main/java/build/buildfarm:buildfarm-memory-worker

RUN apt-get update && apt-get install -y bzip2 gnupg perl curl sudo xz-utils
RUN curl -L https://nixos.org/nix/install | /bin/sh /dev/stdin --daemon
RUN ln -s /root/.nix-profile/bin/nix-build /bin/nix-build 

COPY server.config /
COPY worker.config /

ENTRYPOINT [ ]

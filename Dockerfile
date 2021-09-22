FROM openjdk:8

RUN echo "deb [arch=amd64] http://storage.googleapis.com/bazel-apt stable jdk1.8" | tee /etc/apt/sources.list.d/bazel.list \
  && curl https://bazel.build/bazel-release.pub.gpg | apt-key add -

RUN apt-get update \
  && apt-get install -y bazel python bazel-4.0.0 \
  && rm -rf /var/lib/apt/lists/*

# Set up workspace
RUN mkdir -p /usr/src/app
ENV WORKSPACE /usr/src/app
WORKDIR /usr/src/app

ENV GITILES_REV=v0.4-1

RUN git clone https://gerrit.googlesource.com/gitiles . && \
    git reset --hard $GITILES_REV && \
    bazel build java/com/google/gitiles/dev

ADD start.sh .
RUN chmod +x ./start.sh
CMD ["./start.sh"]

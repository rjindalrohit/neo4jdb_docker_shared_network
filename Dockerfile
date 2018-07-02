FROM java:8
ARG ARG_CLASS
ARG HOST
ARG SPARK_CONFIG
ARG NEO4J_CONFIG
ENV MAIN_CLASS $ARG_CLASS
ENV SCALA_VERSION 2.11.8
ENV SBT_VERSION 1.1.1
ENV SPARK_VERSION 2.2.0
ENV SPARK_DIST spark-$SPARK_VERSION-bin-hadoop2.6
ENV SPARK_ARCH $SPARK_DIST.tgz
ENV SPARK_MASTER $SPARK_CONFIG
ENV DB_CONFIG neo4j_local
ENV KAFKA_STREAMS_NUMBER 5
ENV KAFKA_EVENTS_NUMBER 10
ENV MESSAGES_BATCH_SIZE 16777216
ENV LINGER_MESSAGES_TIME 5
ENV HOSTNAME bolt://$HOST:7687

VOLUME /workdir

WORKDIR /opt

# Install Scala
RUN \
  cd /root && \
  curl -o scala-$SCALA_VERSION.tgz http://downloads.typesafe.com/scala/$SCALA_VERSION/scala-$SCALA_VERSION.tgz && \
  tar -xf scala-$SCALA_VERSION.tgz && \
  rm scala-$SCALA_VERSION.tgz && \
  echo >> /root/.bashrc && \
  echo 'export PATH=~/scala-$SCALA_VERSION/bin:$PATH' >> /root/.bashrc

# Install SBT
RUN \
  curl -L -o sbt-$SBT_VERSION.deb https://dl.bintray.com/sbt/debian/sbt-$SBT_VERSION.deb && \
  dpkg -i sbt-$SBT_VERSION.deb && \
  rm sbt-$SBT_VERSION.deb


# Install Spark
RUN \
    cd /opt && \
    curl -o $SPARK_ARCH http://d3kbcqa49mib13.cloudfront.net/$SPARK_ARCH && \
    tar xvfz $SPARK_ARCH && \
    rm $SPARK_ARCH && \
    echo 'export PATH=$SPARK_DIST/bin:$PATH' >> /root/.bashrc

EXPOSE 9851 9852 4040 9092 9200 9300 5601 7474 7687 7473 8888

CMD /workdir/runDemo.sh "$MAIN_CLASS" "$SPARK_MASTER" "$DB_CONFIG" "$KAFKA_STREAMS_NUMBER" "$KAFKA_EVENTS_NUMBER" "$MESSAGES_BATCH_SIZE" "$LINGER_MESSAGES_TIME"


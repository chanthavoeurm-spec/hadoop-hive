# Use Ubuntu as base
FROM ubuntu:24.04

# Install dependencies
RUN apt-get update && apt-get install -y \
    openjdk-11-jdk \
    wget \
    curl \
    python3 \
    python3-pip \
    postgresql \
    postgresql-contrib \
    net-tools \
    vim \
    && rm -rf /var/lib/apt/lists/*

# Set environment variables
ENV HADOOP_VERSION=3.3.6 \
    HIVE_VERSION=3.1.3 \
    PIG_VERSION=0.17.0 \
    HADOOP_HOME=/opt/hadoop \
    HIVE_HOME=/opt/hive \
    PIG_HOME=/opt/pig \
    JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64

# Download and extract Hadoop
RUN wget https://downloads.apache.org/hadoop/common/hadoop-${HADOOP_VERSION}/hadoop-${HADOOP_VERSION}.tar.gz \
    && tar -xzf hadoop-${HADOOP_VERSION}.tar.gz -C /opt/ \
    && mv /opt/hadoop-${HADOOP_VERSION} $HADOOP_HOME \
    && rm hadoop-${HADOOP_VERSION}.tar.gz

# Download and extract Hive
RUN wget https://downloads.apache.org/hive/hive-${HIVE_VERSION}/apache-hive-${HIVE_VERSION}-bin.tar.gz \
    && tar -xzf apache-hive-${HIVE_VERSION}-bin.tar.gz -C /opt/ \
    && mv /opt/apache-hive-${HIVE_VERSION}-bin $HIVE_HOME \
    && rm apache-hive-${HIVE_VERSION}-bin.tar.gz

# Download and extract Pig
RUN wget https://downloads.apache.org/pig/pig-${PIG_VERSION}/pig-${PIG_VERSION}.tar.gz \
    && tar -xzf pig-${PIG_VERSION}.tar.gz -C /opt/ \
    && mv /opt/pig-${PIG_VERSION} $PIG_HOME \
    && rm pig-${PIG_VERSION}.tar.gz

# Add Hadoop, Hive, Pig to PATH
ENV PATH="$HADOOP_HOME/bin:$HIVE_HOME/bin:$PIG_HOME/bin:$PATH"

# Configure Postgres
USER postgres
RUN /etc/init.d/postgresql start && \
    psql --command "CREATE USER hive WITH SUPERUSER PASSWORD 'hivepassword';" && \
    createdb -O hive metastore
USER root

# Copy configuration files (to be provided in ./config)
COPY config/hadoop/* $HADOOP_HOME/etc/hadoop/
COPY config/hive/* $HIVE_HOME/conf/
COPY config/pig/* $PIG_HOME/conf/
COPY config/postgres/* /etc/postgresql/

# Expose ports
EXPOSE 5432 9870 8088 10000 9083

# Entrypoint script to start all services
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

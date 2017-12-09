FROM centos:latest
LABEL maintainer="Jamez (Jay) <info@jamesattard.com>"
LABEL description="Apache NiFi 1.4.0 on Docker"

RUN yum update -y \
    && yum install -y which wget git java-1.8.0-openjdk python \
    && yum clean all

ENV JAVA_HOME /usr/lib/jvm/jre-1.8.0-openjdk
RUN export JAVA_HOME

ENV NIFI_VERSION=1.4.0 \
    NIFI_HOME=/opt/nifi \
    MIRROR_SITE=http://www-eu.apache.org/dist

RUN set -x \
    && curl -Lf https://dist.apache.org/repos/dist/release/nifi/KEYS -o /tmp/nifi-keys.txt \
    && gpg --import /tmp/nifi-keys.txt \
    && curl -Lf ${MIRROR_SITE}/nifi/${NIFI_VERSION}/nifi-${NIFI_VERSION}-bin.tar.gz -o /tmp/nifi-bin.tar.gz \
    && curl -Lf ${MIRROR_SITE}/nifi/${NIFI_VERSION}/nifi-${NIFI_VERSION}-bin.tar.gz.asc -o /tmp/nifi-bin.tar.gz.asc \
    && gpg --verify /tmp/nifi-bin.tar.gz.asc \
    && mkdir -p ${NIFI_HOME} \
    && tar zxvf /tmp/nifi-bin.tar.gz -C ${NIFI_HOME} --strip-components=1 \
    && rm /tmp/nifi-keys.txt \
    && rm /tmp/nifi-bin.tar.gz.asc \
    && sed -i -e "s|^nifi.ui.banner.text=.*$$|nifi.ui.banner.text=Docker NiFi ${NIFI_VERSION}|" ${NIFI_HOME}/conf/nifi.properties \
    && groupadd nifi \
    && useradd -r -g nifi nifi \
    && bash -c "mkdir -p ${NIFI_HOME}/{database_repository,flowfile_repository,content_repository,provenance_repository}" \
    && chown nifi:nifi -R ${NIFI_HOME}

VOLUME ["${NIFI_HOME}/database_repository", \
    "${NIFI_HOME}/flowfile_repository", \
    "${NIFI_HOME}/content_repository", \
    "${NIFI_HOME}/provenance_repository"]

USER nifi
WORKDIR ${NIFI_HOME}
EXPOSE 8080
CMD ["bin/nifi.sh", "run"]

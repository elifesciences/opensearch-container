FROM opensearchproject/opensearch:1.2.1

# user is 'opensearch' at this point (uid 1000)

# https://github.com/opensearch-project/OpenSearch/blob/1.1/distribution/docker/src/docker/bin/docker-entrypoint.sh

#RUN ./bin/opensearch-plugin list
COPY scripts/ scripts
RUN scripts/handle-plugins.sh

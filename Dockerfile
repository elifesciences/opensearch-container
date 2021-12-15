FROM opensearchproject/opensearch:1.2.1

# user is 'opensearch' at this point (uid 1000)

# I'm tweaking the docker-entrypoint.sh script to disable the performance analyser
# it seems to be the only way to get it to stop spamming the logs when run inside a container.
# taken from:
# - https://github.com/opensearch-project/opensearch-build/blob/opensearch-1.2.1/docker/release/config/opensearch/opensearch-docker-entrypoint.sh
USER root
COPY ./bin/opensearch-docker-entrypoint.sh /usr/local/opensearch-docker-entrypoint.sh
RUN chmod 0775 /usr/local/opensearch-docker-entrypoint.sh

USER opensearch

# plugins are added and removed between releases! find a list of them here:
#RUN ./bin/opensearch-plugin list

COPY scripts/ scripts
RUN scripts/handle-plugins.sh

CMD ["/usr/local/opensearch-docker-entrypoint.sh"]

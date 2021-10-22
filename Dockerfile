FROM opensearchproject/opensearch:1.1.0

COPY scripts/ scripts
RUN scripts/handle-plugins.sh

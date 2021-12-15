#!/bin/bash

# lsh@2021-10-22: if we're to use plugins it should be done carefully.
# some sound useful and we may want to investigate them in the future.
# we're not using any plugins at time of writing.
# plugins are updated separately to opensearch and must use compatible versions.
# plugins may depend on other plugins.
# plugins increase opensearch init time.

set -e

plugin_list=( 
    opensearch-alerting 
    # depends on opensearch-job-scheduler
    opensearch-anomaly-detection 
    opensearch-asynchronous-search
    opensearch-cross-cluster-replication
    opensearch-index-management
    # depends on opensearch-job-scheduler
    opensearch-reports-scheduler
    opensearch-job-scheduler
    opensearch-knn
    #opensearch-notebooks # disappeared between 1.1.0 and 1.2.1
    # can't be removed normally.
    # lsh@2021-12: builds fine without it under 1.2.1 ...
    #opensearch-performance-analyzer
    opensearch-security
    opensearch-sql
)

for plugin in "${plugin_list[@]}"; do
    ./bin/opensearch-plugin remove "$plugin" --purge
done

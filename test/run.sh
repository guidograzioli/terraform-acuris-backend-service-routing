#!/bin/bash

set -euo pipefail

repo_dir=$(git rev-parse --show-toplevel)
name=$(basename $repo_dir)-test

docker build -t $name $repo_dir/test

docker run \
    --name $name \
    --rm \
    -i $(tty -s && echo -t) \
    -w $repo_dir \
    -v $repo_dir:$repo_dir \
    -v /var/run/docker.sock:/var/run/docker.sock \
    $name \
        py.test \
        -vv     \
        --tb=short \
        "$@"

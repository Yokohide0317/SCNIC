#!/bin/bash

# おまじない
set -e
set -u

OUTDIR="./pipe_output"
if [ ! -d $OUTDIR ]; then
    mkdir $OUTDIR
fi


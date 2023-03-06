#!/bin/bash

set -e
set -u

ROOT_DIR=$1

for LEVEL in {2..7}; do
    echo "Level${LEVEL}"
    LEVEL_OUTDIR="${ROOT_DIR}/L${LEVEL}"
    INP_BIOM="${LEVEL_OUTDIR}/exported-feature-table/feature-table.biom"

    SCNIC_analysis.py within \
        -i ${INP_BIOM} \
        -o ${LEVEL_OUTDIR}/within_output/ \
        -m sparcc

    SCNIC_analysis.py modules \
        -i ${LEVEL_OUTDIR}/within_output/correls.txt \
        --table ${INP_BIOM} \
        --min_r .35 \
        -o ${LEVEL_OUTDIR}/modules_output/
    echo "Saved to ${LEVEL_OUTDIR}/modules_output/correlation_network.gml"
    echo "--------------------------------"
done

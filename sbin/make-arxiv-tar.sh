#!/bin/bash

cdir=`cd "$(dirname "${BASH_SOURCE[0]}")" && cd .. && pwd`
pushd $cdir
rsync -ravh \
    --include="<paper-name>.tex" \
    --include="<paper-name>.bib" \
    --exclude="<paper-name>.pdf" \
    --exclude="main*" \
    --exclude="drafts/" \
    --exclude="**/*.tex" \
    src/ arxiv/

# Clean folder of unwanted files
git clean -xffd arxiv/
# Dry-run of build and show would-be contents
git archive --format=tar HEAD:arxiv | tar t
# Make tar
git archive --output=bin/arxiv.tar.gz --format=tar HEAD:arxiv

popd


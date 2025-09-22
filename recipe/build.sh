#!/bin/bash
set -exuo pipefail

pushd src/cmd/syft

go-licenses save . \
    --save_path "${SRC_DIR}"/library_licenses \
    --ignore modernc.org/mathutil \
    --ignore github.com/xi2/xz \
    --ignore github.com/deitch/magic/pkg/magic \
    --ignore github.com/deitch/magic/pkg/magic/internal \
    --ignore github.com/deitch/magic/pkg/magic/parser

go build \
    -v \
    -o "${PREFIX}"/bin/syft \
    -ldflags="-X 'main.version=${PKG_VERSION}'"

popd

# Clear out cache to avoid file not removable warnings
chmod -R u+w "$(go env GOPATH)" && rm -r "$(go env GOPATH)"

#!/usr/bin/env bash

set -e

BUILD_AND_PUSH=${BUILD_AND_PUSH:-0}


for conf in *; do
	[[ -d "${conf}" ]] || continue
	cp assemble "${conf}"/thoth_assemble
	pushd "${conf}"
	docker build . -t "quay.io/thoth-station/s2i-thoth-${conf}"
	[[ ${BUILD_AND_PUSH} -ne 0 ]] && docker push "quay.io/thoth-station/s2i-thoth-${conf}"
	popd
	rm "${conf}"/thoth_assemble
done

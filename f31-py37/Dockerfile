# Thoth's extension to OpenShift's S2I build
FROM quay.io/thoth-station/f31-python37:latest

ENV SUMMARY="Thoth's Source-to-Image for Python ${PYTHON_VERSION} applications" \
    DESCRIPTION="Thoth's Source-to-Image for Python ${PYTHON_VERSION} applications. This toolchain is based on Fedora 31. It includes Pipenv."

LABEL summary="$SUMMARY" \
      description="$DESCRIPTION" \
      io.k8s.description="$DESCRIPTION" \
      io.k8s.display-name="Thoth Python 3.6-f31 S2I" \
      io.openshift.expose-services="8080:http" \
      io.openshift.tags="python,python37" \
      name="thoth-station/s2i-thoth-f31-py37:v0.1.0" \
      vendor="AICoE at the Office of the CTO, Red Hat Inc." \
      authoritative-source-url=quay.io \
      version="0.1.0" \
      release="0" \
      ninja.thoth-station.version="0.6.0-dev" \
      maintainer="Thoth Station <aicoe-thoth@redhat.com>"

USER 0
COPY ./s2i_assemble.patch /tmp/s2i_assemble.patch
RUN TMPFILE=`mktemp` && \
    TMPFILE_ASSEMBLE=`mktemp` && \
    pushd "${STI_SCRIPTS_PATH}" && patch -p 1 < /tmp/s2i_assemble.patch && popd && \
    pip3 install micropipenv[toml]==0.0.3 && \
    curl "https://raw.githubusercontent.com/thoth-station/s2i-thoth/master/assemble" -o "${TMPFILE_ASSEMBLE}" && \
    cp "${STI_SCRIPTS_PATH}/assemble" "${TMPFILE}" && \
    head -n1 "${TMPFILE}" > "${STI_SCRIPTS_PATH}/assemble" && \
    cat "${TMPFILE_ASSEMBLE}" >> "${STI_SCRIPTS_PATH}/assemble" && \
    tail -n+2 "${TMPFILE}" >> "${STI_SCRIPTS_PATH}/assemble" && \
    rm "${TMPFILE}" "${TMPFILE_ASSEMBLE}" /tmp/s2i_assemble.patch && \
    chown -R 1001:0 ${APP_ROOT} && \
    fix-permissions ${APP_ROOT} -P

USER 1001

# Thoth's extension to OpenShift's S2I build
FROM registry.access.redhat.com/ubi8/python-36

LABEL ninja.thoth-station.version="0.0.1" \
      maintainer="Fridolin Pokorny <fridolin@redhat.com>"

USER 0
COPY ./s2i_assemble.patch /tmp/s2i_assemble.patch
RUN TMPFILE=`mktemp` && \
    TMPFILE_ASSEMBLE=`mktemp` && \
    pushd "${STI_SCRIPTS_PATH}" && patch -p 1 < /tmp/s2i_assemble.patch && popd && \
    pip3 install pipenv==2018.11.26 && \
    curl "https://raw.githubusercontent.com/thoth-station/s2i-thoth/master/assemble" -o "${TMPFILE_ASSEMBLE}" && \
    cp "${STI_SCRIPTS_PATH}/assemble" "${TMPFILE}" && \
    head -n1 "${TMPFILE}" > "${STI_SCRIPTS_PATH}/assemble" && \
    cat "${TMPFILE_ASSEMBLE}" >> "${STI_SCRIPTS_PATH}/assemble" && \
    tail -n+2 "${TMPFILE}" >> "${STI_SCRIPTS_PATH}/assemble" && \
    rm "${TMPFILE}" "${TMPFILE_ASSEMBLE}" /tmp/s2i_assemble.patch

USER 1001

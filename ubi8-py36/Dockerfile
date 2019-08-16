# Thoth's extension to OpenShift's S2I build
FROM registry.access.redhat.com/ubi8/python-36

LABEL ninja.thoth-station.version="0.0.1" \
      maintainer="Fridolin Pokorny <fridolin@redhat.com>"

COPY ./thoth_assemble /tmp/thoth_assemble

USER 0
RUN TMPFILE=`mktemp` && \
    TMPFILE_ASSEMBLE=`mktemp` && \
    curl "https://raw.githubusercontent.com/thoth-station/s2i-thoth/master/assemble" -o "${TMPFILE_ASSEMBLE}" && \
    cp "${STI_SCRIPTS_PATH}/assemble" "${TMPFILE}" && \
    head -n1 "${TMPFILE}" > "${STI_SCRIPTS_PATH}/assemble" && \
    cat "${TMPFILE_ASSEMBLE}" >> "${STI_SCRIPTS_PATH}/assemble" && \
    tail -n+2 "${TMPFILE}" >> "${STI_SCRIPTS_PATH}/assemble" && \
    rm "${TMPFILE}" "${TMPFILE_ASSEMBLE}"

USER 1001

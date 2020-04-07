# Thoth's extension to OpenShift's S2I build
FROM registry.access.redhat.com/ubi8/python-36

ENV SUMMARY="Thoth's Source-to-Image for Python ${PYTHON_VERSION} applications" \
    DESCRIPTION="Thoth's Source-to-Image for Python ${PYTHON_VERSION} applications. This toolchain is based on Red Hat UBI8. It includes pipenv."

LABEL summary="$SUMMARY" \
      description="$DESCRIPTION" \
      io.k8s.description="$DESCRIPTION" \
      io.k8s.display-name="Thoth Python 3.6-ubi8 S2I" \
      io.openshift.expose-services="8080:http" \
      io.openshift.tags="python,python36" \
      name="thoth-station/s2i-thoth-ubi8-py36:v0.11.13" \
      vendor="AICoE at the Office of the CTO, Red Hat Inc." \
      version="0.11.13" \
      release="0" \
      ninja.thoth-station.version="0.6.0-dev" \
      maintainer="Thoth Station <aicoe-thoth@redhat.com>"

USER 0
COPY ./s2i_assemble.patch /tmp/s2i_assemble.patch
RUN TMPFILE=`mktemp` && \
    TMPFILE_ASSEMBLE=`mktemp` && \
    pushd "${STI_SCRIPTS_PATH}" && patch -p 1 < /tmp/s2i_assemble.patch && popd && \
    /usr/bin/pip3 install micropipenv[toml]==0.1.5 thamos==0.9.2 && \
    curl "https://raw.githubusercontent.com/thoth-station/s2i-thoth/master/assemble" -o "${TMPFILE_ASSEMBLE}" && \
    cp "${STI_SCRIPTS_PATH}/assemble" "${TMPFILE}" && \
    head -n1 "${TMPFILE}" > "${STI_SCRIPTS_PATH}/assemble" && \
    cat "${TMPFILE_ASSEMBLE}" >> "${STI_SCRIPTS_PATH}/assemble" && \
    tail -n+2 "${TMPFILE}" >> "${STI_SCRIPTS_PATH}/assemble" && \
    rm "${TMPFILE}" "${TMPFILE_ASSEMBLE}" /tmp/s2i_assemble.patch && \
    sed -i '/  echo "---> Running application from .*/d' "${STI_SCRIPTS_PATH}/run" && \
    chown -R 1001:0 ${APP_ROOT} && \
    fix-permissions ${APP_ROOT} -P

USER 1001

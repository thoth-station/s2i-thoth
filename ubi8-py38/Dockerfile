# Thoth's extension to OpenShift's S2I build
FROM registry.access.redhat.com/ubi8/python-38:1-41

ENV SUMMARY="Thoth's Source-to-Image for Python ${PYTHON_VERSION} applications" \
    DESCRIPTION="Thoth's Source-to-Image for Python ${PYTHON_VERSION} applications. This toolchain is based on Red Hat UBI8. It includes pipenv." \
    THOTH_S2I_VERSION=0.23.0 \
    THAMOS_NO_PROGRESSBAR=1 \
    THAMOS_NO_EMOJI=1

LABEL summary="$SUMMARY" \
    description="$DESCRIPTION" \
    io.k8s.description="$DESCRIPTION" \
    io.k8s.display-name="Thoth Python 3.8-ubi8 S2I" \
    io.openshift.expose-services="8080:http" \
    io.openshift.tags="python,python38" \
    name="thoth-station/s2i-thoth-ubi8-py38:v$THOTH_S2I_VERSION" \
    vendor="AICoE at the Office of the CTO, Red Hat Inc." \
    authoritative-source-url="https://quay.io/thoth-station/s2i-thoth" \
    version="$THOTH_S2I_VERSION" \
    release="0" \
    ninja.thoth-station.version="0.7.0-dev" \
    maintainer="Thoth Station <aicoe-thoth@redhat.com>"

USER 0
COPY ./s2i_assemble.patch /tmp/s2i_assemble.patch
RUN TMPFILE=$(mktemp) && \
    TMPFILE_ASSEMBLE=$(mktemp) && \
    pushd "${STI_SCRIPTS_PATH}" && patch -p 1 </tmp/s2i_assemble.patch && popd && \
    pip3 install -U "pip==20.3.3" && \
    /usr/bin/pip3 install -U "pip==20.3.3" && \
    curl "https://raw.githubusercontent.com/thoth-station/s2i-thoth/master/requirements.txt" -o requirements.txt && \
    MICROPIPENV_PIP_BIN=/usr/bin/pip3 curl https://raw.githubusercontent.com/thoth-station/micropipenv/master/micropipenv.py | python3 - install -- && \
    curl "https://raw.githubusercontent.com/thoth-station/s2i-thoth/master/assemble" -o "${TMPFILE_ASSEMBLE}" && \
    cp "${STI_SCRIPTS_PATH}/assemble" "${TMPFILE}" && \
    head -n1 "${TMPFILE}" >"${STI_SCRIPTS_PATH}/assemble" && \
    cat "${TMPFILE_ASSEMBLE}" >>"${STI_SCRIPTS_PATH}/assemble" && \
    tail -n+2 "${TMPFILE}" >>"${STI_SCRIPTS_PATH}/assemble" && \
    rm "${TMPFILE}" "${TMPFILE_ASSEMBLE}" /tmp/s2i_assemble.patch requirements.txt && \
    sed -i '/  echo "---> Running application from .*/d' "${STI_SCRIPTS_PATH}/run" && \
    chown -R 1001:0 ${APP_ROOT} && \
    fix-permissions ${APP_ROOT} -P && \
    yum update --assumeyes --setopt=tsflags=nodocs

USER 1001

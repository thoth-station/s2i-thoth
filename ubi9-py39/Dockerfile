# Thoth's extension to OpenShift's S2I build
FROM registry.access.redhat.com/ubi9/python-39@sha256:f2809c7fa3d7a7eeb376ff401f014b9541a1170f2f587c32c2fc11e003157ca6

ENV SUMMARY="Thoth's Source-to-Image for Python ${PYTHON_VERSION} applications" \
    DESCRIPTION="Thoth's Source-to-Image for Python ${PYTHON_VERSION} applications. This toolchain is based on Red Hat UBI9. It includes pipenv." \
    THOTH_S2I_NAME=quay.io/thoth-station/s2i-thoth-ubi9-py39 \
    THOTH_S2I_VERSION=0.35.1 \
    THAMOS_NO_PROGRESSBAR=1 \
    THAMOS_NO_EMOJI=1 \
    MICROPIPENV_NO_LOCKFILE_PRINT=0 \
    MICROPIPENV_NO_LOCKFILE_WRITE=0

LABEL summary="$SUMMARY" \
    description="$DESCRIPTION" \
    io.k8s.description="$DESCRIPTION" \
    io.k8s.display-name="Thoth Python 3.9-ubi9 S2I" \
    io.openshift.expose-services="8080:http" \
    io.openshift.tags="python,python39,python39:1-86" \
    name="$THOTH_S2I_NAME:v$THOTH_S2I_VERSION" \
    vendor="Project Thoth, Red Hat Inc." \
    authoritative-source-url="https://quay.io/thoth-station/s2i-thoth" \
    version="$THOTH_S2I_VERSION" \
    release="0" \
    ninja.thoth-station.version="0.7.0-dev" \
    maintainer="Thoth Station <aicoe-thoth@redhat.com>"

USER 0
COPY ./s2i_assemble.patch /tmp/s2i_assemble.patch
COPY ./requirements.txt $HOME/requirements.txt
RUN TMPFILE=$(mktemp) && \
    TMPFILE_ASSEMBLE=$(mktemp) && \
    pushd "${STI_SCRIPTS_PATH}" && patch -p 1 </tmp/s2i_assemble.patch && popd && \
    curl https://raw.githubusercontent.com/thoth-station/micropipenv/master/micropipenv.py | MICROPIPENV_NO_LOCKFILE_WRITE=1 MICROPIPENV_PIP_BIN=/usr/bin/pip3 /usr/bin/python3 - install -- && \
    curl "https://raw.githubusercontent.com/thoth-station/s2i-thoth/master/assemble" -o "${TMPFILE_ASSEMBLE}" && \
    cp "${STI_SCRIPTS_PATH}/assemble" "${TMPFILE}" && \
    head -n1 "${TMPFILE}" >"${STI_SCRIPTS_PATH}/assemble" && \
    cat "${TMPFILE_ASSEMBLE}" >>"${STI_SCRIPTS_PATH}/assemble" && \
    tail -n+2 "${TMPFILE}" >>"${STI_SCRIPTS_PATH}/assemble" && \
    rm "${TMPFILE}" "${TMPFILE_ASSEMBLE}" /tmp/s2i_assemble.patch requirements.txt && \
    sed -i '/  echo "---> Running application from .*/d' "${STI_SCRIPTS_PATH}/run" && \
    chown -R 1001:0 ${APP_ROOT} && \
    fix-permissions ${APP_ROOT} -P && \
    yum update --assumeyes --nobest --setopt=tsflags=nodocs && \
    yum --assumeyes clean all && \
    rm -rf /var/cache/dnf

USER 1001

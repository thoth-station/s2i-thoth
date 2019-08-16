s2i-thoth
---------

Experimental Thoth container images:

* `quay.io/thoth-station/s2i-thoth-ubi8-py36 <https://quay.io/repository/thoth-station/s2i-thoth-ubi8-py36>`_

Artifacts needed to build `s2i-thoth-*` container images.

These container images are complaint with OpenShift's s2i build process to
build Python applications. They extend the functionality of base s2i Python
container images so that applications using these container images benefit from
Thoth's recommendations.

Configuration options
=====================

* ``THOTH_ADVISE`` - always use the recommended stack by Thoth (even if ``Pipfile.lock`` is present in the repo)
* ``THOTH_ASSEMBLE_DEBUG`` - run s2i's assemble script in verbose mode
* ``THOTH_DRY_RUN`` - submit stack to Thoth's recommendation engine but do not use the recommended ``Pipfile.lock`` file, use the ``Pipfile.lock`` file present in the repo instead
* ``THOTH_FROM_MASTER`` - Use Thamos from git instead of a PyPI release - handy if the released Thamos has a bug which was fixed in the master branch
* ``THOTH_HOST`` - Thoth's host to reach out to for recommendations (defaults to prod deployment at khemenu.thoth-station.ninja)

Building container images
=========================

Container images are automatically built in quay.io when pushed to master branch.

s2i-thoth
---------

This repository is for build in the cpaas and osbs.
we here solely focus on the ubi8-py38 version of the image.

=====================

Configuration options for Thoth's s2i image:

* ``THOTH_ADVISE`` - always use the recommended stack by Thoth (even if the lock file is present in the repo)
* ``THOTH_CONFIG_CHECK`` - verify values stated in the configuration file match the build environment
* ``THOTH_PROVENANCE_CHECK`` - verify stack provenance - the provenance check is triggered only if the lock file is not comming from Thoth's recommendation engine (otherwise the stack has already verified provenance)
* ``THOTH_ASSEMBLE_DEBUG`` - run s2i's assemble script in verbose mode
* ``THOTH_DRY_RUN`` - submit stack to Thoth's recommendation engine but do **NOT** use the recommended lock file, use the lock file present in the repo instead
* ``THOTH_FROM_MASTER`` - Use Thamos from git instead of a PyPI release - handy if the released Thamos has a bug which was fixed in the master branch
* ``THOTH_HOST`` - Thoth's host to reach out to for recommendations (defaults to prod deployment at khemenu.thoth-station.ninja)
* ``THOTH_ERROR_FALLBACK`` - fallback to the lock file present in the repository if the submitted Thoth analysis fails

See also configuration options for Thoth's client present in `Thamos repository
<https://github.com/thoth-station/thamos/#using-thoth-and-thamos-in-openshifts-s2i>`_.

Building container images
=========================

Container images are automatically built in quay.io when pushed to master branch.

Updating and releasing new container images
===========================================

This repository is managed by `Kebechet
<https://github.com/thoth-station/kebechet/>`__ so updates of all the Python
packages it uses are performed automatically. If you wish to release a new
version of Thoth's s2i, you can do so by performing:

.. code-block:: console

  find -iname Dockerfile -exec sed -i 's/THOTH_S2I_VERSION=0.23.0/THOTH_S2I_VERSION=0.24.0/g' {} \; && git commit -m "Version 0.24.0" . && git tag v0.24.0

A subsequent pull request to this repository is needed.

Importing image into OpenShift's registry
=========================================

.. code-block:: console

  oc import-image quay.io/thoth-station/s2i-thoth-ubi8-py36 -n <your-namespace>
  oc import-image quay.io/thoth-station/s2i-thoth-f31-py37 -n <your-namespace>
=======
Please visit the upstream project for details regarding the content.
https://github.com/thoth-station/s2i-thoth

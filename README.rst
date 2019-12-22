s2i-thoth
---------

.. |s2i-thoth-ubi8-py36 on Quay| image:: https://quay.io/repository/thoth-station/s2i-thoth-ubi8-py36/status
:target: https://quay.io/repository/thoth-station/s2i-thoth-ubi8-py36

.. |s2i-thoth-f31-py37 on Quay| image:: https://quay.io/repository/thoth-station/s2i-thoth-f31-py37/status
:target: https://quay.io/repository/thoth-station/s2i-thoth-f31-py37

Experimental Thoth container images:

* `quay.io/thoth-station/s2i-thoth-ubi8-py36 <https://quay.io/repository/thoth-station/s2i-thoth-ubi8-py36>`_ |s2i-thoth-ubi8-py36 on Quay|

* `quay.io/thoth-station/s2i-thoth-f31-py37 <https://quay.io/repository/thoth-station/s2i-thoth-f31-py37>`_ |s2i-thoth-f31-py37 on Quay| 

Artifacts needed to build `s2i-thoth-*` container images.

These container images are complaint with OpenShift's s2i build process to
build Python applications. They extend the functionality of base s2i Python
container images so that applications using these container images benefit from
Thoth's recommendations.

Configuration options
=====================

Configuration options for Thoth's s2i image:

* ``THOTH_ADVISE`` - always use the recommended stack by Thoth (even if ``Pipfile.lock`` is present in the repo)
* ``THOTH_ASSEMBLE_DEBUG`` - run s2i's assemble script in verbose mode
* ``THOTH_DRY_RUN`` - submit stack to Thoth's recommendation engine but do not use the recommended ``Pipfile.lock`` file, use the ``Pipfile.lock`` file present in the repo instead
* ``THOTH_FROM_MASTER`` - Use Thamos from git instead of a PyPI release - handy if the released Thamos has a bug which was fixed in the master branch
* ``THOTH_HOST`` - Thoth's host to reach out to for recommendations (defaults to prod deployment at khemenu.thoth-station.ninja)
* ``THOTH_ERROR_FALLBACK`` - fallback to the ``Pipfile.lock`` present in the repository if the submitted Thoth analysis fails

See also configuration options for Thoth's client present in `Thamos repository
<https://github.com/thoth-station/thamos/#using-thoth-and-thamos-in-openshifts-s2i>`_.

Building container images
=========================

Container images are automatically built in quay.io when pushed to master branch.

Importing image into OpenShift's registry
=========================================

.. code-block:: console

  oc import-image quay.io/thoth-station/s2i-thoth-ubi8-py36 -n <your-namespace>
  oc import-image quay.io/thoth-station/s2i-thoth-f31-py37 -n <your-namespace>

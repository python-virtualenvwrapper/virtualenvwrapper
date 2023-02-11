#!/usr/bin/env python

from setuptools import setup

setup(
    # Listing the scripts in pyproject.toml requires them to be python
    # entry points for console scripts, but they are shell scripts.
    scripts=[
        "virtualenvwrapper.sh",
        "virtualenvwrapper_lazy.sh",
    ],
)

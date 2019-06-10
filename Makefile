PYTHON_PACKAGE = abc2xml.py
TESTS_PACKAGE = tests
PYTHON ?= python

.PHONY: clean clean-build clean-pyc dist docstrings flake8 help install upload
.DEFAULT_GOAL := help

help:
	@echo "Available Makefile targets:"
	@echo
	@echo "dist           builds source and wheel package"
	@echo "install        install the package to the active Python environment"
	@echo "flake8         run style checks and static analysis with flake8"
	@echo "docstrings     check docstring presence and style conventions with pydocstyle"
	@echo "clean          remove all build and Python artifacts"
	@echo "clean-build    remove distutils/setuptools build artifacts"
	@echo "clean-pyc      remove Python file artifacts"

clean: clean-build clean-pyc

clean-build:  ## remove build artifacts
	rm -fr build/
	rm -fr .eggs/
	find . -name '*.egg-info' -exec rm -fr {} +
	find . -name '*.egg' -exec rm -f {} +

clean-pyc:  ## remove Python file artifacts
	find . -name '*.pyc' -exec rm -f {} +
	find . -name '*.pyo' -exec rm -f {} +
	find . -name '*~' -exec rm -f {} +
	find . -name '__pycache__' -exec rm -fr {} +

flake8:  ## run style checks and static analysis with flake8
	flake8 $(PYTHON_PACKAGE) $(TESTS_PACKAGE)

docstrings:  ## check docstring presence and style conventions with pydocstyle
	pydocstyle $(PYTHON_PACKAGE)

upload: dist  ## package and upload a release
	twine upload --skip-existing dist/*.whl dist/*.tar.gz

dist: clean  ## builds source and wheel package
	$(PYTHON) setup.py sdist bdist_wheel
	ls -l dist

install: clean ## install the package to the active Python's site-packages
	$(PYTHON) setup.py install

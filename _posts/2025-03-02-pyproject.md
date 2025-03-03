---
title: Modern Python Packaging: Say Goodbye to setup.py
date: 2025-03-02
categories: [Programming, Python]
tags: [python, pyproject, development]  # TAG names should always be lowercase
published: true
---

## Introduction

Python packaging has come a long way from its early days when `setup.py` was the standard for defining package metadata. While `setup.py` and `setup.cfg` have served their purpose, they lack standardization, are often cumbersome to maintain, and present security risks due to their executable nature. 

With the introduction of **PEP 517, PEP 518, and PEP 621**, the Python ecosystem has transitioned to a more modern and declarative approach using **`pyproject.toml`**. This method provides better tooling, improved security, and easier maintainability.

This article will guide you through the evolution of Python packaging, comparing the traditional and modern approaches, and explaining why `pyproject.toml` is now the recommended way to define Python packages. We will also address common concerns about losing the flexibility of `setup.py`, such as fetching environment variables or customizing package behavior, and finally, we will provide a modern template to help you get started with best practices in Python packaging.

---

## Traditional vs. Modern Python Packaging

To understand why `pyproject.toml` is the future, let's first examine how Python packages were traditionally structured and compare that to the new approach.

### Traditional Approach: `setup.py` + `setup.cfg`

For many years, Python packages used `setup.py` for defining metadata and dependencies. Sometimes, `setup.cfg` was also used for static configurations. However, since `setup.py` is a Python script, it allows arbitrary execution, making it prone to complexity and security issues.

#### Example: Traditional `setup.py`
```python
from setuptools import setup, find_packages

setup(
    name="your_package",
    version="0.1.0",
    description="A traditional Python package",
    author="Your Name",
    author_email="your@email.com",
    packages=find_packages(where="src"),
    package_dir={"": "src"},
    install_requires=["requests"],
    extras_require={"dev": ["pytest", "tox"]},
    entry_points={"console_scripts": ["your-package=your_package.main:main"]},
    classifiers=[
        "Programming Language :: Python :: 3",
        "License :: OSI Approved :: MIT License",
    ],
    python_requires=">=3.8",
)
```

While this approach worked for years, it had several downsides, including lack of standardization, excessive boilerplate, and a security risk due to executable scripts being run at installation time.

### Modern Approach: `pyproject.toml`

To resolve these issues, **PEP 517 and PEP 621** introduced `pyproject.toml`, a **declarative configuration file** that provides a standardized way to define package metadata. Unlike `setup.py`, this file is purely static, improving maintainability and security.

#### Example: Modern `pyproject.toml`
```toml
[build-system]
requires = ["hatchling"]
build-backend = "hatchling.build"

[project]
name = "your_package"
version = "0.1.0"
description = "A modern Python package"
authors = [{ name = "Your Name", email = "your@email.com" }]
license = { text = "MIT" }
readme = "README.md"
requires-python = ">=3.8"
dependencies = [
    "requests"\]

[project.optional-dependencies]
dev = ["pytest", "tox"]

[project.scripts]
your-package = "your_package.main:main"

[tool.hatch.build]
include = ["src/your_package"]
```

With this approach, package maintainers no longer need to write executable code to specify metadata. Instead, the structure is standardized, making it easier to parse, understand, and use with modern build tools.

---

## Why You Should Stop Using `setup.py`

### Security & Maintainability
- `setup.py` is executable Python code, meaning it can run arbitrary commands during installation, leading to security risks.
- `pyproject.toml` is purely declarative, preventing unexpected execution and improving maintainability.

### Standardization & Future-Proofing
- `setup.py` lacks a strict standard; `pyproject.toml` follows **PEP 621**.
- Many modern tools (Hatch, Poetry, PDM) require `pyproject.toml` and don’t support `setup.py`.
- Python packaging is moving away from `setup.py`, making `pyproject.toml` the recommended standard.

### Better Dependency Management
- `pyproject.toml` natively supports optional dependencies (`[project.optional-dependencies]`).
- Works seamlessly with modern tools like `hatch`, `poetry`, and `pdm`.

---

## Handling Environment Variables and Customization in `pyproject.toml`

### Using Environment Variables in `pyproject.toml` (Hatch Example)
```toml
[tool.hatch.version]
source = "env"
variable = "PACKAGE_VERSION"
```
**Usage:**
```bash
export PACKAGE_VERSION="1.2.3"
pip install .
```

### Reading a Version File
Instead of dynamically computing the version in `setup.py`, we can store it in a file.

```toml
[tool.hatch.version]
path = "src/your_package/VERSION.txt"
```
Save `VERSION.txt` inside `src/your_package/`:
```
2.1.0
```
This way, the package reads the version from the file at build time.

---

## A Modern Python Package Template

For any new project, use the following structure:

```
your_package/
│── .github/
│   └── workflows/
│       └── ci.yml
│── src/
│   └── your_package/
│       ├── __init__.py
│       ├── main.py
│── tests/
│   ├── test_main.py
│── .gitignore
│── LICENSE
│── pyproject.toml
│── README.md
│── tox.ini
```

---

## Conclusion: Adopt `pyproject.toml` Today 🚀

By following these best practices, you ensure your package is aligned with modern Python packaging standards. The transition to `pyproject.toml` brings security, standardization, better tooling, and future-proofing benefits. 

If you're starting a new Python project today, `pyproject.toml` is the way to go. **Happy coding!** 🚀

## Official Resources for Modern Python Packaging

To deepen your understanding of modern Python packaging and the transition from `setup.py` to `pyproject.toml`, here are some official resources:

1. **[PEP 517 – A Build-System Independent Format for Source Trees](https://peps.python.org/pep-0517/)**  
   This PEP introduces a standardized interface for building Python packages, allowing for flexibility in build systems.

2. **[PEP 518 – Specifying Minimum Build System Requirements for Python Projects](https://peps.python.org/pep-0518/)**  
   This PEP outlines how to declare build system dependencies in `pyproject.toml`, ensuring reproducible builds.

3. **[PEP 621 – Storing Project Metadata in `pyproject.toml`](https://peps.python.org/pep-0621/)**  
   This PEP specifies how to write a project's core metadata in `pyproject.toml` for packaging-related tools to consume.

4. **[Python Packaging User Guide – Writing your `pyproject.toml`](https://packaging.python.org/en/latest/guides/writing-pyproject-toml/)**  
   A user-friendly guide on how to structure and write the `pyproject.toml` file for your projects.

5. **[Python Packaging User Guide – `pyproject.toml` Specification](https://packaging.python.org/en/latest/specifications/pyproject-toml/)**  
   The formal specification detailing the structure and usage of the `pyproject.toml` file.

6. **[pip Documentation – `pyproject.toml`](https://pip.pypa.io/en/stable/reference/build-system/pyproject-toml/)**  
   Explains how `pip` interacts with the `pyproject.toml` file during the build process.

7. **[Poetry Documentation – The `pyproject.toml` File](https://python-poetry.org/docs/pyproject/)**  
   Details how to use `pyproject.toml` with Poetry, a tool for dependency management and packaging in Python.

8. **[setuptools Documentation – Configuring setuptools using `pyproject.toml`](https://setuptools.pypa.io/en/latest/userguide/pyproject_config.html)**  
   Guidance on configuring `setuptools` through the `pyproject.toml` file.

These resources provide comprehensive information on the evolution of Python packaging and the recommended practices for using `pyproject.toml`.

---
date: 01.12.2021
title: Python troublershooting
weight: 101
prev: /docs/general-concepts
---
# Python Troubleshooting

Welcome in the gRPC Troubleshooting for Python.

## `pip3: not found`

`pip3` is a standard Python 3 package manager. Please follow the instruction [here](https://pip.pypa.io/en/stable/installation/) to install it.

## `<sdk-name>: not found`

Please ensure that you are using Python 3, not Python 2. You can do this by checking the python version:
```bash
python --version
```
The output should be like `python 3.8.10`.
We suggest using the `python3` command instead of raw `python`. We also suggest using `pip3` rather than `pip`.

## `FileNotFoundError: [Errno 2] No such file or directory: 'c++'`

The `grpcio` dependency (required by gRPC protocol) requires a C++ compiler, like GCC or MinGW.

| Platform | Solution |
| -- | -- |
| Linux/Ubuntu | `apt-get install g++` |
| Linux/Alpine | `apk add g++` |
| MacOS | install XCode package from App Store |
| Windows | install MinGW or cygwin compiler. The instruction is available [here](https://code.visualstudio.com/docs/cpp/config-mingw)|

## `Could not find <Python.h>. This could mean the following:`

You are missing the python developer headers.

| Platform | Solution |
| Linux/Alpine | 'apk add python3-dev' |
| Linux/Ubuntu | 'apt-get install python3-dev` |
| MacOs | This package is part of the official python3 package. Please reinstall the python3 package with brew |
| Windows | Python installer should handle it for you - please ensure that you have working python 3 installation. |

## `distutils.errors.CompileError: command '/usr/bin/gcc' failed with exit code 1`

The compilation process has failed. Please check the error log to get more information.

| Issue | Platform | Solution |
| `fatal error: linux/futex.h:` | Linux/Alpine | `apk add linux-headers` |
| `fatal error: linux/futex.h:` | Linux/Desktop | `apt-get install linux-generic` |


## Any other issue?

Please write to us at support[at]gendocu.com.
Please include the full error log, the reproduction steps, and the python version (`python3 --version`) in the email.

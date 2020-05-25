# pyenv for Windows using shim

Based on [pyenv][1] , and pyenv-win, I foked more simplified but adding build from source capabilities.
Generic use case is Poetry + Visual Source Code + Windows Console developers.

Basic functionality:
* Install python using nuget package : no registry changes required, installing old version with new version installed is possible
* Build from source is possible
* shim is borrowed from scoop project, but modified to support directory based .python-version 

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![GitHub issues open](https://img.shields.io/github/issues/inseopark/pyshim-win.svg?)](https://github.com/inseopark/pyshim-win/issues)

- [Introduction](#introduction)
- [pyenv](#pyenv)
- [pyenv-win commands](#pyenv-win-commands)
- [Installation](#installation)
   - [Get pyenv-win](#get-pyenv-win)
   - [Finish the installation](#finish-the-installation)
- [Usage](#usage)
- [How to get updates](#how-to-get-updates)
- [FAQ](#faq)
- [How to contribute](#how-to-contribute)
- [Bug Tracker and Support](#bug-tracker-and-support)
- [License and Copyright](#license-and-copyright)
- [Author and Thanks](#author-and-thanks)

## Introduction

[pyenv][1] for python is a great tool but, like [rbenv][2] for ruby developers, it doesn't support Windows directly. After a bit of research and feedback from python developers, I discovered they wanted a similiar feature for Windows systems.

I got inspired from the pyenv [issue][4] for Windows support. Personally, I use Mac and Linux with beautiful [pyenv][1], but some companies still use Windows for development. This library is to help Windows users manage multiple python versions.

I found a similar system for [rbenv-win][3] for ruby developers. This project was forked from [rbenv-win][3] and modified for [pyenv][1]. Some command aren't implemented, but it's good enough for basic use.

## pyenv

[pyenv][1] is a simple python version management tool. It lets you easily switch between multiple versions of Python. It's simple, unobtrusive, and follows the UNIX tradition of single-purpose tools that do one thing well.

## pyenv-win commands

```yml
   commands    List all available pyenv commands (* not yet implemented)
   local       Set or show the local application-specific Python version
   global      Set or show the global Python version
   shell       Set or show the shell-specific Python version (* not yet implemented required?)
   install     Install a Python version using python-build
   uninstall   Uninstall a specific Python version (*not yet implemented)
   rehash      Rehash pyenv shims (run this after installing executables)
   version     Show the current Python version and its origin
   versions    List all Python versions available to pyenv
   exec        Runs an executable by first preparing PATH so that the selected Python (not yet implemented)
```

## Installation

### Get pyshim-win

Get pyenv-win via one of the following methods. (Note: examples are in command prompt. For Powershell, replace `%USERPROFILE%` with `$env:USERPROFILE`. For Git Bash, replace with `$HOME`.)


- **With Git**
   - `git clone https://github.com/inseopark/pyshim-win.git %USERPROFILE%/.pyenv`

### Finish the installation
   
   1. Add a new variable under System variables in ENVIRONMENT with name:  
      `PYENV_ROOT` value: `%USERPROFILE%\.pyenv` 
   2. Now add the following paths to your ENVIRONMENT PATH variable in order to access the pyenv command (don't forget to separate with semicolons):
      - `%PYENV_ROOT%\bin`
      - `%PYENV_ROOT%\shims`
      - __ENVIRONMENT PATH :: This PC -> Properties -> Advanced system settings -> Advanced -> Environment Variables... -> PATH__
      - _Be careful! People who uses Windows (>= May 2019 Update) must put these items above `%USERPROFILE%\AppData\Local\Microsoft\WindowsApps`; See [this article](https://devblogs.microsoft.com/python/python-in-the-windows-10-may-2019-update/)._
   2. Verify the installation was successful by opening a new terminal and running `pyshim --version`
   3. Install any python version and make global 
      - ` pyshim install 3.8.2`
      - ` pyshim global 3.8.2`
   4. If you need specific python version for specific directory, change into directory and specify local version
      - ` cd /d {some where}`
      - ` pyshim local 3.7.7`
      - ` pyshim version `
      - ` 3.7.7 (set by C:\Apps\pyshim-win.git\version)`
   5. Run `pyshim` to see list of commands it supports. [More info...](#usage)

   Installation is done. Hurray!

## Usage

To be updated

## How to get updates

To be updated

## FAQ

- **Question:** Does pyshim-env (fork of pyenv-win) support python2?
   - **Answer:** No, only python 3 supported

- **Question:** Is there any limitation to build from source ?
   - **Answer:** Python version >= 3.6.3 supported.

To be updated


## How to contribute

- To be updated

## Bug Tracker and Support

- Please report any suggestions, bug reports, or annoyances with pyenv-win through the [GitHub bug tracker](https://github.com/pyenv-win/pyenv-win/issues).

## License and Copyright

- pyenv-win is licensed under [MIT](http://opensource.org/licenses/mit-license.php) *2019*

   [![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

## Author and Thanks

pyenv-win was developed by [Kiran Kumar Kotari](https://github.com/kirankotari) and [Contributors](https://github.com/pyenv-win/pyenv-win/graphs/contributors)

[1]: https://github.com/pyenv/pyenv
[2]: https://github.com/rbenv/rbenv
[3]: https://github.com/nak1114/rbenv-win


# Mozilla Build

Helper scripts for building, updating and otherwise maintaining several pieces of Mozilla software. Currently supported are

* [Firefox Nightly](https://wiki.mozilla.org/Firefox)
* [B2G aka. Firefox OS](https://wiki.mozilla.org/B2G)
* [B2G Desktop](https://developer.mozilla.org/en-US/docs/Mozilla/Firefox_OS/Using_the_B2G_desktop_client)

## Prerequisites

These scripts are tightly knit to my build environment Mac OS X 10.8. They assume that the following components are set up:

* Xcode + Command Line Tools
* Mac OS X SDK 10.6
* Android SDK
* [Homebrew](http://mxcl.github.io/homebrew/)

I recommend `ccache -M 10G` or more, and you should have at least 40 GByte free space on your hard drive.

## Usage

The general idea is `./desktop.sh init && ./desktop update && ./desktop build && ./desktop run`, but for the time being, please refer to the code for details.

## Current status

I currently do not intend to make these scripts user friendly beyond helping with repetitive tasks -- specifically mine --, but feel free to engage in discussions of where to go with them should you feel like it.

## References

This information is likely incomplete, wrong perhaps. When in doubt, please consult the full developer documentation for

* [Firefox](https://developer.mozilla.org/en/docs/Simple_Firefox_build)
* [Firefox OS](https://developer.mozilla.org/en-US/docs/Mozilla/Firefox_OS/Firefox_OS_build_prerequisites)
* [B2G-Desktop](https://developer.mozilla.org/en-US/docs/Mozilla/Firefox_OS/Using_the_B2G_desktop_client).


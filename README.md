# Mozilla Build

Helper scripts for building, updating and otherwise maintaining several pieces of Mozilla software. Currently supported are

 * [Firefox Nightly](https://wiki.mozilla.org/Firefox)
 * [B2G aka. Firefox OS](https://wiki.mozilla.org/B2G)
 * [B2G Desktop](https://developer.mozilla.org/en-US/docs/Mozilla/Firefox_OS/Using_the_B2G_desktop_client)

## Prerequisites

These scripts are tightly knit to my build environment Mac OS X 10.8. They assume that the following components are set up before running 

 * Xcode
 * SDK 10.6
 * Android SDK
 * [Homebrew](http://the.echonest.com/)

I recommend `ccache -M 10G` or more, and you should have at least 40 GByte free space on your hard drive.

## Usage

For the time being, please refer to the code.

## Current status

I currently do not intend to make these scripts more user friendly beyond helping with repetitive tasks, specifically mine, but feel free to engage in discussions of where to go with them.

## References

This information is likely incomplete. When in doubt, please consult the full developer documentation for

 * [Firefox](https://developer.mozilla.org/en/docs/Simple_Firefox_build)
 * [Firefox OS](https://developer.mozilla.org/en-US/docs/Mozilla/Firefox_OS/Firefox_OS_build_prerequisites)
 * [B2G-Desktop](https://developer.mozilla.org/en-US/docs/Mozilla/Firefox_OS/Using_the_B2G_desktop_client).


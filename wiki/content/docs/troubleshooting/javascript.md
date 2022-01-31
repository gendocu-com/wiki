---
date: 01.12.2021
title: Python troublershooting
weight: 101
prev: /docs/general-concepts
---
### `fatal: unable to access '...': server certificate verification failed. CAfile: /etc/ssl/certs/ca-certificates.crt CRLfile: none`

There might be multiple reasons for that issue:
1. Outdated system - Linux/Ubuntu: `sudo apt-get update && sudo apt-get upgrade`
1. Missing SSL packages - Linux/Ubuntu: `sudo apt-get apt-transport-https ca-certificates`
1. Update your certificates - in terminal run `sudo update-ca-certificate`
1. Please update the Git version - we recommend at least `2.30.2` git version. You can check your git version using `git --version`.


### `not found: git` or `Failed using git.`

You have to install git - you can find tutorial [here](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git).
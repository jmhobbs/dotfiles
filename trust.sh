#!/bin/bash

chmod 0700 ~/.gnupg

curl https://github.com/web-flow.gpg | gpg --import

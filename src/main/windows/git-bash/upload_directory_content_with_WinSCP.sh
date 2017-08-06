#!/usr/bin/env bash
# throttled upload to a ftp server
# each given directory must contain just as much files as the server can handle at once
# this was used with a ftp directory that was polled by a different service which timed out when more than 1000 files were present

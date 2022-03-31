#!/bin/sh

powershell start-process symlink.ps1 -ArgumentList $* -verb runas

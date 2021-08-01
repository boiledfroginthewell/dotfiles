#!/bin/bash

pkill --exact xcape
xcape -e '#102=Muhenkan;#100=Henkan;Menu=Return'
xcape -t 200 -e '#65=space'


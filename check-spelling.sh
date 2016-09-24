#!/bin/sh

cat *.tex chapters/*.tex | aspell list --mode=tex | sort | uniq -u | grep -vwFf spelling-whitelist | grep -vFf spelling-whitelist

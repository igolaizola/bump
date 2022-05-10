#!/bin/bash
echo Bumping Golang
./bump-golang.sh
echo
echo Bumping Cockroach DB
./bump-crdb.sh
echo
echo Bumping yq
./bump-yq.sh
echo

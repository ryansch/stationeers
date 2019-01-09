#!/bin/bash
set -e

/usr/local/bin/srcon --ip=127.0.0.1 --port=27500 --password=$PASSWORD status | grep "GameStatus : Running"

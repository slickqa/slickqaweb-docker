#!/bin/bash

kill -HUP `cat /var/run/uwsgi.pid`

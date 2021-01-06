#!/usr/bin/env sh

set -xe

config_files=""
for file in config/*.cfg; do config_files="${config_files} +exec $(basename "${file}")"; done

echo exec ~/ioquake3/ioq3ded.x86_64 \
	+set fs_game arena \
	+set sv_pure 0 \
	+bot_enable 0 \
	+set dedicated 2 \
	+set net_port 27960 \
	+exec server.cfg \
	+map q3dm17 \
	${config_files}

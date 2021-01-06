#!/usr/bin/env sh

set -xe

generate_config_files() {
    echo "Randomizing maps"
    index=1
    maps_template_file=~/ioquake3/baseq3/maps.cfg.tmpl
    maps_file=~/ioquake3/baseq3/maps.cfg

    cat /dev/null > "${maps_file}"
    for map in $(shuf < "${maps_template_file}"); do
	echo "set m${index} \"map ${map}; set nextmap vstr m$(("${index}" + 1))\"" >> "${maps_file}"
	index=$(("${index}" + 1))
    done
    sed -i '$s/vstr.*$/vstr m1"/' "${maps_file}"
    echo "vstr m1" >> "${maps_file}"
}

generate_config_files

config_params=""
for file in ~/ioquake3/baseq3/*.cfg; do config_params="${config_params} +exec $(basename "${file}")"; done

exec ~/ioquake3/ioq3ded.x86_64 \
	+set fs_game arena \
	+set sv_pure 0 \
	+bot_enable 1 \
	+set dedicated 2 \
	+set net_port 27960 \
	+map q3dm17 \
	"${config_params}"

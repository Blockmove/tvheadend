####Docker-Image tvheadend 4.1 (unstable)
***


based on Ubuntu 14.04

Volumes:

- config
- recordings
- data
- logos
- timeshift

Expose:

- 9981
- 9982

German timezone and locales

Example st start image with 2 double Tuner DVB-S cards:

	docker run -i -t --name tvheadend \
	    -p 9981:9981 -p 9982:9982 \
	    -v /mnt/data1/@appdata/tvheadend/config:/config \
	    -v /mnt/data2/@appdata/tvheadend/recordings:/recordings \
	    -v /mnt/data2/@appdata/tvheadend/data:/data \
	    -v /mnt/data2/@appdata/tvheadend/logos:/logos \
	    -v /mnt/data2/@appdata/tvheadend/timeshift:/timeshift \
	    --device /dev/dvb/adapter0/demux0:/dev/dvb/adapter0/demux0 \
	    --device /dev/dvb/adapter0/dvr0:/dev/dvb/adapter0/dvr0 \
	    --device /dev/dvb/adapter0/frontend0:/dev/dvb/adapter0/frontend0 \
	    --device /dev/dvb/adapter0/net0:/dev/dvb/adapter0/net0 \
	    --device /dev/dvb/adapter1/demux0:/dev/dvb/adapter1/demux0 \
	    --device /dev/dvb/adapter1/dvr0:/dev/dvb/adapter1/dvr0 \
	    --device /dev/dvb/adapter1/frontend0:/dev/dvb/adapter1/frontend0 \
	    --device /dev/dvb/adapter1/net0:/dev/dvb/adapter1/net0 \
	    --device /dev/dvb/adapter2/demux0:/dev/dvb/adapter2/demux0 \
	    --device /dev/dvb/adapter2/dvr0:/dev/dvb/adapter2/dvr0 \
	    --device /dev/dvb/adapter2/frontend0:/dev/dvb/adapter2/frontend0 \
	    --device /dev/dvb/adapter2/net0:/dev/dvb/adapter2/net0 \
	    --device /dev/dvb/adapter3/demux0:/dev/dvb/adapter3/demux0 \
	    --device /dev/dvb/adapter3/dvr0:/dev/dvb/adapter3/dvr0 \
	    --device /dev/dvb/adapter3/frontend0:/dev/dvb/adapter3/frontend0 \
	    --device /dev/dvb/adapter3/net0:/dev/dvb/adapter3/net0 \
	    blockmove/tvheadend
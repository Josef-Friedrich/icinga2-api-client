all: build debug

build:
	npm run build

debug:
	node --no-warnings debug.mjs

install_icinga:
	sudo apt install icinga2
	sudo icinga2 feature enable api
	sudo icinga2 api setup

set_test_config:
	sudo rsync -av --delete resources/etc-icinga2/ /etc/icinga2/
	sudo chown -R nagios:nagios /etc/icinga2/
	sudo systemctl restart icinga2.service

get_test_config:
	sudo rsync -av --delete /etc/icinga2/ resources/etc-icinga2/
	sudo chown -R jf:jf resources/etc-icinga2

patch_config:
	sudo cp /etc/icinga2-api-client.json /etc/icinga2-api-client.json.bak
	sudo cp resources/icinga2-api-client.json /etc/icinga2-api-client.json

test:
	npm run test
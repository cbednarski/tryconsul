deps:
	wget -q -nc https://dl.bintray.com/mitchellh/consul/0.5.0_linux_amd64.zip
	wget -q -nc https://dl.bintray.com/mitchellh/consul/0.5.0_web_ui.zip
	apt-get update -qq
	apt-get install -y unzip
	unzip -o 0.5.0_linux_amd64.zip
	unzip -o 0.5.0_web_ui.zip

install:
	stop consul || true
	cp /vagrant/consul /usr/local/bin/consul
	mkdir -p /opt/consul-ui
	cp -R /vagrant/dist/* /opt/consul-ui
	mkdir -p /etc/consul
	mkdir -p /var/lib/consul
	cp /vagrant/consul.json /etc/consul/consul.json
	cp /vagrant/consul.upstart.conf /etc/init/consul.conf
	restart consul || start consul
	sleep 1

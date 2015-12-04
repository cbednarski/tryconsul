deps:
	wget -q -nc https://releases.hashicorp.com/consul/0.6.0/consul_0.6.0_linux_amd64.zip
	wget -q -nc https://releases.hashicorp.com/consul/0.6.0/consul_0.6.0_web_ui.zip
	wget -q -nc https://github.com/cbednarski/hostess/releases/download/v0.1.0/hostess_linux_amd64
	apt-get update -qq
	apt-get install -y unzip
	unzip -o consul_0.6.0_linux_amd64.zip
	unzip -o consul_0.6.0_web_ui.zip -d dist


install:
	# Install hostess so we can edit the hosts file
	cp hostess_linux_amd64 /usr/local/bin/hostess
	chmod +x /usr/local/bin/hostess

	# Get IP address of the current machine from eth1
	ifconfig eth1 | grep "inet addr" | awk 'BEGIN { FS = "[ :]+" }{print $$4}' > /tmp/self.ip
	hostess add consul1 `cat /tmp/self.ip`

	# Install consul binaries
	stop consul || true
	cp /vagrant/consul /usr/local/bin/consul

	# Install consul UI
	mkdir -p /opt/consul-ui
	cp -R /vagrant/dist/* /opt/consul-ui

	# Add consul configuration
	mkdir -p /etc/consul
	mkdir -p /var/lib/consul
	sed 's/ADDR/'`cat /tmp/self.ip`'/g' /vagrant/consul.json > /etc/consul/consul.json

	# Setup consul service and start it
	cp /vagrant/consul.upstart.conf /etc/init/consul.conf
	restart consul || start consul
	sleep 1

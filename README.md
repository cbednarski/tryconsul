# TryConsul

[Consul](https://consul.io/) is a tool for service discovery, configuration, monitoring, and orchestration. TryConsul will help you spin up a cluster of Consul servers so you can see how it works. You will receive:

- Consul cluster
- Consul web UI
- Three VMs to play with

This project is part of [TryDB.io](https://trydb.io).

## Getting Started

Before you start, you'll need [Vagrant](https://www.vagrantup.com/) installed and git installed. TryConsul will work with VirtualBox or VMware (with the [VMware plugin for Vagrant](http://www.vagrantup.com/vmware)). Once this is setup, simply:

    $ git clone https://github.com/cbednarski/tryconsul
    $ cd tryconsul
    $ vagrant up

Vagrant will download the boxes, provision them, and install consul.

## Interacting with Consul

Consul will start automatically when you boot the instances, and should form a cluster automatically. You can see the command orchestration in the `Vagrantfile`.

    $ vagrant ssh consul1
    > Now inside VM
    $ consul members
    Node     Address             Status  Type    Build  Protocol
    consul1  172.16.59.198:8301  alive   server  0.5.0  2
    consul2  172.16.59.199:8301  alive   server  0.5.0  2
    consul3  172.16.59.200:8301  alive   server  0.5.0  2

You can replace `consul1` with `consul2` or `consul3` to login to those respective VMs.

Try some other commands:

    $ consul exec ifconfig

## Consul Web UI

You can also view the consul web UI by hitting one of the nodes on port `:8500`. You can see your IPs via `consul members` or using `vagrant ssh-config` (you IPs will be different).

    $ vagrant ssh-config | grep HostName
    HostName 172.16.59.198
    HostName 172.16.59.199
    HostName 172.16.59.200

Select any of your IPs and open it in your browser: http://172.16.59.198:8500/ui

## Next Steps

Consul has a comprehensive featureset for building distributed systems, including monitoring, configuration, mutexes, and more.

- Run [commands](https://consul.io/docs/commands/exec.html) across your cluster
- Put some data in the [key-value store](https://consul.io/docs/agent/http/kv.html)
- Try adding [a service](https://consul.io/docs/agent/services.html)
- Try adding [a healtcheck](https://consul.io/docs/agent/checks.html)
- Configure security options like [encryption](https://consul.io/docs/agent/encryption.html) or [ACLs](https://consul.io/docs/internals/acl.html)

Learn about more features in the [Consul documentation](https://consul.io/docs/index.html).

## Cleanup and Troubleshooting

When you're done, you can shut down the cluster using

    $ vagrant halt

And free up some disk space using

    $ vagrant destroy -f

If you want to change consul configuration, run

    $ vagrant provision

If you run into problems, you can see consul's logs via:

    $ consul monitor
    or
    $ tail /var/log/syslog

If you edit the consul configuration file and have trouble running `vagrant provision`, try:

    start consul

And watch the output.

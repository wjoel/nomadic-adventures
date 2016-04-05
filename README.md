Nomadic adventures
------------------

A series of adventures involving:

- [Nomad](https://www.nomadproject.io/)
- [Consul](https://www.consul.io/)
- [Vagrant](https://www.vagrantup.com/)
- [Packer](https://www.packer.io/)
- [Ansible](https://www.ansible.com/)
- [Graylog](https://www.graylog.org/)
- [Docker](https://www.docker.com/)
- [Alpine Linux](http://www.alpinelinux.org/)

Building
--------
To build the Docker images you need to set up a
[Docker registry](https://docs.docker.com/registry/deploying/)
if you want to build the Docker images yourself.

If you don't want to do that, you can use the images I built and published on
[Docker Hub](https://hub.docker.com/)

Running
-------

Next, you need to set up Nomad and Consul somewhere. It's not particularly
difficult to run them on your own machine in development mode, but since that
requires you to also have Docker installed, you can use the provided
Vagrantfile and simply run:

    $ git clone https://github.com/wjoel/nomadic-adventures
    $ cd vagrant
    $ vagrant up

This will start a virtual machine with Nomad running in *client* mode, which
means that it will be running the Nomad jobs you submit to a Nomad *server*.
Ideally, you should therefore be running a Nomad server on your own machine,
to get a feel for how a Nomad cluster works in practice. You can find an
example Nomad config in `nomad/config/example.json` which uses the virtual
machine.

If for some reason you can not do even that, though, you can use Vagrant to
run Nomad in development mode, where the Nomad process will act as both server
and client. To do so, use the environment variable `NOMAD_DEV`:

    $ export NOMAD_DEV=1
    $ vagrant up


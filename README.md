# Amazon experiment setup

This experiments consists of one server and N clients.
The experiment tests the scalability of the TPF Query Streamer, C-SPARQL and CQELS using CityBench.
The N clients are only required for the TPF Query Streamer clients. For C-SPARQl and CQELS everything runs on the server anyways.
The server will be aware of the pool of N clients and when TPFQS is evaluated, it will start TPFQS clients on the remote client machines.
It does this by connecting to those machines over SSH and starting a Docker container image of the TPFQS.
Those running containers can access the server.
The server will capture query output of those containers over one SSH connection for each container on each machine,
it will also keep an SSH connection open to capture CPU and memory usage for each container on each machine.

## Setup server
1. Create a server machine on Amazon (For example `c3.2xlarge`, which has 8 cores and 15GB of RAM).
   Make sure this is part of a VPC and Placement Group which will be used for all machines in this experiment.
   Save your private key in this directory as cert.pem or symlink it to here.
   These scripts are built for the Amazon Machine Image.
2. Assign an Elastic IP to the server, or use some other way to make it reachable.
3. Run `./transmit.sh <server-host>`, this places all required bootstrap files on the server
4. Run `./install-server <server-host>`, this will install the required server packages, mainly Docker.

## Setup client
1. Create a client machine on Amazon (For example same as server)
   This MUST be part of the same VPC and Placement Group as the server.
   For your convenience, use the same key as for the server.
   You should also use the Amazon Machine Image here.
2. Assign a (temporary) EIP to the server, or use some other way to make it reachable.
3. Change the `bootstrap-client.sh` script to include the correct PRIVATE server ip.
   The client will use this ip in its `/etc/hosts` file to map it to the `server` hostname.
   If something fails with this, you should do this change manually in `/etc/hosts`.
   Private ip's will persist over machine shutdowns, so don't worry about that.
3. Run `./transmit.sh <client-host>`, this places all required bootstrap files on the client
4. Run `./install-client <client-host>`, this installs Docker and prepares the TPFQS client container image.
5. This is the time to make a client image, using for example the Amazon web interface.
   Use this to create N client machines. (Not necessary to do this all at once, if you want to do some debugging first)

## Register clients
For each client
1. Run `./register-client.sh <public server hostname> <private client ip> <client-id, excluding 'c'> <public client hostname>`,
   this will add `cn` to the `/etc/hosts` file on the server, `server` to the `/etc/hosts` file on the client.
   It will also ENABLE password-based SSH access to the client, since Amazon disables this when starting new machines with some SSH key-pair.
   We need this because the server needs to be able to access the client using `remote-admin:remote-admin`.

## Debugging
It is highly recommended to test the following things before running the experiments:
* You MUST be able to ping all clients `c0` -> `cn` from the server machine.
  Next to this, you also MUST be able to ssh to them using the `remote-admin` account with password `remote-admin`. (Unsafe, I know, but otherwise manual experiment setup work would even be worse...)
* Each client machine MUST be able to ping `server`. Eventually, it MUST be able to connect to it over port `3001` for accessing the TPF interface, but
  this will only work once the TPFQS experiment is running.


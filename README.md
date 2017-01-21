# ssh-tunnel
A ssh client container, used to create a ssh tunnel for ports forword.

## Tags and `Dockerfile` links
- [`latest` (latest/dockerfile)](https://github.com/mengzyou/docker-ssh-tunnel/blob/master/Dockerfile)  

## How to use

Example, from network A, we can ssh to a host in network B via IP (112.1.222.1), and in the network B, anohter host with private IP (192.168.9.100) expose services (80,443).  
Then you want the hosts in network A to access the services (80,443) exposed in network B, then you can use this container to create a ssh tunnel for ports (80,443) forword.  

Run this container in one of docker host in network A which can ssh to network B via a private key and use 'aaa':  

```shell
docker run -td --restart unless-stopped \
  -p 80:80 -p 443:443 \
  -e SSH_REMOTE_USER=aaa \
  -e SSH_REMOTE_PORT=22 \
  -e 112.1.222.1 \
  -e 192.168.9.100 \
  -e SSH_REMOTE_FORWORD_PORTS=80,443 \
  -v /ssh/id_rsa:/root/.ssh/id_rsa \
  mengzyou/ssh-tunnel:latest
```

**Note**: You must use **-v** to bind the private key for ssh, and expose the related ports for other hosts access.  

The default ENV values:  

- SSH_REMOTE_USER="root"  
- SSH_REMOTE_PORT="22" 
- SSH_REMOTE_IP="127.0.0.1"  
- SSH_REMOTE_FORWORD_IP="127.0.0.1"  
- SSH_REMOTE_FORWORD_PORTS="80"  

## Why use this image

Actaully, this image is provide a ssh client, you can directly use ssh clinet to do this.  
For docker container, we can create the ssh tunnel as service, and use docker's management function, restart the tunnel when it disconnent.  

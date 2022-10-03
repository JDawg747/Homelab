# Homelab Documentation 
Purpose: Josh's Homelab Notes

## Resources
* [PenTestMonkey PHP Reverse Shell](https://pentestmonkey.net/tools/web-shells/php-reverse-shell)
* [Daniel Miessler's SecLists](https://github.com/danielmiessler/SecLists)
* [Ubuntu 20.04.4 LTS](https://releases.ubuntu.com/20.04.4/)
* [Kali Linux](https://www.kali.org/)
* [KDE Plasma Desktop Environment](https://kde.org/distributions/)
* [GNOME Desktop Environment](https://www.gnome.org/)

## Docker
* Docker Installation
    ```bash
    sudo apt-get install docker.io docker-compose -y
    ```
* Docker Uninstallation
    ```bash
    sudo apt purge docker.io
    ```
* Installing the [Docker Engine](https://docs.docker.com/engine/install/) manually is sometimes required.

* Docker Compose 
    ```bash
    sudo docker-compose up -d
    ```
    ```bash
    sudo docker-compose down 
    ```
    
* Docker MacVLAN Network Setup
    ```bash
    docker network create -d macvlan --subnet 192.168.23.0/24 --ip-range 192.168.23.0/25 --gateway 192.168.23.1 -o parent=ens33 doc0
    ```
* Container Management Commands: 
    * Lists the last five created containers (stopped or running) ``docker container ls -5 `` 
    * Lists all running containers ``docker ps``
    * Stops the specified Docker container ``docker stop [ID]``
    * Deletes the specified Docker container ``docker container rm [ID]``
    * Inspect a Docker container ``docker inspect [ID] | grep "IP"``

### Portainer 
[Portainer](https://www.portainer.io/) is a web GUI for Docker that makes it easy to deploy, configure, and secure containers very fast on Docker. 

* [Installation Docs](https://docs.portainer.io/start/install/server/docker/linux)
* Docker CLI Installation Command:

    ```bash
    docker run --network doc0 -d -p 8000:8000 -p 9443:9443 --name portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce:latest
    ``` 

### Pi-hole
[Pi-hole](https://pi-hole.net/) is a [DNS](https://www.cloudflare.com/learning/dns/what-is-dns/) server that provides network wide protection, while improving network performance. 
* [Ad-list collection](https://firebog.net/)
* More info at https://github.com/pi-hole/docker-pi-hole/ and https://docs.pi-hole.net/
* Docker CLI Installation Command:

    ```bash
    docker run --network doc0 -d \
        --name pihole \
        -p 53:53/tcp -p 53:53/udp \
        -p 80:80 \
        -p 443:443 \
        -e TZ="America/New_York" \
        -v "$(pwd)/etc-pihole/:/etc/pihole/" \
        -v "$(pwd)/etc-dnsmasq.d/:/etc/dnsmasq.d/" \
        --dns=127.0.0.1 \
        --dns=9.9.9.9 \ 
        --restart=unless-stopped \
        pihole/pihole:latest
    ```    

* Docker CLI Command to Change Admin Password:

    ```bash
    docker exec -it pihole pihole -a -p
    ```

* Stop DNS Revolver Service (Ubuntu Only).

    ```bash
    sudo systemctl stop systemd-resolved.service
    sudo systemctl disable systemd-resolved.service
    sudo nano /etc/resolv.conf 
    ```
 


### Apache Guacamole 
[Guacamole](https://guacamole.incubator.apache.org/) is a clientless remote desktop gateway with support for many popular protocols such as VNC, RDP, and SSH. 

* Run the below command to install Guacamole from the [oznu/guacamole](https://hub.docker.com/r/oznu/guacamole/) image. 

    ```bash
    docker run --network doc0 \
      -p 8080:8080 \
      -v /guacamole:/config \
      oznu/guacamole
    ```

### Jellyfin
[Jellyfin](https://jellyfin.org/) is a self hosted application that allows you to access videos, music, and photos from one place anywhere over your local LAN.

* [Docker Image](https://hub.docker.com/r/linuxserver/jellyfin)

### Watchtower
[Watchtower](https://containrrr.dev/watchtower/) is a container based application that automates the process of updating Docker container images. 

### File Browser 
[File Browser](https://github.com/filebrowser/filebrowser) is a self-hosted and open source web based file browsing application that allows for the creation, editing, and moving of files. 

* [TechnoTim Documentation](https://docs.technotim.live/posts/meet-file-browser/)

## Kasm Workspaces 
[Kasm](https://www.kasmweb.com/) is an application that allows you to stream containerized workspaces from a browser. 
* Installation Command: 
    ```bash
    sudo fallocate -l 4g /mnt/4GiB.swap
    sudo chmod 600 /mnt/4GiB.swap
    sudo mkswap /mnt/4GiB.swap
    sudo swapon /mnt/4GiB.swap
    cat /proc/swaps
    echo '/mnt/4GiB.swap swap swap defaults 0 0'| sudo tee -a /etc/fstab
    wget https://kasm-static-content.s3.amazonaws.com/kasm_release_1.10.0.238225.tar.gz
    tar -xf kasm_release*.tar.gz
    cd kasm_release
    sudo bash ./install.sh  
    ```
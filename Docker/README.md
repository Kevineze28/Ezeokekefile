# 🚀 Installing Jenkins the Hard Way vs. Docker — A Practical Walkthrough

This project documents my experience deploying Jenkins on an AWS EC2 Ubuntu server — first understanding the cumbersome traditional installation process, then using Docker to drastically simplify everything.

---

## 🖥️ Installing Jenkins from Scratch: The Cumbersome Way

Manually installing Jenkins requires several steps including server provisioning, dependency installations, and extensive configuration.
My workflow looked like this:
1. Launch an EC2 Instance
I started an Ubuntu EC2 instance on AWS.
Configured the security group to allow inbound TCP traffic on port 8080 and port 22.

2. Connect to the Instance
Used the AWS EC2 browser-based terminal to access the instance. 

---

## 🐳 Install Docker Engine
With sudo privileges, I installed Docker by running the following:
```bash
- sudo apt update
- sudo apt install ca-certificates curl gnupg lsb-release -y

- sudo install -m 0755 -d /etc/apt/keyrings
- curl -fsSL https://download.docker.com/linux/ubuntu/gpg | - sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

- echo \
"deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" \
| sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

- sudo apt update
- sudo apt install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y
 ```

---

### ✔️ Validate Docker Installation

1. Then i validated docker insallation by running the following: 
```bash
sudo systemctl status docker
sudo docker run hello-world
```

### 🧰 Deploy Jenkins Using Docker

1. Then i pulled  the Jenkins image using the following: 
```bash
sudo docker pull jenkins/jenkins:lts-jdk17
```
2. Run Jenkins Container 
```bash
- sudo docker run -d \
 -v jenkins_home:/var/jenkins_home \
 -p 8080:8080 -p 50000:50000 \
 --restart=on-failure \
 jenkins/jenkins:lts-jdk21
```
3. Access Jenkins
I was able to access the Jenkins URL page, once i saw Unlock Jenkinsa i knew the deployment was succesful. However i used the folloiwng to access Jenkins:
```bash
http://<public-ip>:8080
```
### ⭐ Why Docker Made a Difference

Docker simplifies what would be a time-consuming error-prone process due to the following: 
```bash
- Fast deployment — no OS-level configuration.
- Isolation & security — Jenkins runs independently from the host OS.
- Consistency — works the same across environments.
- Self-contained package — includes all dependencies.
- Simple maintenance — easy to start, stop, or remove Jenkins.
- Easy portability — spin up new Jenkins instances in seconds.
```
### 🔑 Key Docker Commands Used
The key commnads i used in this project to run various commands on my docker container are as follows:

```bash

| Command                                              | Purpose                                      |
| ---------------------------------------------------- | -------------------------------------------- |
| `docker image ls`                                    | List local Docker images                     |
| `docker container ls`                                | List running containers                      |
| `docker inspect <container_id>`                      | View container details                       |
| `docker stop <container_id>`                         | Stop a running container                     |
| `docker start <container_id>`                        | Start a stopped container                    |
| `docker exec -it <container_id> bash`                | Access container shell                       |
| `cat /var/jenkins_home/secrets/initialAdminPassword` | Retrieve Jenkins admin password              |
| `docker rm -f <container_id>`                        | Remove a container                           |
| `docker container ls -a`                             | List all containers (including stopped ones) |
```


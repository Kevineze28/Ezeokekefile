
# 🖥️ High-Availability Server Automation with Ansible

This project demonstrates how to use Ansible to automate configuration management and orchestration across multiple servers.  
It provides a consistent and reliable way to execute ad-hoc commands on specific groups of servers and to run Ansible playbooks across an entire infrastructure — all from a single control node.

---

## 🚀 What It Does

This project automates common administrative and deployment tasks using Ansible, including:

1. Creating multiple EC2 instances (Ubuntu) in AWS and assigning a key pair to all instances.  
2. Managing groups of EC2 servers defined in an inventory/hosts file.  
3. Running ad-hoc commands on specific server groups for quick automation.  
4. Executing Ansible playbooks to perform configuration management or deployments across all servers.  
5. Simplifying server administration through Infrastructure as Code (IaC) principles.

---

## 💡 Key Benefits

| Benefit | Description |
|----------|-------------|
| **Centralized Control** | Manage all servers from a single Ansible control node. |
| **Consistency** | Ensure uniform configuration and deployments across environments. |
| **Scalability** | Easily add or remove servers by editing the inventory/hosts file. |
| **Efficiency** | Quickly execute ad-hoc commands (e.g., `ansible all -m ping`) to perform real-time tasks. |
| **Reusability** | Playbooks and roles can be reused across environments and projects. |

---

##🧱 Architecture Overview

The Ansible setup includes the following key components:

1. **Control Node** – The system where Ansible is installed and commands are executed (installed on AWS Cloud Shell).  
2. **Managed Nodes** – The EC2 servers managed via SSH.  
3. **Inventory / Host Files** – Define the servers and their groupings for management.  
4. **Playbooks** – Define the desired configurations and automation tasks.  
5. **Ad-hoc Commands** – Quick, one-line commands executed directly

---

## 🧰  Tech Stack

| Tool | Purpose |
|------|----------|
| **Ansible** | Configuration management & orchestration |
| **YAML** | Declarative syntax for playbooks |
| **Linux (Ubuntu)** | Operating system for control and managed nodes |
| **AWS Cloud Shell** | Execution environment for Ansible commands |
| **Amazon Web Services (AWS)** | Cloud infrastructure provider |

---


---

##⚙️ Configuration Files

### Inventory / Hosts File

```ini
[ec2servergroup1]
<server_ip_1> ansible_user=ubuntu ansible_ssh_private_key_file=~/keys/EC2_instance_keypair.pem

[ec2servergroup2]
<server_ip_2> ansible_user=ubuntu ansible_ssh_private_key_file=~/keys/EC2_instance_keypair.pem

[ec2servergroup3]
<server_ip_3> ansible_user=ubuntu ansible_ssh_private_key_file=~/keys/EC2_instance_keypair.pem

[ec2servergroup4]
<server_ip_4> ansible_user=ubuntu ansible_ssh_private_key_file=~/keys/EC2_instance_keypair.pem
```

###🧾Playbooks.yml 

```ini
---
- name: Install and Start Apache Web Server on Ubuntu
  hosts: all
  become: yes

  tasks:
    - name: Update apt package cache
      ansible.builtin.apt:
        update_cache: yes
        cache_valid_time: 3600

    - name: Install Apache2 package
      ansible.builtin.apt:
        name: apache2
        state: present
```
### 🏁 Summary 

This project provides a scalable, consistent, and efficient automation framework using Ansible for managing multiple EC2 instances.
It leverages Infrastructure as Code (IaC) principles to simplify deployments, ensure configuration consistency, and improve operational reliability.

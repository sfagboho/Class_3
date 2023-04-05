#!/bin/bash

# Create User
sudo ansible all -m user -a "name=automation state=present password='{{ 'devops' | password_hash('sha512') }} update_password=on_create'" -u root 

# Send key over
sudo ansible all -m authorized_key -a "user=automation key='{{ lookup('file', '/home/automation/.ssh/id_rsa.pub') }}' state=present" -u root 

# Allow priviledge 
 sudo ansible all -m copy -a "content='automation      ALL=(ALL)       NOPASSWD: ALL' dest=/etc/sudoers.d/automation mode=0400 owner=automation group=automation" -u root 

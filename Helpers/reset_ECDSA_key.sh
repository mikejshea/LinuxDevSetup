ssh-keygen -R 192.168.162.101
ssh-keygen -R 192.168.162.102
ssh-keygen -R 192.168.162.103
ssh-keygen -R 192.168.162.110



ssh-keyscan -H 192.168.162.101 >> ~/.ssh/known_hosts
ssh-keyscan -H 192.168.162.102 >> ~/.ssh/known_hosts
ssh-keyscan -H 192.168.162.103 >> ~/.ssh/known_hosts
ssh-keyscan -H 192.168.162.110 >> ~/.ssh/known_hosts


ssh-keygen -R 192.168.162.200
ssh-keygen -R 192.168.162.201
ssh-keygen -R 192.168.162.202

ssh-keyscan -H 192.168.162.200 >> ~/.ssh/known_hosts
ssh-keyscan -H 192.168.162.201 >> ~/.ssh/known_hosts
ssh-keyscan -H 192.168.162.202 >> ~/.ssh/known_hosts

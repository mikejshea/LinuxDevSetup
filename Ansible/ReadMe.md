ansible-playbook -i production db-pre-recs.yml --syntax-check
ansible-playbook -i production db-pre-recs.yml --flush-cache

ansible-playbook -i production dbservers.yml --syntax-check
ansible-playbook -i production dbservers.yml --flush-cache

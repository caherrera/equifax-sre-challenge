

test-ansible:
	cd provision && ansible-playbook -i hosts.ini playbook.yml --syntax-check



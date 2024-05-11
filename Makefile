

test-ansible:
	cd provision && ansible-playbook -i hosts.ini playbook.yml --syntax-check


get-secret:
	aws secretsmanager get-secret-value --secret-id dev-wordpress-db --query SecretString --output text | jq
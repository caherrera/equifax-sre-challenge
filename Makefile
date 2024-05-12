
# define function
define upload-config
	scp wp-config.php $(1):~/
	ssh $(1) 'sudo mv ~/wp-config.php /var/www/wordpress/wp-config.php;sudo chown www-data:www-data /var/www/wordpress/wp-config.php; sudo chmod 640 /var/www/wordpress/wp-config.php;'
endef

test-ansible:
	cd provision && ansible-playbook -i hosts.ini playbook.yml --syntax-check


get-secret:
	aws secretsmanager get-secret-value --secret-id dev-wordpress-db --query SecretString --output text | jq


upload-wp-config:
	$(call upload-config,eq-wordpress-a)
	$(call upload-config,eq-wordpress-b)


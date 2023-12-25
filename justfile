deploy:
    ansible-playbook -i ansible/inventories ansible/playbooks/site.yml

deploy-password:
    ansible-playbook -i ansible/inventories ansible/playbooks/site.yml --ask-become-pass

lint:
    hadolint Dockerfile
    yamllint ansible/
    ANSIBLE_ROLES_PATH=./ansible/roles ansible-lint

test:
    cd ansible/roles/sample-role && molecule test
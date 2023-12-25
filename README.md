# Ansible Playbook Template

This is the template I am using when writing new playbooks.

## Table of Contents

- [Requirements](#requirements)
- [Usage](#usage)
- [Contributing](#contributing)
- [License](#license)

## Requirements
- Docker (there is no reason podman couldn't work but it is not what I personally use)
- An AMD64 or ARM64 architecture, if running inside of the included dev container.

If you are not running in a dev container, the following utilities are used alongside the ansible suite itself:

- [Docker](https://www.docker.com) or [Podman](https://podman.io) to utilize containerization in testing with `molecule`
- [SOPS](https://github.com/getsops/sops) for encrypting sensitive information, using [age](https://github.com/FiloSottile/age) for encryption
- [Gitleaks](https://github.com/gitleaks/gitleaks) so sensitive data gets caught before commit
- [Hadolint](https://github.com/hadolint/hadolint) for `Dockerfile` linting
- [yq](https://github.com/mikefarah/yq) for YAML parsing wherever necessary.  Note that there appear to be two popular `yq` libraries out there, but this is the one I am using.
- Optional: [Just](https://github.com/casey/just) for convenient command-line running.

## Usage

There is no reason why you can't run it standalone in your own development environment, but for convenience I am utilizing a [Visual Studio Code Development Container](https://code.visualstudio.com/docs/devcontainers/containers) environment, which encapsulates all of the utilities required to operate, including the VS Code plugins that aid in development.

The `Dockerfile` to create the dev environment uses specific versions of as many libraries as possible.  The benefit is that something shouldn't magically break when you have built the exact same container for the 143rd time.  The downside is that with enough lack of maintenance things can fall out of rev.  I use `apt-cache policy <package>` every so often just to ensure everything is reasonably up to date.

I also use the [Just command runner](https://github.com/casey/just) for convenience.  You can see all eligible commands with `just --list`.  By convention, my naming scheme is as follows:

- `deploy` - Primary playbook execution of every eligible host
- `deploy-password` - Primary playbook execution but password is required for `sudo` operations
- `deploy-<host>` - Primary playbook execution of the given host
- `lint` - Perform all linting operations
- `test` - Perform all testing operations

## Linting
The following linters are used:

- [hadolint](https://github.com/hadolint/hadolint) for Dockerfile linting
- [yamllint](https://github.com/adrienverge/yamllint) for YAML linting
- [ansible-lint](https://github.com/ansible/ansible-lint) for Ansible-specific checks in YAML files

## Testing
I am using [molecule](https://ansible.readthedocs.io/projects/molecule/) for testing roles and/or playbooks.  Wherever possible, it utilizes containerization, but in cases where that is not reasonable, Vagrant and Virtualbox are used to spin up full VMs.  In those cases where Vagrant/Virtualbox are used, testing support is only available for amd64 architectures.

## Thank You
- The numerous anonymous people who ask and answer questions on [StackOverflow](https://stackoverflow.com)
- [OpenAI](https://openai.com) and [CoPilot](https://github.com/features/copilot) for changing the way I learn and develop
- Fellow St. Louisan [Jeff Geerling](https://www.jeffgeerling.com) for his relentless devotion to Ansible, and his maintenance of [numerous container images](https://github.com/geerlingguy?tab=repositories) that make `molecule` testing possible with `systemd`

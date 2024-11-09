# Mac Bootstrap

Set up a Mac workstation using Ansible.

## Pre-requisites

You can override config locally by creating a `config.yaml` in this directory with your overrides.

## Running

You either bootstrap it via `curl`, or clone the repo and run it locally.

### Bootstrap

``` bash
curl -L -H 'accept: application/vnd.github.v3.raw' "https://api.github.com/repos/jshiell/mac-bootstrap/contents/bootstrap" | bash
```

### Cloning and running locally

```bash
git clone git@github.com:jshiell/mac-bootstrap.git
cd workstation-bootstrap
./setup
```

Alternately you can just run certain parts of it (see the tags in `main.yml`), e.g.

```bash
./setup "homebrew,nvm"
```

## Credits

Very much inspired and influenced by [geerlingguy/mac-dev-playbook](https://github.com/geerlingguy/mac-dev-playbook/).

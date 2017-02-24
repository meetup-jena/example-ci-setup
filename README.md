# example-ci-setup

A simple example project that aims to show you: 

- How to develop ansible playbooks.
- How you can run these scripts against a virtualized (os level, system level) environment.
- How you can then introduce tests to ensure your ansible playbook is working as it should.

## The example project: Gitlab and Gitlab-CI-Runner Ansible roles

Goal is to set up a gitlab along with a gitlab-ci-runner, so you can introduce a sample project that can be build and tested.

## OS level virtualization vs. System level virtualization

Goal is to understand how you can use vagrant or docker to arbitrarily run your ansible roles. 

## Testing ansible playbooks: Use- or wasteful

Goal is to understand whether or not to run tests against ansible provisioned systems to find out, if the result of the applied playbooks can be also rolled out to a production system.

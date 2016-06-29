Title: Handling timeouts in Ansible AWS modules
Category: tech
Tags: ansible, aws, ec2, timeouts
Author: Maciej Lasyk
Summary: Couple words about working with AWS timeouts in Ansible

<center>![AWS]({filename}/images/AWS_Logo.png)</center>

## Timeouts in AWS? ##

Yup, it's completely normal, that sometimes between your laptop and AWS API something
doesn't work as stable as you'd like it to. We hit random timeouts and we have to
re - run our playbooks.

## Timeouts in Ansible? ##

Looking for any "timeout" configuration directive in ansible.cfg [I found this](http://docs.ansible.com/ansible/intro_configuration.html#timeout) -
it actually doesn't help. We might just set a longer timeout for SSH connections. But
AWS modules connects to API using boto library.

## So what's the problem once again? ##

Let's say that we have the following playbook:

```
- hosts: localhost
  connection: local
  tasks:
  - name: Create security group
    ec2_group:
      name: "test_sg"
      state: "present"
      vpc_id: "some_vpc"
      purge_rules: False
      purge_rules_egress: False
    register: ec2_group

  - name: Tag security group
    ec2_tag:
      resource: "{{ ec2_group.group_id }}"
      state: "present"
      tags: "{{ some_defined_tags }}"
    register: ec2_group_tags

  - name: Apply permissions on security group
    ec2_group:
      name: "test_sg"
      state: "present"
      vpc_id: "some_vpc"
      rules: "{{ some)defined_rules }}"

  - name: Provision a set of instances
    ec2:
      group_id: "{{ ec2_group.group_id }}"
      instance_type: "t2.large"
      image: "some_ami"
      vpc_subnet_id: "some_vpc"
      count_tag: "some_tag"
      exact_count: "3"
      wait: true
      instance_tags: "{{ some_defined_tags }}"
      zone: "some_zone"
    register: ec2
```

And now let's say that it fails randomly because of timeouts that happens over time -
and those timeouts hit random tasks.

We could simply re - run the job and thanks to idempotency it would just make sure
that it was all finished up.

Also we could simply retry starting from failing step:

```
PLAY RECAP ********************************************************************
           to retry, use: --limit @/home/user/playbook.retry
```

## Anything more civilized? ##

Actually there's another method. Not sure if it is more civilized, but it works
and makes the Ansible playbook finish successfully more frequently.

It's a simple **do - until** loop [documented here](http://docs.ansible.com/ansible/playbooks_loops.html#do-until-loops)

Using this approach we might add error - handling and retry policy to above playbook
so we could get something like the following one;

```
- hosts: localhost
  connection: local
  tasks:
  - name: Create security group
    ec2_group:
      name: "test_sg"
      state: "present"
      vpc_id: "some_vpc"
      purge_rules: False
      purge_rules_egress: False
    register: ec2_group

    until: ec2_group.failed is not defined or ec2_group.failed == false
    retries: "3"
    delay: "30"

  - name: Tag security group
    ec2_tag:
      resource: "{{ ec2_group.group_id }}"
      state: "present"
      tags: "{{ some_defined_tags }}"
    register: ec2_group_tags

    until: ec2_group_tags.failed is not defined or ec2_group_tags.failed == false
    retries: "3"
    delay: "30"

  - name: Apply permissions on security group
    ec2_group:
      name: "test_sg"
      state: "present"
      vpc_id: "some_vpc"
      rules: "{{ some)defined_rules }}"
    register: ec2_group_perms

    until: ec2_group_perms.failed is not defined or ec2_group_perms.failed == false
    retries: "3"
    delay: "30"

  - name: Provision a set of instances
    ec2:
      group_id: "{{ ec2_group.group_id }}"
      instance_type: "t2.large"
      image: "some_ami"
      vpc_subnet_id: "some_vpc"
      count_tag: "some_tag"
      exact_count: "3"
      wait: true
      instance_tags: "{{ some_defined_tags }}"
      zone: "some_zone"
    register: ec2

    until: ec2.failed is not defined or ec2.failed == false
    retries: "3"
    delay: "30"
```

It's very simple and works just fine. Of course retry and delay values are good subject
to be parametrized and put into variable.

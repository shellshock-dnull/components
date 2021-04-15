Role Name
=========

Component-oriented ansible role. Allow quick and easy install, configure, and run common programs. Also, great tool to manage your .dotfiles via ansible.

Requirements
------------

No additional requirements.

Role Variables
--------------

Check defauls/mail.yaml comments for more info.

```yaml
role_component:
  # when changing files, should role keeps file backups
  backup: true

  # where store rendered self-generated tasks
  render_dir: "{{ playbook_dir }}/component_rendered_tasks"

  # after component changed, force its restart?
  force_restart:  false

  # continue on errors?
  ignore_errors:  true

  # list of compoents to be installed, configures, runned on host
  components:     []

  # default component user
  user:   "{{ ansible_user }}"

  # default component group
  group:  "{{ ansible_user }}"

  # default component group
  mode:   644

  # default component runner
  run:    systemd
```


Dependencies
------------

No deps.

Example Playbook
----------------

Real life useage can be found [here](https://gitlab.com/shellshock.dnull/ansible). 

`playbook.yml`
```yaml
- hosts: all
  gather_facts: true
  roles:
    - role: ansible-role-component
      tags:
        - components
```

`group_vars/all/dunst.yml`
```yaml
role_component:
  components:
  - dunst # Install and configure Dunst Notification Manager
```

`group_vars/all/dunst.yml`
```yaml
role_component:
  dunst:
    name: "Dunst - Notification Manager"
    install:
      packages:
        - dunst
    configs:
      variables:
        follow: "none"
        font: "Iosevka 11"
      templates:
        - dunst
      post:
        - name: "kill dunst"
          shell: "pkill dunst || echo 'No running?'"
    run:
      init: none
```

License
-------

Apache 2

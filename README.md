Role Name
=========

Component-oriented ansible role. Allow quick and easy install, configure, and run common programs. Also, great tool to manage your .dotfiles via ansible.

Idea
--------------

Main idea behind this role is to abstract instaliation and configuration of softwave by COMPONENTS. 

What do we think about installing, for example [Polybar](https://github.com/polybar/polybar)? Polybar is status bar. OK! How do I start using Polybar? By installing, configuring and running it, ofcourse. From now, lets make abstraction about Polybar as a **component**: 
- install 
  Describes HOW we should install Polybar (by package 'polybar')
- config
  Describes HOW we should configure Polybar. We'll create template called 'polybar', and provide vars to this template
- run\_config
  Same as config, but used to describe HOW we should run Polybar. Great idea create separate bash-script with everything needed to run Polybar. Yes, this is another template. It also can be usefull for generating systemD configs, etc.
- run
  Describes HOW we run Polybar (by exec config from run\_config).

Thats all You need to start using Polybar or ZSH, or Dunst, of Rofi, or wherever -- pocibilities are endless.

Example Playbook (Polybar)
----------------
Real life useage can be found [here](https://gitlab.com/shellshock.dnull/ansible). 

`ansible playbook.yml`
```yaml
- hosts: all
  gather_facts: true
  roles:
    - role: ansible-role-component
      tags:
        - polybar
```

`ansible group_vars/all/polybar.yml`
```yaml
role_component:
  components:
  - polybar # Which components should be installed on host.
            # This is the main idea of this role.
            # All You want, is to install list of components
            # and below, we`ll write reusable definitions, which
            # every components actually is (packages, configs, etc)
```

`ansible group_vars/all/polybar.yml`
```yaml
# Template vars
templates:
  polybar:  # name of template. This should will be used in role_component.dunst.templates[]
    template: "~/dotfiles/polybar.ini"   #  path to template
    config:   "~/.config/polybar.ini"    #  path there template should be rendered

  run_polybar:
    template: "~/dotfiles/polybar.sh"
    config: "~/.config/polybar.sh"
    mode: 766  # optional file perms (allow to exec)

# Component vars
role_component:
  polybar:
    name: "Polybar - status bar"

    install:
      packages:
        - polybar # install using default hosts package manager
      pip:
        - polybar-onlinestatus  # install additional packages 
                                # using pip

    configs:
      templates:
        - polybar #  will search for template.polybar
      variables:  # vars for template ~/dotfiles/polybar.ini
        network_interface: wlan0
        temperature:
          base_temperature: 20
          warn_temperature: 60

    run_configs:
      templates:
        - run_polybar
      variables:  # vars for template ~/.config/polybar.sh
        display: 1

    run:
      init: shell  # use shell and run entrypoint
      proc: 
        - ~/.config/polybar.sh # exec polybar.sh
```

`short example of jinja template: "~/dotfiles/polybar.ini"`
```ini
[module/speed]
type = internal/network
interface = {{ var.network_interface }}

[module/temperature]
type = internal/temperature
interval = 10
base-temperature = {{ var.temperature.base_temperature }}
warn-temperature = {{ var.temperature.warn_temperature }}
```

`jinja template: "~/.config/polybar.sh"`
```bash
#!/bin/bash
export DISPLAY={{ var.display }}
killall -q polybar
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done
echo "Polybar launched..."
```

Another example Playbook (Dunst)
----------------

Real life useage can be found [here](https://gitlab.com/shellshock.dnull/ansible). 

`ansible playbook.yml`
```yaml
- hosts: all
  gather_facts: true
  roles:
    - role: ansible-role-component
      tags:
        - components
```

`ansible group_vars/all/dunst.yml`
```yaml
role_component:
  components:
  - dunst 
```

`ansible group_vars/all/dunst.yml`
```yaml
# Template vars
templates:
  dunst:  # name of template. This should will be used in role_component.dunst.templates[]
    template: "~/dotfiles/dunstrc" #  path to template
    config:   "~/dunst/dunstrc"    #  path there template should be rendered

# Component vars
role_component:
  dunst:
    name: "Dunst - Notification Manager"

    install:
      packages:
        - dunst  # install dunst using default hosts package manager

    configs:
      templates:
        - dunst #  will search for template.dunst
      variables:  # vars for template ~/dotfiles/dunstrc
        monitor: 4
        geometry: "1870x1-25+7"
        timeout:
          low: 10
          normal: 0
          critical: 0
      post:  # run post handler/command after template render
        - name: "kill dunst"
          shell: "pkill dunst || echo 'No running?'"

    run:  # dunst is run by dbus, so no need to run in manually
      init: none
```

`jinja template: "~/dotfiles/dunstrc"`
```ini
[global]
    monitor = {{ var.monitor }}
    geometry = "{{ var.geometry }}"
[urgency_low]
    timeout = {{ var.timeout.low }}
[urgency_normal]
    timeout = {{ var.timeout.normal }}
[urgency_critical]
    timeout = {{ var.timeout.critical }}
```

Role Variables
--------------

Default vars:
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

Requirements
------------

No additional requirements.

Dependencies
------------

No deps.

License
-------

Apache 2

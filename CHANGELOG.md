# 2023-06-??
## Version: 2.0

### DEPRECATED:

- `templates:` and it vars moved from top, level into
`role_component.<component_name>.[config|run_config].template`,
and now look like this:

```yaml

role_component:  
  git:
    configs:
      templates:
        gitconfig:
          template: "gitconfig"
          dest: "~/.gitconfig"
          variables:
            foo: bar
```
- `zip-configs` deleted

### Changed:

- component vars moved from playbook vars, into role defaults.
Now, you can find them in [./defaults/main](./defaults/main)
- refactored ansible messaged. Now they look like:
[component][<name>][<task>]
- reduced number of debug messages

### Added 

- install via Brew package manager:
`role_component.<component_name>.install.brew=[]`
- for macOS all
`role_component.<component_name>.install.packages=[]`
will be installed viw Brew
- conditional `become`
`role_component.<component_name>.install.become=[True|False]`
- molecule tests

---
# 2022-03-05
## Version: 1.0

### Basics
What works:
- install, pre, post
- config, pre, post
- run_config, pre, post
- run - only basics

What need to be upgraded:
- run - more options
- handlers - in config, run, across all pre and post

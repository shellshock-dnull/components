#!/usr/bin/env python
# -*- coding: utf-8 -*-
# https://www.iops.tech/blog/generate-toml-using-ansible-template/

import toml
import json


class FilterModule(object):

    def filters(self):
        return {'to_toml': self.to_toml}

    def to_toml(self, variable):
        s = json.dumps(dict(variable))
        d = json.loads(s)
        return toml.dumps(d)

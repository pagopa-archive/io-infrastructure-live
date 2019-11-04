#!/usr/bin/env python

import os
import sys

from graphviz import Digraph
import hcl

dot = Digraph(comment='tfvars dev')


for root, dirs, files in os.walk("dev/westeurope"):
    for name in files:
        if name == "terraform.tfvars":
            with open(os.path.join(root, name), 'r') as fp:
                obj = hcl.load(fp)
                try:
                    dot.node(os.path.join(root,name), os.path.join(root,name))
                    dependencies = obj["terragrunt"]["dependencies"]["paths"]
                    for dep in dependencies:
                        dot.edge(os.path.join(root, name), dep)
                except KeyError:
                    dot.node(name, name)


dot.render('tfdev.gv', view=True)

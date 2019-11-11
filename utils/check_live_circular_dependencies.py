#!/usr/bin/env python

import argparse
import os
import sys

from graphviz import Digraph
import hcl

dot = Digraph(comment="tfvars dev")

parser = argparse.ArgumentParser(
    description="Scan live environment repository for circular dependencies"
)
parser.add_argument("-d", "--directory", help="relative path")
parser.add_argument("-o", "--output", help="output file")

args = parser.parse_args()


for root, dirs, files in os.walk(args.directory):
    if "terragrunt-cache" in root:
        continue
    for name in files:
        if name == "terraform.tfvars":
            with open(os.path.join(root, name), "r") as fp:
                obj = hcl.load(fp)
                try:
                    dot.node(os.path.join(root, name), os.path.join(root, name))
                    dependencies = obj["terragrunt"]["dependencies"]["paths"]
                    for dep in dependencies:
                        dot.edge(os.path.join(root, name), dep)
                except KeyError:
                    dot.node(name, name)


dot.render(args.output, view=True)

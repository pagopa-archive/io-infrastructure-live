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
            tf_filename = os.path.join(root, name)
            with open(tf_filename, "r") as fp:
                obj = hcl.load(fp)
                try:
                    dot.node(root, tf_filename)
                    dependencies = obj["terragrunt"]["dependencies"]["paths"]
                    for dep in dependencies:
                        root_dep = os.path.join(args.directory, dep[3:])
                        dot.edge(root, root_dep )
                except KeyError:
                    pass


dot.render(args.output, view=True)

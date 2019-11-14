#!/usr/bin/env python

import argparse
import os
import sys

import hcl

parser = argparse.ArgumentParser(
    description="Scan live environment repository for circular dependencies"
)
parser.add_argument(
    "action", nargs="?", choices=("as_text", "as_image"), default="as_text"
)
parser.add_argument("-d", "--directory", help="relative path")
parser.add_argument("-o", "--output", help="output file")

args = parser.parse_args()


def as_text():
    dephell = {}
    for root, dirs, files in os.walk(args.directory):
        if "terragrunt-cache" in root:
            continue
        for name in files:
            if name == "terraform.tfvars":
                tf_filename = os.path.join(root, name)
                with open(tf_filename, "r") as fp:
                    obj = hcl.load(fp)
                    try:
                        dephell[root] = []
                        dependencies = obj["terragrunt"]["dependencies"]["paths"]
                        for dep in dependencies:
                            dephell[root].append(os.path.join(args.directory, dep[3:]))
                    except KeyError:
                        pass

    success = False
    try:
        for k in dephell.keys():
            for d in dephell[k]:
                if k in dephell[d]:
                    print("Circular dep found between %s and %s" % (k, d))
                    success = True

    except KeyError as e:
        print("%s :: has possible dependencies problem: module %s looks for %s" % (e, k, d))
    return success


def as_image():
    from graphviz import Digraph

    dot = Digraph(comment="tfvars dev")
    for root, dirs, files in os.walk(args.directory):
        if "terragrunt-cache" in root:
            continue
        for name in files:
            if name == "terraform.tfvars":
                tf_filename = os.path.join(root, name)
                with open(tf_filename, "r") as fp:
                    obj = hcl.load(fp)
                    try:
                        dot.node(root, root)
                        dependencies = obj["terragrunt"]["dependencies"]["paths"]
                        for dep in dependencies:
                            root_dep = os.path.join(args.directory, dep[3:])
                            dot.edge(root, root_dep)
                    except KeyError:
                        pass

    dot.render(args.output, view=True)


if args.action == "as_text":
    sys.exit(as_text())
else:
    as_image()

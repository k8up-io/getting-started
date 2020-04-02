#!/usr/bin/env python2

import yaml
import argparse
import sys

# This script populates the value of the YAML with the snapshot ID
# of a particular Restic backup.
# See the "2_restore_pvc.sh" script to see how to use this program.
# We need this because kustomize does not support such a simple replacement yet:
# https://github.com/kubernetes-sigs/kustomize/issues/1113

# Parse the 'target' argument, or print an error if not available
parser = argparse.ArgumentParser()
parser.add_argument("target", help='Target PVC to restore', choices=['mariadb', 'wordpress'])
parser.add_argument("snapshot", help='Restic snapshot to restore')
args = parser.parse_args()

# Read the YAML file, replace the `spec:snapshot:` value and print to stdout
stream = file('k8up/restore/' + args.target + '.yaml')
document = yaml.load(stream, Loader=yaml.FullLoader)
document['spec']['snapshot'] = args.snapshot
print yaml.dump(document)

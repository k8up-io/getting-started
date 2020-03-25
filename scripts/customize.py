import yaml
import argparse
import json
import sys

# This script populates the value of the YAML with the snapshot ID
# of a particular Restic backup.
# See the "2_restore_pvc.sh" script to see how to use this program.
# We need this because kustomize does not support such a simple replacement yet:
# https://github.com/kubernetes-sigs/kustomize/issues/1113

# Parse the 'target' argument, or print an error if not available
parser = argparse.ArgumentParser()
parser.add_argument("target", help='Target PVC to restore', choices=['mariadb', 'wordpress'])
args = parser.parse_args()

# Read the snapshot JSON from stdin
json_file = ''
for line in sys.stdin:
    json_file += line

# Look for the snapshot ID in the JSON
json_data = json.loads(json_file)
snapshot = str(json_data[0]['id'])

# Read the YAML file, replace the `spec:snapshot:` value and print to stdout
stream = file('k8up/restore/' + args.target + '.yaml')
document = yaml.load(stream, Loader=yaml.FullLoader)
document['spec']['snapshot'] = snapshot
print yaml.dump(document)

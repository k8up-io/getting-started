#!/usr/bin/env bash

# Set kubectl context
export KUBECONFIG="$(k3d kubeconfig write k8s-tutorial)"

case $(uname -s) in
    "Linux")
        k3d cluster delete k8s-tutorial
    ;;
    "Darwin")
        # Remove port forwarding set in `2_browser.sh`
        kill "$(pgrep kubectl)"
        k3d cluster delete k8s-tutorial
    ;;
esac

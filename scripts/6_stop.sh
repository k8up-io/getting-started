#!/usr/bin/env bash

# Set kubectl context
export KUBECONFIG="$(k3d get-kubeconfig --name='k3s-default')"

case $(uname -s) in
    "Linux")
        k3d delete
    ;;
    "Darwin")
        # Remove port forwarding set in `2_browser.sh`
        kill "$(pgrep kubectl)"
        k3d delete
    ;;
esac

locals {
  zone = "ch-gva-2"
}

# This resource will create the control plane
# Since we're going for the fully managed option, we will ask sks to preinstall
# the calico network plugin and the exoscale-cloud-controller
resource "exoscale_sks_cluster" "K8s-getting-started" {
  zone          = local.zone
  name          = "K8s-getting-started"
  version       = "1.22.2"
  description   = "K8s getting started cluster"
  service_level = "pro"
  cni           = "calico"
  addons        = ["exoscale-cloud-controller"]
}

# A security group so the nodes can communicate and we can pull logs
resource "exoscale_security_group" "sks_nodes" {
  name        = "sks_nodes"
  description = "Allows traffic between sks nodes and public pulling of logs"
}

resource "exoscale_security_group_rule" "sks_nodes_logs_rule" {
  security_group_id = exoscale_security_group.sks_nodes.id
  type              = "INGRESS"
  protocol          = "TCP"
  cidr              = "0.0.0.0/0"
  start_port        = 10250
  end_port          = 10250
}

resource "exoscale_security_group_rule" "sks_nodes_calico" {
  security_group_id      = exoscale_security_group.sks_nodes.id
  type                   = "INGRESS"
  protocol               = "UDP"
  start_port             = 4789
  end_port               = 4789
  user_security_group_id = exoscale_security_group.sks_nodes.id
}

resource "exoscale_security_group_rule" "sks_nodes_ccm" {
  security_group_id = exoscale_security_group.sks_nodes.id
  type              = "INGRESS"
  protocol          = "TCP"
  start_port        = 30000
  end_port          = 32767
  cidr              = "0.0.0.0/0"
}

# This provisions an instance pool of nodes which will run the kubernetes
# workloads.
# We can attach multiple nodepools to the cluster
resource "exoscale_sks_nodepool" "workers" {
  zone               = local.zone
  cluster_id         = exoscale_sks_cluster.K8s-getting-started.id
  name               = "workers"
  instance_type      = "medium"
  size               = 3
  security_group_ids = [exoscale_security_group.sks_nodes.id]
}

output "kubectl_command" {
  value = "exo sks kubeconfig ${exoscale_sks_cluster.K8s-getting-started.name} user -z ${local.zone} --group system:masters > exoscale-sks.kubeconfig"
}

# data "external" "kubeconfig" {
#   program = ["./get-kubeconfig.sh"]
#   query = {
#     id = exoscale_sks_cluster.K8s-getting-started.id
#     zone = local.zone
#   }
# }

# # Add the kubeconfig as an output
# output "kubeconfig" {
#   value = data.external.kubeconfig.result.value
# }

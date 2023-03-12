data "google_container_engine_versions" "cluster_versions" {
  location = var.region
  project = var.project
  version_prefix = var.cluster_version_prefix
}

resource "google_container_cluster" "apcluster" {
  provider = google-beta
  name     = var.cluster_name
  project  = var.project
  location = var.region

  # makes this an Autopilot cluster 
  enable_autopilot = true

  cluster_autoscaling {
    auto_provisioning_defaults {
      service_account = var.cluster_service_account
      oauth_scopes = var.node_ap_oauth_scopes
    }
  }

  min_master_version  = data.google_container_engine_versions.cluster_versions.latest_master_version

  release_channel {
    channel = var.cluster_release_channel
  }

#   network =  data.google_compute_network.vpc.name
  network =  var.vpc_network_name
  subnetwork = var.subnetwork_name

  # worker nodes with private IP addresses
  private_cluster_config {
    enable_private_nodes = true
    enable_private_endpoint = var.enable_private_endpoint
    master_ipv4_cidr_block = var.master_ipv4_cidr_block_28
    master_global_access_config {
      enabled = false
    }
  }


  dynamic "master_authorized_networks_config" {
    for_each = length(var.master_authorized_networks_cidr_list)>0 ? [1]:[]
    content {

      # dynamic inner block to list authorized networks
      dynamic "cidr_blocks" {
        for_each =  var.master_authorized_networks_cidr_list
        # notice the name inside is not 'each', it is name of dynamic block
        content {
          cidr_block = cidr_blocks.value
          display_name = "authnetworks ${cidr_blocks.value}"
        }
      } # end dynamic cidr_blocks

    } # end content of master_authorized_networks_config

  } # end dynamic block master_authorized_networks_config

  # added so that 'tf apply' does not continually find update changes
  vertical_pod_autoscaling {
    enabled = true
  }

  addons_config {
    # wanted by ASM
    http_load_balancing {
      disabled = false
    }

    # beta, enabled
    gce_persistent_disk_csi_driver_config {
      enabled = true
    }
  }

  maintenance_policy {
    recurring_window {
      start_time = "2022-11-04T10:00:00Z" # UTC
      end_time = "2022-11-04T20:00:00Z" # UTC
      recurrence = "FREQ=WEEKLY;BYDAY=SA,SU"
    }
  }

  # ignore master version being auto-upgraded
  lifecycle {
    ignore_changes = [
      min_master_version
    ]
  }

  # references names of secondary ranges
  # this enables ip aliasing '--enable-ip-alias'
  ip_allocation_policy {
    services_secondary_range_name = var.secondary_range_services_name
    cluster_secondary_range_name = var.secondary_range_pods_name
  }


  # node_config {
  #   // Enable workload identity on this node pool.
  #   workload_metadata_config {
  #     mode = "GKE_METADATA"            #Run the Kubernetes Engine Metadata Server on this node. The Kubernetes Engine Metadata Server exposes a metadata API to workloads that is compatible with the V1 Compute Metadata APIs exposed by the Compute Engine and App Engine Metadata Servers. This feature can only be enabled if Workload Identity is enabled at the cluster level.                 
  #   }
  #   service_account = var.cluster_service_account
  #   oauth_scopes = var.node_ap_oauth_scopes
  #   } 

  node_pool_auto_config {                 #to apply network tags to GKE autopilot Nodes.
  network_tags {
    tags = ["allow-gcp-gfe"]               #This applies the HTTP Health Check Probe IPs to the nodes
  }         
}
  timeouts {
    create = "60m"
    delete = "2h"
  }

  }
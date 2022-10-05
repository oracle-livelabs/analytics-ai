resource "oci_datascience_project" "redbull_project" {
  compartment_id = var.compartment_ocid

  description  = "RedBull Pit Strategy Project"
  display_name = "Pit Strategy Project"

  depends_on = [
    oci_core_subnet.privatesubnet
  ]
}

# FIXME bad hack to avoid: The specified subnet is not accessible. Select a different subnet.
resource "time_sleep" "wait_a_bit" {
  create_duration = "60s"
}

resource "oci_datascience_notebook_session" "lol_notebook_session" {
  compartment_id = var.compartment_ocid
  project_id     = oci_datascience_project.redbull_project.id

  display_name = "RedBull Pit Strategy Notebook Session"

  notebook_session_config_details {
    shape = data.oci_datascience_notebook_session_shapes.ds_shapes.notebook_session_shapes[0].name

    subnet_id = oci_core_subnet.privatesubnet.id
  }

  depends_on = [
    time_sleep.wait_a_bit
  ]

}

data "oci_datascience_notebook_session_shapes" "ds_shapes" {
  compartment_id = var.compartment_ocid
  filter {
    name   = "core_count"
    values = [var.desired_number_cpus]
  }
}

output "ds_notebook_session_shape" {
  value = data.oci_datascience_notebook_session_shapes.ds_shapes.notebook_session_shapes[0].name
}

output "ds_notebook_session" {
  value = oci_datascience_notebook_session.lol_notebook_session.notebook_session_url
}

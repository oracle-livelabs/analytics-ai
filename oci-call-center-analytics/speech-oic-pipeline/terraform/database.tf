# Copyright (c) 2019-2022 Oracle and/or its affiliates. All rights reserved.
# Licensed under the Universal Permissive License v 1.0 as shown at http://oss.oracle.com/licenses/upl.

resource "random_password" "database_admin" {
  length = 16
  special = false
  min_upper = 3
  min_lower = 3
  min_numeric = 3
}

resource "random_password" "database_wallet" {
  length = 16
  special = false
  min_upper = 3
  min_lower = 3
  min_numeric = 3
}

resource "random_password" "database_user" {
  length = 16
  special = false
  min_upper = 3
  min_lower = 3
  min_numeric = 3
}

resource "oci_database_autonomous_database" "customer_feedback_analytics" {
  depends_on = [
    oci_identity_compartment.customer_feedback_analytics,
    random_password.database_admin
  ]

  compartment_id = oci_identity_compartment.customer_feedback_analytics.id
  db_name = var.database_name
  admin_password = random_password.database_admin.result
  cpu_core_count = 1
  data_storage_size_in_tbs = 1
}

resource "oci_database_autonomous_database_wallet" "database_wallet" {
  depends_on = [
    oci_identity_compartment.customer_feedback_analytics,
    oci_database_autonomous_database.customer_feedback_analytics,
    random_password.database_wallet
  ]

  autonomous_database_id = oci_database_autonomous_database.customer_feedback_analytics.id
  password = random_password.database_wallet.result
  generate_type = "SINGLE"
  base64_encode_content = true
}

resource "local_file" "wallet" {
  depends_on = [
    oci_database_autonomous_database_wallet.database_wallet
  ]

  filename = local.wallet_file_path
  content_base64 = oci_database_autonomous_database_wallet.database_wallet.content
}

data "template_file" "schema_initialization_script_tempalte" {
  template = file(local.sql_script_template_file_path)
  vars = {
    database_user = upper(var.database_user_name),
    database_user_password = random_password.database_user.result
  }
}

resource "local_file" "schema_initialization_script" {
  depends_on = [
    data.template_file.schema_initialization_script_tempalte
  ]

  filename = local.sql_script_file_path
  content = data.template_file.schema_initialization_script_tempalte.rendered
}


resource "null_resource" "database_setup" {
  depends_on = [
    oci_database_autonomous_database.customer_feedback_analytics,
    local_file.schema_initialization_script,
    local_file.wallet,
    random_password.database_admin
  ]

  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command = <<EOT
unzip -o -d ${local.assets_dir_path} ${local.wallet_file_path} ${local.wallet_sso_file_name}
sqlplus admin/${random_password.database_admin.result}@tcps://${oci_database_autonomous_database.customer_feedback_analytics.connection_strings[0].all_connection_strings["MEDIUM"]}?wallet_location=${local.assets_dir_path} < ${local.sql_script_file_path}
rm ${local.assets_dir_path}/${local.wallet_sso_file_name}
EOT
  }
}

output "database" {
  sensitive = true
  value = {
    admin_password = random_password.database_admin.result,
    wallet_pasword = random_password.database_wallet.result,
    service_user_name = var.database_user_name,
    service_user_password = random_password.database_user.result,
    service_names = [ for profile in oci_database_autonomous_database.customer_feedback_analytics.connection_strings[0].profiles : profile.display_name ],
    service_urls = oci_database_autonomous_database.customer_feedback_analytics.connection_strings[0].all_connection_strings,
    sqlplus_command = "sqlplus admin/${random_password.database_admin.result}@tcps://${oci_database_autonomous_database.customer_feedback_analytics.connection_strings[0].all_connection_strings["MEDIUM"]}?wallet_location=${local.assets_dir_path} < ${local.sql_script_file_path}"
  }
}

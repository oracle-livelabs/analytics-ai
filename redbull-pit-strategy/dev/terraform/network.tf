locals {
  tcp_protocol = 6
  anywhere     = "0.0.0.0/0"
  cidr_block   = "CIDR_BLOCK"
}

resource "oci_core_virtual_network" "redbullvcn" {
  compartment_id = var.compartment_ocid
  cidr_blocks    = ["10.0.0.0/16"]
  display_name   = "RedBull VCN"
  dns_label      = "redbullvcn"
}

resource "oci_core_internet_gateway" "redbull_internet_gateway" {
  compartment_id = var.compartment_ocid
  display_name   = "internet_gateway"
  vcn_id         = oci_core_virtual_network.redbullvcn.id
}

resource "oci_core_nat_gateway" "redbull_nat_gateway" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_virtual_network.redbullvcn.id
  display_name   = "nat_gateway"
}

resource "oci_core_default_route_table" "default_route_table" {
  manage_default_resource_id = oci_core_virtual_network.redbullvcn.default_route_table_id
  display_name               = "DefaultRouteTable"

  route_rules {
    destination       = local.anywhere
    destination_type  = local.cidr_block
    network_entity_id = oci_core_internet_gateway.redbull_internet_gateway.id
  }
}

resource "oci_core_route_table" "route_table_private" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_virtual_network.redbullvcn.id
  display_name   = "private"

  route_rules {
    destination       = local.anywhere
    destination_type  = local.cidr_block
    network_entity_id = oci_core_nat_gateway.redbull_nat_gateway.id
  }
}

resource "oci_core_subnet" "publicsubnet" {
  cidr_block        = "10.0.0.0/24"
  compartment_id    = var.compartment_ocid
  vcn_id            = oci_core_virtual_network.redbullvcn.id
  display_name      = "public subnet"
  dns_label         = "redbullpublic"
  security_list_ids = [oci_core_virtual_network.redbullvcn.default_security_list_id, oci_core_security_list.custom_security_list.id]
  route_table_id    = oci_core_virtual_network.redbullvcn.default_route_table_id
  dhcp_options_id   = oci_core_virtual_network.redbullvcn.default_dhcp_options_id
}

resource "oci_core_subnet" "privatesubnet" {
  cidr_block                 = "10.0.1.0/24"
  compartment_id             = var.compartment_ocid
  vcn_id                     = oci_core_virtual_network.redbullvcn.id
  prohibit_public_ip_on_vnic = true
  display_name               = "private subnet"
  dns_label                  = "redbullprivate"
  security_list_ids          = [oci_core_virtual_network.redbullvcn.default_security_list_id]
  route_table_id             = oci_core_route_table.route_table_private.id
  dhcp_options_id            = oci_core_virtual_network.redbullvcn.default_dhcp_options_id
}


resource "oci_core_security_list" "custom_security_list" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_virtual_network.redbullvcn.id
  display_name   = "Custom Security List"

  ingress_security_rules {
    protocol  = "6" // tcp
    source    = "0.0.0.0/0"
    stateless = false

    tcp_options { // allow ssl
      min = 443
      max = 443
    }
  }

}
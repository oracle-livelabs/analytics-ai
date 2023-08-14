# Access a BDS Node Using a Public IP Address

## Introduction

Big Data Service nodes are by default assigned private IP addresses, which aren't accessible from the public internet. You can make the nodes in the cluster available using one of the following methods:

* You can map the private IP addresses of selected nodes in the cluster to public IP addresses to make them publicly available on the internet. _**We will use this method in this lab which assumes that making the IP address public is an acceptable security risk.**_
* You can set up an SSH tunnel using a bastion host. Only the bastion host is exposed to the public internet. A bastion host provides access to the cluster's private network from the public internet. See [Bastion Hosts Protected Access for Virtual Cloud Networks](https://www.oracle.com/a/ocom/docs/bastion-hosts.pdf).
* You can also use VPN Connect which provides a site-to-site Internet Protocol Security (IPSec) VPN between your on-premises network and your virtual cloud network (VCN). IPSec VPN is a popular set of protocols used to ensure secure and private communications over IP networks. See [VPN Connect](https://docs.cloud.oracle.com/en-us/iaas/Content/Network/Tasks/managingIPsec.htm).
* Finally, you can use OCI FastConnect to access services in OCI without going over the public internet. With FastConnect, the traffic goes over your private physical connection. [See FastConnect](https://www.oracle.com/pls/topic/lookup?ctx=en/cloud/paas/autonomous-data-warehouse-cloud/user&id=oci-fastconnect).

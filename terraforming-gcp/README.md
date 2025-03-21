# Terraforming GCP: deploy DataDomain, PowerProtect DataManager, Networker, Avamar  and more from GCP Marketplace offerings using terraform

This Modules can deploy Dell PowerProtect DataDomain Virtual Edition, PowerPotect DataManager, Networker Virtual Edition and Avamar Virtual edition to GCP using terraform.
Instance Sizes and Disk Count/Size will be automatically evaluated my specifying a ddve_type and ave_type.   

Individual Modules will be called from main by evaluating  Variables

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.14 |
| <a name="requirement_google"></a> [google](#requirement\_google) | ~> 5.3.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_cloud_nat"></a> [cloud\_nat](#module\_cloud\_nat) | ./modules/cloud_nat | n/a |
| <a name="module_ddve"></a> [ddve](#module\_ddve) | ./modules/ddve | n/a |
| <a name="module_ddve_project_role"></a> [ddve\_project\_role](#module\_ddve\_project\_role) | ./modules/ddve_project_role | n/a |
| <a name="module_gke"></a> [gke](#module\_gke) | ./modules/gke | n/a |
| <a name="module_networks"></a> [networks](#module\_networks) | ./modules/networks | n/a |
| <a name="module_nve"></a> [nve](#module\_nve) | ./modules/nve | n/a |
| <a name="module_ppdm"></a> [ppdm](#module\_ppdm) | ./modules/ppdm | n/a |
| <a name="module_s2svpn"></a> [s2svpn](#module\_s2svpn) | ./modules/s2svpn | n/a |
| <a name="module_ubuntu"></a> [ubuntu](#module\_ubuntu) | ./modules/ubuntu | n/a |
| <a name="module_windows"></a> [windows](#module\_windows) | ./modules/windows | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_DDVE_HOSTNAME"></a> [DDVE\_HOSTNAME](#input\_DDVE\_HOSTNAME) | Hotname of the DDVE Machine | `string` | `"ddve-tf"` | no |
| <a name="input_ENV_NAME"></a> [ENV\_NAME](#input\_ENV\_NAME) | Enfironment Name, concatenated to resource names | `string` | `"demo"` | no |
| <a name="input_NVE_HOSTNAME"></a> [NVE\_HOSTNAME](#input\_NVE\_HOSTNAME) | Hotname Prefix (adds counting number) of the NVE Machine | `string` | `"nve-tf"` | no |
| <a name="input_PPDM_HOSTNAME"></a> [PPDM\_HOSTNAME](#input\_PPDM\_HOSTNAME) | Hotname Prefix (adds counting number) of the PPDM Machine | `string` | `"ppdm-tf"` | no |
| <a name="input_create_cloud_nat"></a> [create\_cloud\_nat](#input\_create\_cloud\_nat) | n/a | `bool` | `false` | no |
| <a name="input_create_ddve_project_role"></a> [create\_ddve\_project\_role](#input\_create\_ddve\_project\_role) | deploy a role for ddev oauth to Goocle Cloud Storage | `bool` | `false` | no |
| <a name="input_create_gke"></a> [create\_gke](#input\_create\_gke) | deploy a basic Google Kubernetes Engine for test/dev | `bool` | `false` | no |
| <a name="input_create_networks"></a> [create\_networks](#input\_create\_networks) | Do you want to create a VPC | `bool` | `false` | no |
| <a name="input_create_s2svpn"></a> [create\_s2svpn](#input\_create\_s2svpn) | Should a Side 2 Side VPN Gateway be deployed | `bool` | `false` | no |
| <a name="input_ddve_count"></a> [ddve\_count](#input\_ddve\_count) | Do you want to create a DDVE | `number` | `0` | no |
| <a name="input_ddve_disk_type"></a> [ddve\_disk\_type](#input\_ddve\_disk\_type) | DDVE Disk Type, can be: 'Performance Optimized', 'Cost Optimized' | `string` | `"Cost Optimized"` | no |
| <a name="input_ddve_role_id"></a> [ddve\_role\_id](#input\_ddve\_role\_id) | id of the role fo DDVE used, format roles/{role}, organizations/{organization\_id}/roles/{role}, or projects/{project\_id}/roles/{role} when using existing roles, otherwise will be created for you | `string` | `"ddve_oauth_role"` | no |
| <a name="input_ddve_sa_account_id"></a> [ddve\_sa\_account\_id](#input\_ddve\_sa\_account\_id) | The ID of the Service Account for DDVE IAM Policy to Access Storage Bucket via OAuth, in ther form of | `string` | `""` | no |
| <a name="input_ddve_source_tags"></a> [ddve\_source\_tags](#input\_ddve\_source\_tags) | Source tags applied to Instance for Firewall Rules | `list(any)` | `[]` | no |
| <a name="input_ddve_target_tags"></a> [ddve\_target\_tags](#input\_ddve\_target\_tags) | Target tags applied to Instance for Firewall Rules | `list(any)` | `[]` | no |
| <a name="input_ddve_type"></a> [ddve\_type](#input\_ddve\_type) | DDVE Type, can be: '16 TB DDVE', '32 TB DDVE', '96 TB DDVE', '256 TB DDVE' | `string` | `"16 TB DDVE"` | no |
| <a name="input_ddve_version"></a> [ddve\_version](#input\_ddve\_version) | DDVE Version, can be: 'LTS2022 7.7.5.50', 'LTS2023 7.10.1.40', 'LTS2024 7.13.1.05','8.3.0.10' | `string` | `"8.3.0.10"` | no |
| <a name="input_gcp_network"></a> [gcp\_network](#input\_gcp\_network) | GCP Network to be used, change for youn own infra | `string` | `"default"` | no |
| <a name="input_gcp_project"></a> [gcp\_project](#input\_gcp\_project) | the GCP Project do deploy resources | `any` | `null` | no |
| <a name="input_gcp_region"></a> [gcp\_region](#input\_gcp\_region) | GCP Region to be used | `string` | `"europe-west3"` | no |
| <a name="input_gcp_subnet_cidr_block_1"></a> [gcp\_subnet\_cidr\_block\_1](#input\_gcp\_subnet\_cidr\_block\_1) | Cidr Block of the first Subnet to be used | `string` | `"10.0.16.0/20"` | no |
| <a name="input_gcp_subnetwork_name_1"></a> [gcp\_subnetwork\_name\_1](#input\_gcp\_subnetwork\_name\_1) | name of the first subnet | `string` | `"default"` | no |
| <a name="input_gcp_zone"></a> [gcp\_zone](#input\_gcp\_zone) | GCP Zone to be used | `string` | `"europe-west3-c"` | no |
| <a name="input_gke_master_ipv4_cidr_block"></a> [gke\_master\_ipv4\_cidr\_block](#input\_gke\_master\_ipv4\_cidr\_block) | Subnet CIDR BLock for Google Kubernetes Engine Master Nodes | `string` | `"172.16.0.16/28"` | no |
| <a name="input_gke_num_nodes"></a> [gke\_num\_nodes](#input\_gke\_num\_nodes) | Number of GKE Worker Nodes | `number` | `2` | no |
| <a name="input_gke_subnet_secondary_cidr_block_0"></a> [gke\_subnet\_secondary\_cidr\_block\_0](#input\_gke\_subnet\_secondary\_cidr\_block\_0) | Cluster CIDR Block for Google Kubernetes Engine | `string` | `"10.4.0.0/14"` | no |
| <a name="input_gke_subnet_secondary_cidr_block_1"></a> [gke\_subnet\_secondary\_cidr\_block\_1](#input\_gke\_subnet\_secondary\_cidr\_block\_1) | Services CIDR Block for Google Kubernetes Engine | `string` | `"10.0.32.0/20"` | no |
| <a name="input_gke_zonal"></a> [gke\_zonal](#input\_gke\_zonal) | deployment Zonal Model used for GKE | `bool` | `true` | no |
| <a name="input_labels"></a> [labels](#input\_labels) | Key Value of labels you want to apply to Resources | `map(any)` | `{}` | no |
| <a name="input_nve_count"></a> [nve\_count](#input\_nve\_count) | Do you want to create a NVE | `number` | `0` | no |
| <a name="input_nve_source_tags"></a> [nve\_source\_tags](#input\_nve\_source\_tags) | Source tags applied to Instance for Firewall Rules | `list(any)` | `[]` | no |
| <a name="input_nve_target_tags"></a> [nve\_target\_tags](#input\_nve\_target\_tags) | Target tags applied to Instance for Firewall Rules | `list(any)` | `[]` | no |
| <a name="input_nve_type"></a> [nve\_type](#input\_nve\_type) | NVE Type, can be: 'small', 'medium', 'large' | `string` | `"small"` | no |
| <a name="input_nve_version"></a> [nve\_version](#input\_nve\_version) | NVE Version, can be: '19.9','19.10' | `string` | `"19.10"` | no |
| <a name="input_ppdm_count"></a> [ppdm\_count](#input\_ppdm\_count) | Do you want to create a PPDM | `number` | `0` | no |
| <a name="input_ppdm_source_tags"></a> [ppdm\_source\_tags](#input\_ppdm\_source\_tags) | Source tags applied to Instance for Firewall Rules | `list(any)` | `[]` | no |
| <a name="input_ppdm_target_tags"></a> [ppdm\_target\_tags](#input\_ppdm\_target\_tags) | Target tags applied to Instance for Firewall Rules | `list(any)` | `[]` | no |
| <a name="input_ppdm_version"></a> [ppdm\_version](#input\_ppdm\_version) | PPDM Version, can be:  '19.16', '19.17' | `string` | `"19.17"` | no |
| <a name="input_s2s_vpn_route_dest"></a> [s2s\_vpn\_route\_dest](#input\_s2s\_vpn\_route\_dest) | Routing Destination ( on Premises local networks ) for VPN | `list(string)` | <pre>[<br>  "127.0.0.1/32"<br>]</pre> | no |
| <a name="input_ubuntu_HOSTNAME"></a> [ubuntu\_HOSTNAME](#input\_ubuntu\_HOSTNAME) | Hotname Prefix (adds counting number) of the ubuntu Machine | `string` | `"ubuntu-tf"` | no |
| <a name="input_ubuntu_count"></a> [ubuntu\_count](#input\_ubuntu\_count) | Do you want to create a ubuntu | `number` | `0` | no |
| <a name="input_ubuntu_deletion_protection"></a> [ubuntu\_deletion\_protection](#input\_ubuntu\_deletion\_protection) | Protect ubuntu from deletion | `bool` | `false` | no |
| <a name="input_ubuntu_source_tags"></a> [ubuntu\_source\_tags](#input\_ubuntu\_source\_tags) | Source tags applied to Instance for Firewall Rules | `list(any)` | `[]` | no |
| <a name="input_ubuntu_target_tags"></a> [ubuntu\_target\_tags](#input\_ubuntu\_target\_tags) | Target tags applied to Instance for Firewall Rules | `list(any)` | `[]` | no |
| <a name="input_vpn_shared_secret"></a> [vpn\_shared\_secret](#input\_vpn\_shared\_secret) | Shared Secret for VPN Connection | `string` | `"topsecret12345"` | no |
| <a name="input_vpn_wan_ip"></a> [vpn\_wan\_ip](#input\_vpn\_wan\_ip) | IP Adress of the Local VPN Gateway | `string` | `"0.0.0.0"` | no |
| <a name="input_windows_HOSTNAME"></a> [windows\_HOSTNAME](#input\_windows\_HOSTNAME) | Hotname Prefix (adds counting number) of the windows Machine | `string` | `"windows-tf"` | no |
| <a name="input_windows_count"></a> [windows\_count](#input\_windows\_count) | Do you want to create a windows | `number` | `0` | no |
| <a name="input_windows_deletion_protection"></a> [windows\_deletion\_protection](#input\_windows\_deletion\_protection) | Protect windows from deletion | `bool` | `false` | no |
| <a name="input_windows_source_tags"></a> [windows\_source\_tags](#input\_windows\_source\_tags) | Source tags applied to Instance for Firewall Rules | `list(any)` | `[]` | no |
| <a name="input_windows_target_tags"></a> [windows\_target\_tags](#input\_windows\_target\_tags) | Target tags applied to Instance for Firewall Rules | `list(any)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_NVE_FQDN"></a> [NVE\_FQDN](#output\_NVE\_FQDN) | The private ip address for the DDVE Instance |
| <a name="output_PPDM_FQDN"></a> [PPDM\_FQDN](#output\_PPDM\_FQDN) | The private ip address for the DDVE Instance |
| <a name="output_atos_bucket"></a> [atos\_bucket](#output\_atos\_bucket) | The Object Bucket Name created for ATOS configuration |
| <a name="output_ddve_instance_id"></a> [ddve\_instance\_id](#output\_ddve\_instance\_id) | The instance id (initial password) for the DDVE Instance |
| <a name="output_ddve_private_ip"></a> [ddve\_private\_ip](#output\_ddve\_private\_ip) | The private ip address for the DDVE Instance |
| <a name="output_ddve_ssh_private_key"></a> [ddve\_ssh\_private\_key](#output\_ddve\_ssh\_private\_key) | The ssh private key for the DDVE Instance |
| <a name="output_ddve_ssh_public_key"></a> [ddve\_ssh\_public\_key](#output\_ddve\_ssh\_public\_key) | The ssh public key for the DDVE Instance |
| <a name="output_kubernetes_cluster_host"></a> [kubernetes\_cluster\_host](#output\_kubernetes\_cluster\_host) | GKE Cluster Host |
| <a name="output_kubernetes_cluster_name"></a> [kubernetes\_cluster\_name](#output\_kubernetes\_cluster\_name) | GKE Cluster Name |
| <a name="output_location"></a> [location](#output\_location) | GKE Cluster location |
| <a name="output_nve_instance_id"></a> [nve\_instance\_id](#output\_nve\_instance\_id) | The instance id (initial password) for the DDVE Instance |
| <a name="output_nve_ssh_private_key"></a> [nve\_ssh\_private\_key](#output\_nve\_ssh\_private\_key) | The ssh private key for the DDVE Instance |
| <a name="output_nve_ssh_public_key"></a> [nve\_ssh\_public\_key](#output\_nve\_ssh\_public\_key) | The ssh public key for the DDVE Instance |
| <a name="output_ppdm_instance_id"></a> [ppdm\_instance\_id](#output\_ppdm\_instance\_id) | The instance id (initial password) for the DDVE Instance |
| <a name="output_ppdm_ssh_private_key"></a> [ppdm\_ssh\_private\_key](#output\_ppdm\_ssh\_private\_key) | The ssh private key for the DDVE Instance |
| <a name="output_ppdm_ssh_public_key"></a> [ppdm\_ssh\_public\_key](#output\_ppdm\_ssh\_public\_key) | The ssh public key for the DDVE Instance |
| <a name="output_ubuntu_instance_id"></a> [ubuntu\_instance\_id](#output\_ubuntu\_instance\_id) | The instance id (initial password) for the DDVE Instance |
| <a name="output_ubuntu_private_ip"></a> [ubuntu\_private\_ip](#output\_ubuntu\_private\_ip) | The private ip address for the DDVE Instance |
| <a name="output_ubuntu_ssh_private_key"></a> [ubuntu\_ssh\_private\_key](#output\_ubuntu\_ssh\_private\_key) | The ssh private key for the DDVE Instance |
| <a name="output_ubuntu_ssh_public_key"></a> [ubuntu\_ssh\_public\_key](#output\_ubuntu\_ssh\_public\_key) | The ssh public key for the DDVE Instance |
| <a name="output_vpn_ip"></a> [vpn\_ip](#output\_vpn\_ip) | n/a |
| <a name="output_windows_instance_id"></a> [windows\_instance\_id](#output\_windows\_instance\_id) | The instance id (initial password) for the DDVE Instance |
| <a name="output_windows_private_ip"></a> [windows\_private\_ip](#output\_windows\_private\_ip) | The private ip address for the DDVE Instance |
| <a name="output_windows_ssh_private_key"></a> [windows\_ssh\_private\_key](#output\_windows\_ssh\_private\_key) | The ssh private key for the DDVE Instance |
| <a name="output_windows_ssh_public_key"></a> [windows\_ssh\_public\_key](#output\_windows\_ssh\_public\_key) | The ssh public key for the DDVE Instance |
## Example Variables to be configured

```tfvars
DDVE_HOSTNAME                     = "ddve-tf"
ENV_NAME                          = "demo"
NVE_HOSTNAME                      = "nve-tf"
PPDM_HOSTNAME                     = "ppdm-tf"
create_cloud_nat                  = false
create_ddve_project_role          = false
create_gke                        = false
create_networks                   = false
create_s2svpn                     = false
ddve_count                        = 0
ddve_disk_type                    = "Cost Optimized"
ddve_role_id                      = "roles/ddve_oauth_role"
ddve_sa_account_id                = "tfddve-sa"
ddve_source_tags                  = []
ddve_target_tags                  = []
ddve_type                         = "16 TB DDVE"
ddve_version                      = "7.13.0.20"
gcp_network                       = "default"
gcp_project                       = ""
gcp_region                        = "europe-west3"
gcp_subnet_cidr_block_1           = "10.0.16.0/20"
gcp_subnetwork_name_1             = "default"
gcp_zone                          = "europe-west3-c"
gke_master_ipv4_cidr_block        = "172.16.0.16/28"
gke_num_nodes                     = 2
gke_subnet_secondary_cidr_block_0 = "10.4.0.0/14"
gke_subnet_secondary_cidr_block_1 = "10.0.32.0/20"
gke_zonal                         = true
labels                            = {}
nve_count                         = 0
nve_source_tags                   = []
nve_target_tags                   = []
nve_type                          = "small"
nve_version                       = "19.10"
ppdm_count                        = 0
ppdm_source_tags                  = []
ppdm_target_tags                  = []
ppdm_version                      = "19.15"
s2s_vpn_route_dest = [
  "127.0.0.1/32"
]
ubuntu_HOSTNAME            = "ubuntu-tf"
ubuntu_count               = 0
ubuntu_deletion_protection = false
ubuntu_source_tags         = []
ubuntu_target_tags         = []
vpn_shared_secret          = "topsecret12345"
vpn_wan_ip                 = "0.0.0.0"
```

## Deployment

# module_ddve
Once you configured all you required Settings and Machines to be deployed, check your deployment plan with

```bash
terraform plan
```

when everything meets your requirements, run the deployment with

```bash
terraform apply --auto-approve
```






## Configuration ....
this assumes that you use my ansible Playbooks for AVE, PPDM and DDVE from [ansible-dps]()
Set the Required Variables: (don´t worry about the "Public" notations / names)


### Configuring DDVE
when the deployment is finished, you can connect and configure DDVE in multiple ways.
for an ssh connection, use:


```bash
export DDVE_PRIVATE_FQDN=$(terraform output -raw ddve_private_ip)
terraform output ddve_ssh_private_key > ~/.ssh/ddve_key
chmod 0600 ~/.ssh/ddve_key
ssh -i ~/.ssh/ddve_key sysadmin@${DDVE_PRIVATE_FQDN}
```
Proceed with CLi configuration


#### Configure DataDomain using ansible


### export outputs from terraform into environment variables:
```bash
export DDVE_PUBLIC_FQDN=$(terraform output -raw ddve_private_ip)                
export DDVE_USERNAME=sysadmin
export DDVE_INITIAL_PASSWORD=$(terraform output -raw ddve_instance_id)
export DDVE_PASSWORD=Change_Me12345_
export PPDD_PASSPHRASE=Change_Me12345_!
export DDVE_PRIVATE_FQDN=$(terraform output -raw ddve_private_ip)
export ATOS_BUCKET=$(terraform output -raw atos_bucket)
export PPDD_TIMEZONE="Europe/Berlin"
```


set the Initial DataDomain Password
```bash
ansible-playbook ~/workspace/ansible_ppdd/1.0-Playbook-configure-initial-password.yml
```
![image](https://user-images.githubusercontent.com/8255007/232750620-df339f28-bdac-4db2-984f-a2df1d14b38e.png)
If you have a valid dd license, set the variable PPDD_LICENSE, example:
```bash
export PPDD_LICENSE=$(cat ~/workspace/license.xml)
ansible-playbook ~/workspace/ansible_ppdd/3.0-Playbook-set-dd-license.yml
```

next, we set the passphrase, as export PPDD_Lit is required for ATOS
then, we will set the Timezone and the NTP to GCP NTP link local  Server
```bash
ansible-playbook ~/workspace/ansible_ppdd/2.1-Playbook-configure-ddpassphrase.yml
ansible-playbook ~/workspace/ansible_ppdd/2.1.1-Playbook-set-dd-timezone-and-ntp-gcp.yml
```

Albeit there is a *ansible-playbook ~/workspace/ansible_ppdd/2.2-Playbook-configure-dd-atos-aws.yml* , we cannot use it, as the RestAPI Call to create Active Tier on Object is not available now for GCP...
Therefore us the UI Wizard


use the bucket from
```hcl
terraform output -raw atos_bucket
```
![image](https://user-images.githubusercontent.com/8255007/232740827-aa34e49c-9a2f-4b5a-b5ac-9611c4bbaf72.png)
![image](https://user-images.githubusercontent.com/8255007/232741190-23fd90a6-ad49-4a30-b73a-7998b991ac81.png)
![image](https://user-images.githubusercontent.com/8255007/232741254-36764cb8-bc3b-4726-9a52-33045e34e973.png)
![image](https://user-images.githubusercontent.com/8255007/232741309-d3953a38-cd49-4b30-a52f-0edc87a8818c.png)
![image](https://user-images.githubusercontent.com/8255007/232752980-52c8a365-d19d-44d8-ae1d-2b34a6b15b2e.png)
![image](https://user-images.githubusercontent.com/8255007/232754033-24d88999-c402-4010-8482-3d680d732ffe.png)


once the FIlesystem is enabled, we go ahead and enable the boost Protcol ...
```bash
ansible-playbook ~/workspace/ansible_ppdd/2.2-Playbook-configure-dd-atos-gcp.yml
```


# module_ppdm
set ppdm_count to desired number
```bash
terraform plan
```

when everything meets your requirements, run the deployment with

```bash
terraform apply --auto-approve
```


## PPDM

Similar to the DDVE Configuration, we will set Environment Variables for Ansible to Automatically Configure PPDM

```bash
# Refresh you Environment Variables if Multi Step !
eval "$(terraform output --json | jq -r 'with_entries(select(.key|test("^PP+"))) | keys[] as $key | "export \($key)=\"\(.[$key].value)\""')"
export PPDM_INITIAL_PASSWORD=Change_Me12345_
export PPDM_NTP_SERVERS='["169.254.169.254"]'
export PPDM_SETUP_PASSWORD=admin          # default password on the Cloud PPDM rest API
export PPDM_TIMEZONE="Europe/Berlin"
export PPDM_POLICY=PPDM_GOLD


```
Set the initial Configuration:    
```bash

ansible-playbook ~/workspace/ansible_ppdm/1.0-playbook_configure_ppdm.yml
```
verify the config:

```bash
ansible-playbook ~/workspace/ansible_ppdm/1.1-playbook_get_ppdm_config.yml
```
we add the DataDomain:  

```bash
ansible-playbook ~/workspace/ansible_ppdm/2.0-playbook_set_ddve.yml 
```
we can get the sdr config after Data Domain Boost auto-configuration for primary source  from PPDM

```bash
ansible-playbook ~/workspace/ansible_ppdm/3.0-playbook_get_sdr.yml
```
and see the dr jobs status
```bash
ansible-playbook ~/workspace/ansible_ppdm/31.1-playbook_get_activities.yml --extra-vars "filter='category eq \"DISASTER_RECOVERY\"'"
```

create a kubernetes policy and rule ...

```bash
ansible-playbook ~/workspace/ansible_ppdm/playbook_add_k8s_policy_and_rule.yml 
```

# module_networker

## Networker

```bash
eval "$(terraform output --json | jq -r 'with_entries(select(.key|test("^NVE+"))) | keys[] as $key | "export \($key)=\"\(.[$key].value)\""')"                                  
export NVE_PRIVATE_IP=$NVE_FQDN
export NVE_PASSWORD="Change_Me12345_"
export NVE_TIMEZONE="Europe/Berlin"
```


# module_gke
set create_gke to true
```bash
terraform plan
```

when everything meets your requirements, run the deployment with

```bash
terraform apply --auto-approve
```

### GKE configuration

get the context / login
```bash
export USE_GKE_GCLOUD_AUTH_PLUGIN=True
gcloud container clusters get-credentials $(terraform output --raw kubernetes_cluster_name) --region $(terraform output --raw location)
```

add the cluster
```bash
ansible-playbook ~/workspace/ansible_ppdm/playbook_rbac_add_k8s_to_ppdm.yml
```
Let´s view the Storageclasses

```bash
kubectl get sc
```
We need to create a new default class, as GKE will always reconcile its CSI Classes to WaitforFirstConsumer. SO we will read the default class, unset default, and create a new one out of it as default with Immediate Binding mode 

```bash
#Gdt default class
STORAGECLASS=$(kubectl get storageclass -o=jsonpath='{.items[?(@.metadata.annotations.storageclass\.kubernetes\.io/is-default-class=="true")].metadata.name}')
# Read storageclass into a new with volumeBindingMode Immediate
kubectl get sc $STORAGECLASS -o json | jq '.volumeBindingMode = "Immediate" | .metadata.name = "standard-rwo-csi"' > default.sc.json
# Patch default class to *not* be default
kubectl patch storageclass standard-rwo -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"false"}}}'
# Create a new default Class
kubectl apply -f default.sc.json
kubectl get sc
STORAGECLASS=$(kubectl get storageclass -o=jsonpath='{.items[?(@.metadata.annotations.storageclass\.kubernetes\.io/is-default-class=="true")].metadata.name}')
```


To use PPDM, we need to create a snapshot class

```bash
kubectl apply -f - <<EOF
apiVersion: snapshot.storage.k8s.io/v1
kind: VolumeSnapshotClass
metadata:
  name: standard-rwo-csi-vsc
driver: pd.csi.storage.gke.io
deletionPolicy: Delete
EOF

```

## run ppdm demo

[PPDM_K8S_Demo](../documentation/kubernetes_demo_workload.md)


### Accessing Ubuntu
when the deployment is finished, you can connect and configure DDVE in multiple ways.
for an ssh connection, use:


```bash
export UBUNTU_PRIVATE_FQDN=$(terraform output -raw ubuntu_private_ip)
terraform output ubuntu_ssh_private_key > ~/.ssh/ubuntu_key
chmod 0600 ~/.ssh/ubuntu_key
ssh -i ~/.ssh/ubuntu_key cloudadmin@${UBUNTU_PRIVATE_FQDN}
```


### Updating Versions only

If branched from here you might only want to update version.
The versions can be found from the Marketplace default jinja file on GCP , e.g. [DDVE](https://console.cloud.google.com/marketplace/product/dellemc-ddve-public/powerprotect-dd-virtual-edition) :  
 ddve.jinja:
```jinja
      {% if ddveVersion == "8.3.0.10" %}
        {% set ddveImage = "ddve-gcp-8-1-0-10-1127744" %}
      {% elif ddveVersion == "LTS2024 7.13.1.05" %}
        {% set ddveImage = "ddve-gcp-7-13-1-05-1126976" %}
      {% elif ddveVersion == "LTS2023 7.10.1.40" %}
        {% set ddveImage = "ddve-gcp-7-10-1-40-1126469" %}
      {% elif ddveVersion == "LTS2022 7.7.5.50" %}
        {% set ddveImage = "ddve-gcp-7-7-5-50-1129444" %}
      {% endif %}
```      

The code will always be maintained in  ./modules/ddve/ddve.tf:
```terraform
  ddve_image = {
    "8.3.0.10" = {
      projectId = "dellemc-ddve-public"
      imageName = "ddve-gcp-8-1-0-10-1127744"
    }    
    "LTS2024 7.13.1.05" = {
      projectId = "dellemc-ddve-public"
      imageName = "ddve-gcp-7-13-1-05-1126976"
    }    
    "LTS2023 7.10.1.40" = {
      projectId = "dellemc-ddve-public"
      imageName = "dddve-gcp-7-10-1-40-1126469"
    }
    "LTS2022 7.7.5.50" = {
      projectId = "dellemc-ddve-public"
      imageName = "ddve-gcp-7-7-5-50-1129444"
    }
  }
```
And in ./ddve_variables.tf:
```terraform
variable "ddve_version" {
  type        = string
  default     = "8.3.0.10"
  description = "DDVE Version, can be: 'LTS2022 7.7.5.50', 'LTS2023 7.10.1.40', 'LTS2024 7.13.1.05','8.3.0.10' " 
  validation {
    condition = anytrue([
      var.ddve_version == "LTS2022 7.7.5.50",
      var.ddve_version == "LTS2023 7.10.1.40",
      var.ddve_version == "LTS2024 7.13.1.05",
      var.ddve_version == "8.3.0.10",
    ])
    error_message = "Must be a valid DDVE Version, can be: 'LTS2022 7.7.5.50', 'LTS2023 7.10.1.40', 'LTS2024 7.13.1.05','8.3.0.10' ."
  }
}
```

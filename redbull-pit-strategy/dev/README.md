# LoL Optimizer deployment

## Requirements

- Active Oracle Cloud Account
- Credits available
- Administrative permissions

## Download

Open OCI Console, and click Cloud Shell.

```
git clone --branch dev https://github.com/oracle-devrel/redbull-pit-strategy.git
```

Change to `redbull-pit-strategy` directory:
```
cd redbull-pit-strategy
```

## Set up

From this directory `./dev`.
```
cd dev/
```

```
cp terraform/terraform.tfvars.template terraform/terraform.tfvars
```

Get details for the `terraform.tfvars` file:
- Tenancy:
  ```
  echo $OCI_TENANCY
  ```
- Compartment (root by default):
  ```
  echo $OCI_TENANCY
  ```
  > If you need a specific compartment, get the OCID by name with:
  > ```
  > oci iam compartment list --all --compartment-id-in-subtree true --name COMPARTMENT_NAME --query "data[].id"
  > ```


Edit the values with `vim` or `nano` with your tenancy, compartment, ssh public key and Riot API key:
```
vim terraform/terraform.tfvars
```

## Deploy

```
./start.sh
```

> If there are permission errors with **start.sh**, make sure to change permissions appropriately before trying to execute again:
  ```
  chmod 700 start.sh
  ```

> Re-run `start.sh` in case of failures.

### Destroy

```
./stop.sh
```
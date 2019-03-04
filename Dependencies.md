# Dependencies

## Google Compute Engine VM to work
Create a Google Compute Engine VM with the networkInterfaces on the same zone as the cluster installation
```http request
POST https://www.googleapis.com/compute/v1/projects/my-first-project/zones/us-central1-b/instances
{
  "kind": "compute#instance",
  "zone": "projects/my-first-project/zones/us-east1-b",
  "machineType": "projects/my-first-project/zones/us-central1-b/machineTypes/n1-standard-1",
 ...
  "networkInterfaces": [
    {
      "kind": "compute#networkInterface",
      "subnetwork": "projects/my-first-project/regions/us-central1/subnetworks/default",
      "accessConfigs": ...,
      "aliasIpRanges": []
    }
  ]
  ...

}
```

## Install the necessary dependencies on the VM
````bash
curl https://raw.githubusercontent.com/helm/helm/master/scripts/get | bash
helm init --client-only

sudo apt-get install kubectl
````

## Manual created Google Private DNS Zone
```http request
POST https://www.googleapis.com/dns/v1beta2/projects/my-first-project/managedZones
{
  "description": "Managed by Terraform",
  "dnsName": ".local.my.com.",
  "name": "my-private-dns-zone",
  "visibility": "private",
  "privateVisibilityConfig": {
    "networks": [
      {
        "networkUrl": "https://www.googleapis.com/compute/v1/projects/my-first-project/global/networks/default"
      }
    ]
  }
}
```
## Manual created Google bucket to save terraform state
```http request
https://console.cloud.google.com/storage/browser/my-infrastructure/workspaces/gke/?project=my-first-project
```

## Using a Provisioner Service Account

Before you begin, you must create/use a service account and create a json keyfile for Terraform to use for authentication. The provisioner account must have the following roles:

* Owner (TODO: use less fine grain permissions)
* Environment and Storage Object

After you create the keyfile, set `GOOGLE_CREDENTIALS` to the path of the file.

```
# .bashrc
export GOOGLE_CREDENTIALS=$(pwd)/credential.json
```

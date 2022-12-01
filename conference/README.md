# Conference Helm Chart
This is a helm chart used to deploy an entire Conference service collection, including:
* Conference
* Anycable
* Trustee Service
* DBB
* DBAS

Release names must be unique within the cluster, and map 1-to-1 to a namespace which has already been configured with the required database credentials and secrets to accomodate a deployment.

# Usage
In order to deploy this helm chart, you will need to have [helm](https://helm.sh) 3 or newer installed.

## Prerequisites
Deploying this chart requires some preparation. The chart requires a namespace containing a number of secrets to be present ahead of time. You can to create the requisite infrastructure, namespace and secrets using the exoscale `test-deployment` example in the [terraform-main](https://github.com/aion-dk/terraform-main) project.

The helm chart contains a number of precondition checks, which will fail if the requirements aren't met.

## Deploying
See [values.yaml](/values.yaml) for a list of configurable variables you can set, as well as their defaults.

Execute the deployment by running the following command, while in this directory:
```bash
$ helm install my-deployment-name .
```
Note that the release name (in this case *my-deployment-name*) must also be the name of the namespace created for this purpose. For example, there is currently only one active namespace, `test-deployment` with the required secrets to accomodate a deployment, so that is currently the only valid release name. To deploy to this namespace, you would run the following command:
```bash
$ helm install test-deployment .
```
If you want to override some of the default values, such as the image tag used for the conference containers and changing the certificate issuer for example, you can either set them on the command line like so:

```bash
helm install \
  --set conference.image.tag=e2e-2262385699893215ec8dfa8f5c72209f1864c82f \
  --set certificateIssuer=letsencrypt-staging \
  my-deployment-name .
```

Or use a yaml file with overrides:
```yaml
$ cat << EOF > my-overrides.yaml
conference:
  image:
    tag: e2e-2262385699893215ec8dfa8f5c72209f1864c82f

certificateIssue: "letsencrypt-staging"
EOF

$ helm install -f my-overrides.yaml my-deployment-name .
```

## Upgrading
If you have already installed a release of a given name and want to update some of the values, you should use `helm upgrade` instead of `helm install`. The options and arguments are the same for both commands.
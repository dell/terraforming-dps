# terraforming-dps

This is the terraform repo to deploy Dell Technologies Dataprotection Appliances to Cloud using terrafrom

See Subdirectories for Cloud Provider specific Deployments and getting started  
---
[terraforming-aws](./terraforming-aws/README.md)  
[terraforming-azure](./terraforming-azure/README.md)  
[terraforming-gcp](./terraforming-gcp/README.md)

## How to use
Cloud Provider comes with modules for individual Consumption. each Module has its own variable anf output file. 
You can use your own main file to connect to the modules, or use the Provided one, that allows you to dynamically select the modules to use.

The Modules support "Bring your own Infra", aka pre configured resources ( e.g. Networking or Pricipals )

## Contributing Guidelines
Contributions to this Repository are welcome, whether or not you work for Dell. Contributions may be:

Improvements to or fixes for existing example code

Updates to example documentation

Complete example code for a use case not currently included

Please note that pull requests that contribute new example code or update existing sample code in a way that affects usage should include documentation.




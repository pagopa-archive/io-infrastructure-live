# How to add a new web tests		

In order to add a new web test you will need to edit `request.json` and add an entry in the list of web test (remember it has to be in json format)

## Structure of a web test

```
    {
	"name": "webtestwithheaders",
	"url": "https://io-dev-apim-01.azure-api.net/api/v1/profiles/ETOXUW84A84Y778X",
	"headers_xml": ["Ocp-Apim-Subscription-Key"]
    }
```

* name        => name of the test
* url         => url to test
* headers_xml => a list of strings that contains the name of the header. The value will be retrieved from azure Keyvault.

>**NOTE:** header names need to be consistent with the name of the secrets in the Keyvault, but need also to have a slightly different format, following a convention. For example, for a header called `Ocp-Apim-Subscription-Key` a secret called `app-insight-web-tests-Ocp-Apim-Subscription-Key` should be present in Azure KeyVault.

## Generate the web tests live file (terraform.tfvars)

Running `python generate-terraform-tfvars.py` within `io-infrastructure-live/westeurope/app_insights_web_tests` a new `terraform.tfvars` will be generated in the same folder. Then, it can be applied in production with terragrunt. 

>**BE CAREFUL** DO NOT commit the *terraform.tfvars* generated, as it contains configuration secrets that shouldn't be shared with others.

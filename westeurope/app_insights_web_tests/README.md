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

* name => name of the test
* url  => url we want to test
* headers_xml => is a list of string that contains the Name of the header, the value will be retrieved from azure key vault.


### Note about headers:

headers have to be saved with a specific name. If we want to have a header called `Ocp-Apim-Subscription-Key` we need to save it as
`app-insight-web-tests-Ocp-Apim-Subscription-Key` in Azure Key Vault.


## Generate the web tests (terraform.tfvars)

Simpy run `python generate-terraform-tfvars.py` within `io-infrastructure-live/westeurope/app_insights_web_tests` and a new terraform.tfvars will be added. Then you can follow the normal procedure to apply it to production with terragrunt. 

**BE CAREFUL** to not commit terraform.tfvars as it contains configuration secrets we wouldn't like to share with the rest of the world.
#!/usr/bin/env python

import shlex
import json
import subprocess


TERRAFORM_TFVARS="""
# The module creates and configure application insights web tests

# Existing infrastructure
terragrunt = {
  dependencies {
    paths = [
      "../app_insights_web_tests"
    ]
  }

  terraform {
    source = "git::git@github.com:teamdigitale/io-infrastructure-modules.git//azurerm_app_insights_web_tests"
  }

  # Include all settings from the root terraform.tfvars file
  include = {
    path = "${find_in_parent_folders()}"
  }
}

# New infrastructure

azurerm_application_insight_suffix = "01"

web_tests = [ @@WEB_TESTS@@ ]
"""

WEB_TEST_HCL="""
    {
        "name"        = "@@web_test_name@@",
        "method"      = "@@web_test_method@@",
        "url"         = "@@web_test_url@@",
        "body"        = "@@web_test_body@@"
        "headers_xml" = <<XML
                        "@@web_test_headers_xml@@"
XML
    },
"""

def get_secret_value(header):
    cmd = shlex.split("az keyvault secret show --name app-insight-web-tests-%s --vault-name io-dev-keyvault" % header)

    try:
        result = subprocess.check_output(cmd)
        j = json.loads(result)
        return j["value"]

    except subprocess.CalledProcessError as e:
        print("An error has occured")
        return ""

web_tests = json.load(open("request.json"))

final = []
for test in web_tests:
    web_test = WEB_TEST_HCL
    web_test = web_test.replace("@@web_test_name@@", test["name"])
    web_test = web_test.replace("@@web_test_url@@", test["url"])

    web_test = web_test.replace("@@web_test_method@@", test.get("method", "GET"))
    web_test = web_test.replace("@@web_test_body@@", str(test.get("body", "")))

    try:
        if test["headers_xml"]:
            headers_string = ""
            for header in test["headers_xml"]:
                value = get_secret_value(header)
                header = '<Header Name="%s" Value="%s"/>' % (header, value)
                headers_string = headers_string+header
            web_test = web_test.replace("@@web_test_headers_xml@@", headers_string)

    except KeyError:
        web_test = web_test.replace("@@web_test_headers_xml@@", "")

    final.append(web_test)


with open("terraform.tfvars", "w") as f:
    f.write(TERRAFORM_TFVARS.replace("@@WEB_TESTS@@", "".join(final)))

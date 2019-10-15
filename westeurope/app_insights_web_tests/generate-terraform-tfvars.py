#!/usr/bin/env python

from base64 import b64encode
import shlex
import json
import subprocess

from jinja2 import Template

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
        "xml"         = <<XML
"@@web_test_xml@@"
XML
    },
"""

WEB_TEST_XML= Template("""
  <WebTest Name="{{test["name"] }}" Id="ABD48585-0831-40CB-9069-682EA6BB3583" Enabled="True"
	   CssProjectStructure="" CssIteration="" Timeout="0" WorkItemIds=""
	   xmlns="http://microsoft.com/schemas/VisualStudio/TeamTest/2010"
	   Description="" CredentialUserName="" CredentialPassword="" PreAuthenticate="True" Proxy="default"
	   StopOnError="False" RecordedResultFile="" ResultsLocale="">
    <Items>
      <Request Method="{{ test["method"] }}" Guid="a5f10126-e4cd-570d-961c-cea43999a200"
        Version="1.1" Url="{{ test["url"] }}"
	ThinkTime="0" Timeout="300" ParseDependentRequests="True" FollowRedirects="True" RecordResult="True"
	Cache="False" ResponseTimeGoal="0" Encoding="utf-8" ExpectedHttpStatusCode="200"
	ExpectedResponseUrl="" ReportingName="" IgnoreHttpStatusCode="False">
	<Headers>
          {{ test_headers }}
	</Headers>
        {% if test["method"] == "POST" %}
	<StringHttpBody ContentType="application/json">{{ test["s_body"] }}</StringHttpBody>
        {% endif %}
      </Request>
    </Items>
  </WebTest>
"""
)

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

    web_test_xml = WEB_TEST_XML
    b_body = b64encode(bytearray(str(test.get("body", "")), "utf-8"))
    test["s_body"] = b_body.decode("utf-8")

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

    r_web_test_xml = web_test_xml.render(test=test)
    web_test = web_test.replace("@@web_test_xml@@", r_web_test_xml)

    final.append(web_test)


with open("terraform.tfvars", "w") as f:
    f.write(TERRAFORM_TFVARS.replace("@@WEB_TESTS@@", "".join(final)))

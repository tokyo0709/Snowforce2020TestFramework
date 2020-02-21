# Snowforce2020TestFramework

This repo is meant to be a guide in discovering better methods and practices to approach unit testing in Salesforce. This guide is not meant to be a definitive solution to all organizational testing needs. If you have any questions feel free to tweet me [@SFDevFrank](https://twitter.com/SFDevFrank).

## How to use this Repo

This repository is built with a single feature in mind located in the `AccountAutomations.cls` file for the `syncRelationsLastAccessed` function. This feature simply takes an Account Id and synchronizes a custom field on the Account, any related Contacts, any related Assets, and any related Opportunities with today's date. Several files are then implemented to test this functionality with their own unique style. Each test class evaluates the exact same logic and performs the exact same asserts. Advantages and Disadvantages are listed at the top of each file and you can see for yourself how it may or may not work for your organization.

The current test classes and related files with their style of testing are as follows,

### The Isolated Test
- `AccountAutomationsTest_Ex1.cls`
### Test Setup Centralization
- `AccountAutomationsTest_Ex2.cls`
### Backup Helper File
- `AccountAutomationsTest_Ex3.cls`
  - `Ex3_DataFactory.cls`
### General Data Factory
- `AccountAutomationsTest_Ex4.cls`
  - `GeneralDataFactory.cls`
### Composable Data Factories
- `AccountAutomationsTest_Ex5.cls`
  - `MDF_AccountFactory.cls`
  - `MDF_AssetFactory.cls`
  - `MDF_ContactFactory.cls`
  - `MDF_OpportunityFactory.cls`
### Composable Data Factories (Upgraded)
- `AccountAutomationsTest_Ex6.cls`
  - `MDF_AccountFactory.cls`
  - `MDF_AssetFactory.cls`
  - `MDF_ContactFactory.cls`
  - `MDF_ContactFactory_v2.cls`
  - `MDF_OpportunityFactory.cls`
  - `MDF_OpportunityFactory_v2.cls`
  - `MDF_FactoryDataSets.cls`
  - `MDF_FactoryOrchestrator.cls`

## Data Factory Basic Architecture

Composable Data Factories are simple, easy to read, and flexible to reuse. You will learn more by walking through `AccountAutomationsTest_Ex5.cls` but the basic architecture looks like this,

![Data Factory Basic Architecture](https://i.imgur.com/6aOpJLQ.png)

Each Object Factory can be reused in different feature sets to create a configurable and abstracted record that fits the needs of the specific tests.

A basic insert of a configured object could be written like this,

```java
Account testAccount = MDF_AccountFactory.start()
    .withDescription()
    .withWebsite()
    .withBillingAddress()
    .withShippingAddress()
    .create();
```

And the simple logic inside these composable functions might look like this,

```java
public MDF_AccountFactory withBillingAddress() {
    current.BillingStreet = '1355 West 3100 South';
    current.BillingCity = 'West Valley City';
    current.BillingState = 'UT';
    current.BillingPostalCode = '84119';
    current.BillingCountry = 'United States';
    return this;
}
```

## Data Factory Orchestrator Architecture

One of the best features to combine with reusable Data Factories might be a Factory Orchestrator. This utility allows the user to orchestrate the creation of commonly reused configurations of records and data in order to simplify testing even further. The architecture might look like this,

![Data Factory Orchestrator Architecture](https://i.imgur.com/Ad2GJPN.png)

You can see here that we are reusing our object factories to create specific configurations of subsets of data. In this case we have a `QualifyingAccount` that might consist of an Account  with a new Opportunity in the Qualifying stage and a Contact. This might be useful for us to test features and functionality that often happens early on in the Sales process. On the other hand we might also have a `QuotedAccount` which consists of an Account with a Contact, a Closed Won Opportunity, and possibly some Assets already configured. This may be beneficial in features and functionality that often need to address automations after the main Sales process has been completed.

Overall the goal is to give us different touch points in the Sales process that address generic needs with our testing. Since these will never meet the needs of all features needing testing we can fall back on using our configurable factories for custom edge cases, or create more reusable orchestrations to meet other needs.

## Data Factory and Testing Snippets

Getting started with building data factories and effective testing can be greatly sped along with some quality snippets. To set these up in VS Code search in your Power Commands for `Configure User Snippets`. Make sure to then select your `apex.json` file and paste these snippets in.

### Simple Data Factory Snippet

This is the most basic version of a Data Factory you can implement without the mocking data upgrade and the record update functionality. Most Data factories can suffice with just this basic structure and composable functions.

```json
"sDataFact": {
	"prefix": "sDataFact",
	"body": [ 
		"@isTest",
		"public class ${1:Object}Factory {",
			"\tprivate ${2:Object} current;",
			
			"\n\tpublic ${1:Object}Factory(${2:Object} current) {",
				"\t\tthis.current = current;",
			"\t}",
			
			"\n\t// Entry point builder method to start composing object attributes",
			"\tpublic static ${1:Object}Factory start() {",
				"\t\treturn new ${1:Object}Factory(",
					"\t\t\tnew ${2:Object}()",
				"\t\t);",
			"\t}",
			
			"\n\t// Composable Functions",
			"\t$0",
			
			"\n\tpublic ${2:Object} create() {",
				"\t\tinsert current;",
				"\t\treturn current;",
			"\t}",
		"}"
	]
}
```

### Test Method Standard

A quick and easy way to help keep some uniformity with your unit testing is to follow the Arrange-Act-Assert (AAA) pattern.

```json
"testm": {
	"prefix": "testm",
	"body": [
		"@IsTest static void ${1:functionName}_${2:TestedFunctionality}() {\n\n\t",
		
			"// ARRANGE\n\t",
			"$0\n\n\t",
			
			"// ACT\n\t",
			"test.startTest();\n\n\t",
			
			"test.stopTest();\n\n\t",
			
			"// ASSERT\n\t",
			"System.assert(false, 'NOT IMPLEMENTED');\n",
		"}"
	]
}
```

### Apex Asserts

Some short and sweet snippets to move quickly with Asserts in Apex.

```json
"assert": {
	"prefix": "assert",
	"body": "System.assert(${1:Condition})",
	"description": "Basic assert condition"
}
```

```json
"assertEq": {
	"prefix": "assertEq",
	"body": "System.assertEquals(${1:Expected}, ${2:Actual})",
	"description": "Basic assert equals"
}
```

```json
"assertNotEq": {
	"prefix": "assertNotEq",
	"body": "System.assertEquals(${1:Expected}, ${2:Actual})",
	"description": "Basic assert not equals"
}
```
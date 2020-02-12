/*
COMPOSABLE DATA FACTORIES

Below is an example of an approach to Unit Testing in Salesforce by isolating
generated test data within individual data factories per SObject. These Factories
are made up of several composable functions that allow you to quickly build out
test data and clearly read it upon later maintanence 

Advantages:
- Factories can be created as needed
- Highly readable
- Easy to interface with
- Not overly complicated and maintains flexibility

Disadvantages:
- Large file infrastructure
- You have to be careful about changing expected functionality

*/

@IsTest
public class AccountAutomationsTest_Ex5 {
    
    @IsTest static void syncRelationsLastAccessed_AllObjectsSynced() {
    
        // ARRANGE
        Account testAccount = MDF_AccountFactory.start()
            .withDescription()
            .withWebsite()
            .withBillingAddress()
            .withShippingAddress()
            .create();

        Contact testContact = MDF_ContactFactory.start()
            .withAccount(testAccount)
            .withContactDetails()
            .withMailingAddress()
            .create();

        Opportunity testOpportunity = MDF_OpportunityFactory.start()
            .withAccount(testAccount)
            .asNewCustomer()
            .withCloseDateToday()
            .withPricingInformation()
            .withStageQualification()
            .create();

        Asset testAsset = MDF_AssetFactory.start(testAccount)
            .withQuantity()
            .asPurchased()
            .create();
    
        // ACT
        test.startTest();
        AccountAutomations.syncRelationsLastAccessed(testAccount.Id);
        test.stopTest();

        Account updatedAccount = [ SELECT Id, Relations_Last_Accessed__c FROM Account WHERE Id = :testAccount.Id ];
        List<Contact> updatedContacts = [ SELECT Id, Relations_Last_Accessed__c FROM Contact WHERE AccountId = :testAccount.Id ];
        List<Opportunity> updatedOpps = [ SELECT Id, Relations_Last_Accessed__c FROM Opportunity WHERE AccountId = :testAccount.Id ];
        List<Asset> updatedAssets = [ SELECT Id, Relations_Last_Accessed__c FROM Asset WHERE AccountId = :testAccount.Id ];
    
        // ASSERT
        System.assertEquals(Date.today(), updatedAccount.Relations_Last_Accessed__c);
        System.assertEquals(1, updatedContacts.size());
        System.assertEquals(Date.today(), updatedContacts[0].Relations_Last_Accessed__c);
        System.assertEquals(1, updatedOpps.size());
        System.assertEquals(Date.today(), updatedOpps[0].Relations_Last_Accessed__c);
        System.assertEquals(1, updatedAssets.size());
        System.assertEquals(Date.today(), updatedAssets[0].Relations_Last_Accessed__c);
    }
}
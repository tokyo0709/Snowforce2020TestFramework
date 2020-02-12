/*
GENERAL DATA FACTORY

Below is an example of an approach to Unit Testing in Salesforce by isolating
generated test data within a general data factory file. By
removing the data generation from the test file we have focused the purpose
of this file to strictly evaluating test functionality. Isolating the 
Data Factory and generalizing it will allow us to reuse it in the future
for other test classes

Advantages:
- Code Reusability across multiple files
- Slightly improved readability on Unit Tests
- One reference point between multiple engineers

Disadvantages:
- Will devolve into a sprawling mess eventually
- Overlapping functions will eventually be necessary
- Will need to reference the helper often to verify what type of data is being generated

*/

@IsTest
public class AccountAutomationsTest_Ex4 {
    
    @IsTest static void syncRelationsLastAccessed_AllObjectsSynced() {
    
        // ARRANGE
        Account testAccount = GeneralDataFactory.createAccount();
        GeneralDataFactory.createContact(testAccount);
        GeneralDataFactory.createOpportunity(testAccount);
        GeneralDataFactory.createAsset(testAccount);
    
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
/*
BACKUP HELPER FILE

Below is an example of an approach to Unit Testing in Salesforce by isolating
generated test data within a directly related general data factory file. By
removing the data generation from the test file we have focused the purpose
of this file to strictly evaluating test functionality

Advantages:
- Distinct seperation between tests and data generation
- Slightly Improved readability on Unit Tests
- Code reusability within one file

Disadvantages:
- Temptation to reuse this test class specific helper with other test classes
- May need to reference the helper functions often to determine what kind of data is being generated
- Helper can tend to sprawl and become tech debt

*/

@IsTest
public class AccountAutomationsTest_Ex3 {
    
    @IsTest static void syncRelationsLastAccessed_AllObjectsSynced() {
    
        // ARRANGE
        Account testAccount = Ex3_DataFactory.createAccount();
        Ex3_DataFactory.createContact(testAccount);
        Ex3_DataFactory.createOpportunity(testAccount);
        Ex3_DataFactory.createAsset(testAccount);
    
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
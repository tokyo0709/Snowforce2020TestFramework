/*
COMPOSABLE DATA FACTORIES WITH FACTORY ORCHESTRATOR

Below is an example of an approach to Unit Testing in Salesforce by isolating
generated test data within individual data factories per SObject. These Factories
are made up of several composable functions that allow you to quickly build out
test data and clearly read it upon later maintanence. This pattern is augmented
by the utilization of a factory orchestrator for commonly used data sets.

*/

@IsTest
public class AccountAutomationsTest_Ex6 {
    
    @IsTest static void syncRelationsLastAccessed_AllObjectsSynced() {
    
        // ARRANGE
        MDF_FactoryOrchestrator factoryOrchestrator = new MDF_FactoryOrchestrator();
        MDF_FactoryDataSets.QualifyingAccountWithAssets_DataSet dataSet = factoryOrchestrator.QualifyingAccountWithAssets();
    
        // ACT
        test.startTest();
        AccountAutomations.syncRelationsLastAccessed(dataSet.TestAccount.Id);
        test.stopTest();

        Account updatedAccount = [ SELECT Id, Relations_Last_Accessed__c FROM Account WHERE Id = :dataSet.TestAccount.Id ];
        List<Contact> updatedContacts = [ SELECT Id, Relations_Last_Accessed__c FROM Contact WHERE AccountId = :dataSet.TestAccount.Id ];
        List<Opportunity> updatedOpps = [ SELECT Id, Relations_Last_Accessed__c FROM Opportunity WHERE AccountId = :dataSet.TestAccount.Id ];
        List<Asset> updatedAssets = [ SELECT Id, Relations_Last_Accessed__c FROM Asset WHERE AccountId = :dataSet.TestAccount.Id ];
    
        // ASSERT
        System.assertEquals(Date.today(), updatedAccount.Relations_Last_Accessed__c);
        System.assertEquals(1, updatedContacts.size());
        System.assertEquals(Date.today(), updatedContacts[0].Relations_Last_Accessed__c);
        System.assertEquals(1, updatedOpps.size());
        System.assertEquals(Date.today(), updatedOpps[0].Relations_Last_Accessed__c);
        System.assertEquals(2, updatedAssets.size());
        System.assertEquals(Date.today(), updatedAssets[0].Relations_Last_Accessed__c);
        System.assertEquals(Date.today(), updatedAssets[1].Relations_Last_Accessed__c);
    }
}
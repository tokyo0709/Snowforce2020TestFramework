/*
THE ISOLATED TEST

Below is an example of an approach to Unit Testing in Salesforce by isolating
all of your test data generation within the test itself.

Advantages:
- 

Disadvantages:
- 

*/

@IsTest
public class AccountAutomationsTest_Ex1 {
    
    @IsTest static void syncRelationsLastAccessed_AllObjectsSynced() {
    
        // ARRANGE
        Account account = new Account();
        account.Name = 'Test Account';
        account.Description = 'A test account for demonstration';
        account.Website = 'www.test.com';
        account.BillingStreet = '1355 West 3100 South';
        account.BillingCity = 'West Valley City';
        account.BillingState = 'UT';
        account.BillingPostalCode = '84119';
        account.BillingCountry = 'United States';
        account.ShippingStreet = '1355 West 3100 South';
        account.ShippingCity = 'West Valley City';
        account.ShippingState = 'UT';
        account.ShippingPostalCode = '84119';
        account.ShippingCountry = 'United States';
        insert account;

        Contact contact = new Contact();
        contact.FirstName = 'John';
        contact.LastName = 'Doe';
        contact.AccountId = account.Id;
        contact.HomePhone = '801-135-2468';
        contact.Phone = '801-123-4567';
        contact.MobilePhone = '801-246-1357';
        contact.AssistantPhone = '801-765-4321';
        contact.Fax = '888-888-8888';
        contact.MailingStreet = '1355 West 3100 South';
        contact.MailingCity = 'West Valley City';
        contact.MailingState = 'UT';
        contact.MailingPostalCode = '84119';
        contact.MailingCountry = 'United States';
        insert contact;

        Opportunity opportunity = new Opportunity();
        opportunity.Name = 'Test Opp';
        opportunity.AccountId = account.Id;
        opportunity.StageName = 'Qualification';
        opportunity.Type = 'New Customer';
        opportunity.CloseDate = Date.today();
        opportunity.Amount = 5000.00;
        opportunity.Pricebook2Id = Test.getStandardPricebookId();
        insert opportunity;

        Asset asset = new Asset();
        asset.Name = 'Test Asset';
        asset.AccountId = account.Id;
        asset.Quantity = 2;
        asset.Status = 'Purchased';
        insert asset;
    
        // ACT
        test.startTest();
        AccountAutomations.syncRelationsLastAccessed(account.Id);
        test.stopTest();

        Account updatedAccount = [ SELECT Id, Relations_Last_Accessed__c FROM Account WHERE Id = :account.Id ];
        List<Contact> updatedContacts = [ SELECT Id, Relations_Last_Accessed__c FROM Contact WHERE AccountId = :account.Id ];
        List<Opportunity> updatedOpps = [ SELECT Id, Relations_Last_Accessed__c FROM Opportunity WHERE AccountId = :account.Id ];
        List<Asset> updatedAssets = [ SELECT Id, Relations_Last_Accessed__c FROM Asset WHERE AccountId = :account.Id ];
    
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

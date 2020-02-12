public class GeneralDataFactory {
    
    public static Account createAccount() {

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

        return account;
    }

    public static Contact createContact(Account account) {

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

        return contact;
    }

    public static Opportunity createOpportunity(Account account) {

        Opportunity opportunity = new Opportunity();
        opportunity.Name = 'Test Opp';
        opportunity.AccountId = account.Id;
        opportunity.StageName = 'Qualification';
        opportunity.Type = 'New Customer';
        opportunity.CloseDate = Date.today();
        opportunity.Amount = 5000.00;
        opportunity.Pricebook2Id = Test.getStandardPricebookId();
        insert opportunity;

        return opportunity;
    }

    public static Asset createAsset(Account account) {

        Asset asset = new Asset();
        asset.Name = 'Test Asset';
        asset.AccountId = account.Id;
        asset.Quantity = 2;
        asset.Status = 'Purchased';
        insert asset;

        return asset;
    }
}

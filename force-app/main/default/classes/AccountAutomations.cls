public class AccountAutomations {
    
    // ** An example feature used to simulate different types of Unit Tests **
    //
    // This function takes an Account Id and sets a custom Date field to Today's date
    // for the Account and all the related Contacts, Opportunities, and Assets
    public static void syncRelationsLastAccessed(String accountId) {

        // Get data to update
        Account accountToUpdate = [ SELECT Id, Name FROM Account WHERE Id = :accountId ];
        List<Contact> contactsToUpdate = [ SELECT Id, Name FROM Contact WHERE AccountId = :accountId ];
        List<Opportunity> oppsToUpdate = [ SELECT Id, Name FROM Opportunity WHERE AccountId = :accountId ];
        List<Asset> assetsToUpdate = [ SELECT Id, Name FROM Asset WHERE AccountId = :accountId ];

        // Set current date
        Date today = Date.today();

        // Update objects
        accountToUpdate.Relations_Last_Accessed__c = today;
        
        for (Contact contact : contactsToUpdate) {
            contact.Relations_Last_Accessed__c = today;
        }

        for (Opportunity opp : oppsToUpdate) {
            opp.Relations_Last_Accessed__c = today;
        }

        for (Asset asset : assetsToUpdate) {
            asset.Relations_Last_Accessed__c = today;
        }

        update accountToUpdate;
        update contactsToUpdate;
        update oppsToUpdate;
        update assetsToUpdate;
    }
}

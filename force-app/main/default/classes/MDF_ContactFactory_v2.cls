@isTest
public class MDF_ContactFactory_v2 {
    private Contact current;

    public MDF_ContactFactory_v2(Contact current) {
        this.current = current;
    }

    // Entry point builder method to start composing object attributes
    public static MDF_ContactFactory_v2 start() {
        return new MDF_ContactFactory_v2(
            new Contact( FirstName = 'John', LastName = 'Doe' )
        );
    }

    // No required fields set since we are mocking data
    public static MDF_ContactFactory_v2 mock() {
        return new MDF_ContactFactory_v2(
            new Contact()
        );
    }

    // Composable Functions
    public MDF_ContactFactory_v2 overrideName(String first, String last) {
        current.FirstName = first;
        current.LastName = last;
        return this;
    }

    public MDF_ContactFactory_v2 relatedAccount(Account account) {
        current.AccountId = account.Id;
        return this;
    }

    public MDF_ContactFactory_v2 withContactDetails() {
        current.HomePhone = '801-135-2468';
        current.Phone = '801-123-4567';
        current.MobilePhone = '801-246-1357';
        current.AssistantPhone = '801-765-4321';
        current.Fax = '888-888-8888';
        return this;
    }

    public MDF_ContactFactory_v2 withMailingAddress() {
        current.MailingStreet = '1355 West 3100 South';
        current.MailingCity = 'West Valley City';
        current.MailingState = 'UT';
        current.MailingPostalCode = '84119';
        current.MailingCountry = 'United States';
        return this;
    }

    public Contact create() {
        insert current;
        return current;
    }

    // Return the constructed object without inserting
    public Contact build() {
        return current;
    }
}
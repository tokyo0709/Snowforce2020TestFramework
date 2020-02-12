@isTest
public class MDF_AccountFactory {
    private Account current;

    public MDF_AccountFactory(Account current) {
        this.current = current;
    }

    // Entry point builder method to start composing object attributes
    public static MDF_AccountFactory start() {
        return new MDF_AccountFactory(
            new Account( Name = 'Test Account' )
        );
    }

    // Composable Functions
    public MDF_AccountFactory withDescription() {
        current.Description = 'Some description';
        return this;
    }

    public MDF_AccountFactory withWebsite() {
        current.Website = 'www.test.com';
        return this;
    }

    public MDF_AccountFactory withBillingAddress() {
        current.BillingStreet = '1355 West 3100 South';
        current.BillingCity = 'West Valley City';
        current.BillingState = 'UT';
        current.BillingPostalCode = '84119';
        current.BillingCountry = 'United States';
        return this;
    }

    public MDF_AccountFactory withShippingAddress() {
        current.ShippingStreet = '1355 West 3100 South';
        current.ShippingCity = 'West Valley City';
        current.ShippingState = 'UT';
        current.ShippingPostalCode = '84119';
        current.ShippingCountry = 'United States';
        return this;
    }

    public Account create() {
        insert current;
        return current;
    }
}
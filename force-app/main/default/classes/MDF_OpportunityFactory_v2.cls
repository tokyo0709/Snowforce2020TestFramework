@isTest
public class MDF_OpportunityFactory_v2 {
    private Opportunity current;

    public MDF_OpportunityFactory_v2(Opportunity current) {
        this.current = current;
    }

    // Entry point builder method to start composing object attributes
    public static MDF_OpportunityFactory_v2 start() {
        return new MDF_OpportunityFactory_v2(
            new Opportunity( Name = 'Test Opportunity')
        );
    }

    // Overloaded function to modify existing data
    public static MDF_OpportunityFactory_v2 start(Opportunity opportunity) {
        return new MDF_OpportunityFactory_v2(
            opportunity
        );
    }

    // Composable Functions
    public MDF_OpportunityFactory_v2 relatedAccount(Account account) {
        current.AccountId = account.Id;
        return this;
    }

    public MDF_OpportunityFactory_v2 withStageQualification() {
        current.StageName = 'Qualification';
        return this;
    }

    public MDF_OpportunityFactory_v2 asNewCustomer() {
        current.Type = 'New Customer';
        return this;
    }

    public MDF_OpportunityFactory_v2 withCloseDateToday() {
        current.CloseDate = Date.today();
        return this;
    }

    public MDF_OpportunityFactory_v2 withPricingInformation() {
        current.Amount = 5000;
        current.Pricebook2Id = Test.getStandardPricebookId();
        return this;
    }

    public Opportunity create() {
        insert current;
        return current;
    }

    // Exit function that updates the current object
    public Opportunity modify() {
        update current;
        return current;
    }
}
@isTest
public class MDF_OpportunityFactory {
    private Opportunity current;

    public MDF_OpportunityFactory(Opportunity current) {
        this.current = current;
    }

    // Entry point builder method to start composing object attributes
    public static MDF_OpportunityFactory start() {
        return new MDF_OpportunityFactory(
            new Opportunity( Name = 'Test Opportunity')
        );
    }

    // Composable Functions
    public MDF_OpportunityFactory asNewCustomer() {
        current.Type = 'New Customer';
        return this;
    }

    public MDF_OpportunityFactory relatedAccount(Account account) {
        current.AccountId = account.Id;
        return this;
    }

    public MDF_OpportunityFactory withStageQualification() {
        current.StageName = 'Qualification';
        return this;
    }

    public MDF_OpportunityFactory withCloseDateToday() {
        current.CloseDate = Date.today();
        return this;
    }

    public MDF_OpportunityFactory withPricingInformation() {
        current.Amount = 5000;
        current.Pricebook2Id = Test.getStandardPricebookId();
        return this;
    }

    public Opportunity create() {
        insert current;
        return current;
    }
}
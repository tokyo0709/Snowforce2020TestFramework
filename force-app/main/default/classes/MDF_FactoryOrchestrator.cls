public class MDF_FactoryOrchestrator {
    
    public MDF_FactoryDataSets DataSets { get; set; }
    
    public MDF_FactoryOrchestrator() {
        DataSets = new MDF_FactoryDataSets();
    }

    // Orchestrated Test Data Sets
    public MDF_FactoryDataSets.QualifyingAccountWithAssets_DataSet QualifyingAccountWithAssets() {

        MDF_FactoryDataSets.QualifyingAccountWithAssets_DataSet dataSet = DataSets.QualifyingAccountWithAssetsTestData;

        dataSet.TestAccount = MDF_AccountFactory.start()
            .withDescription()
            .withWebsite()
            .withBillingAddress()
            .withShippingAddress()
            .create();

        dataSet.TestContact = MDF_ContactFactory.start()
            .overrideName('Jane', 'Smith')
            .relatedAccount(dataSet.TestAccount)
            .withContactDetails()
            .withMailingAddress()
            .create();

        dataSet.TestOpportunity = MDF_OpportunityFactory.start()
            .relatedAccount(dataSet.TestAccount)
            .asNewCustomer()
            .withCloseDateToday()
            .withPricingInformation()
            .withStageQualification()
            .create();

        // Test Assets
        dataSet.TestAssetOne = MDF_AssetFactory.start(dataSet.TestAccount)
            .withQuantity()
            .asPurchased()
            .create();

        dataSet.TestAssetTwo = MDF_AssetFactory.start(dataSet.TestAccount)
            .withQuantity()
            .asPurchased()
            .create();

        return dataSet;
    }
}

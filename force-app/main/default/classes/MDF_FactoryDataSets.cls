public class MDF_FactoryDataSets {

    public QualifyingAccountWithAssets_DataSet QualifyingAccountWithAssetsTestData { get; set; }

    public MDF_FactoryDataSets() {
        QualifyingAccountWithAssetsTestData = new QualifyingAccountWithAssets_DataSet();
    }

    public class QualifyingAccountWithAssets_DataSet {

        public Account TestAccount { get; set; }
        public Contact TestContact { get; set; }
        public Opportunity TestOpportunity { get; set; }
        public Asset TestAssetOne { get; set; }
        public Asset TestAssetTwo { get; set; }
    }
}

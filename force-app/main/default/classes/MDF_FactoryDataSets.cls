public class MDF_FactoryDataSets {

    public QualifyingAccountWithAsset_DataSet QualifyingAccountWithAssetTestData { get; set; }

    public MDF_FactoryDataSets() {
        QualifyingAccountWithAssetTestData = new QualifyingAccountWithAsset_DataSet();
    }

    public class QualifyingAccountWithAsset_DataSet {

        public Account TestAccount { get; set; }
        public Contact TestContact { get; set; }
        public Opportunity TestOpportunity { get; set; }
        public Asset TestAsset { get; set; }
    }
}

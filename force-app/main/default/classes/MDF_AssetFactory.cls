@isTest
public class MDF_AssetFactory {
    private Asset current;

    public MDF_AssetFactory(Asset current) {
        this.current = current;
    }

    // Entry point builder method to start composing object attributes
    public static MDF_AssetFactory start(Account account) {
        return new MDF_AssetFactory(
            new Asset( Name = 'Test Asset', AccountId = account.Id )
        );
    }

    // Composable Functions
    public MDF_AssetFactory withQuantity() {
        current.Quantity = 2;
        return this;
    }

    public MDF_AssetFactory asPurchased() {
        current.Status = 'Purchased';
        return this;
    }

    public Asset create() {
        insert current;
        return current;
    }
}
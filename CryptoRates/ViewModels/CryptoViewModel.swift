import UIKit

class CryptoViewModel {
    
    // MARK: Variables
    let coin: Coin
    
    // MARK: Setup of CryptoViewController label texts
    
    init(coin:Coin) {
        self.coin = coin
    }
    
    var rank: String {
        return "Rank: \(coin.cmcRank)"
    }
    
    var maxSupply: String {
        guard let maxSupply = coin.maxSupply else {return "There is no value"}
        return "Max supply: \(maxSupply)"
    }
    
    var price: String {
        return "Price: \(coin.pricingData.price)"
    }
    
    var marketCap: String {
        return "Market supply: \(coin.pricingData.marketCap)"
    }
}

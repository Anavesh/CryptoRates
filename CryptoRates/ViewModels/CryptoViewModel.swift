import UIKit

class CryptoViewModel {
    
    // MARK: Variables
    let coin: Coin
    
    // MARK: Setup of CryptoViewController label texts
    
    init(coin:Coin) {
        self.coin = coin
    }
    
    var rankLabel: String {
        return "Rank: \(coin.cmcRank)"
    }
    
    var maxSupplyLabel: String {
        guard let maxSupply = coin.maxSupply else {return "There is no value"}
        return "Max supply: \(maxSupply)"
    }
}

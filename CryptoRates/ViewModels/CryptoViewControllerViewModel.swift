import UIKit

class CryptoViewControllerViewModel {
    
    // MARK: - Variables
    
    let coin: Coin
    
    // MARK: - Setup of CryptoViewController label texts
    
    init(coin: Coin) {
        self.coin = coin
    }
    
    var rank: String {
        return "Rank: \(coin.rank)"
    }
    
    var maxSupply: String {
        if let maxSupply = coin.maxSupply {
            guard let formattedNumber = formatNumber(maxSupply) else {return "Error occurred during processing value"}
            return "Max supply: \(formattedNumber)"
        } else {
            return "Max supply: N/A "
        }
    }
    
    var totalSupply: String {
        if let totalSupply = coin.totalSupply {
            guard let formattedNumber = formatNumber(totalSupply) else {return "Error occurred during processing value"}
            return "Total supply: \(formattedNumber)"
        } else {
            return "Total supply: N/A "
        }
    }
    
    var circulatingSupply: String {
        if let circulatingSupply = coin.circulatingSupply {
            guard let formattedNumber = formatNumber(circulatingSupply) else {return "Error occurred during processing value"}
            return "Circulating supply: \(formattedNumber)"
        } else {
            return "Circulating supply: N/A "
        }
    }
    
    var price: String {
        guard let formattedNumber = formatNumber(coin.pricingData.CAD.price) else {return "Value was not obtained"}
        return "Price: \(formattedNumber) CAD"
    }
    
    var marketCap: String {
        guard let formattedNumber = formatNumber(coin.pricingData.CAD.marketCap) else {return "Value was not obtained"}
        return "Market cap: \(formattedNumber) CAD"
    }
    
    // Creating function to make the numbers look more presentable to the User
    func formatNumber<T:Numeric> (_ number: T) -> String? {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = " " // how should thousands be separated
        formatter.decimalSeparator = "."
        formatter.minimumFractionDigits = 2 // minimum amount of numbers after decimal
        formatter.maximumFractionDigits = 2 // maximum amount of numbers after decimal
        
        if let doubleValue = number as? Double {
            return formatter.string(from:NSNumber(value:doubleValue))
        } else if let intValue = number as? Int {
            return formatter.string(from:NSNumber(value: intValue))
        } else if let decimalValue = number as? Decimal {
            return formatter.string(from: NSDecimalNumber(decimal:decimalValue))
        }
        return nil
    }
}

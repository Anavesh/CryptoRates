import Foundation

struct CoinArray: Decodable {
    let data: [Coin]
}

struct Coin: Codable {
    let id: Int
    let name: String
    let maxSupply: Int?
    let circulatingSupply: Decimal?
    let totalSupply: Decimal?
    let rank: Int
    let pricingData: PricingData
    
    var logoURL: URL? {
        return URL(string: "https://s2.coinmarketcap.com/static/img/coins/200x200/\(id).png")
    }
    
    enum CodingKeys: String, CodingKey {
        
        case id = "id"
        case name = "name"
        case maxSupply = "max_supply"
        case totalSupply = "total_supply"
        case circulatingSupply = "circulating_supply"
        case rank = "cmc_rank"
        case pricingData = "quote"
    }
}

struct PricingData: Codable {
    let CAD:CAD
}

struct CAD: Codable {
    let price: Double
    let marketCap: Double
    
    enum CodingKeys: String, CodingKey {
        case price
        case marketCap = "market_cap"
    }
}

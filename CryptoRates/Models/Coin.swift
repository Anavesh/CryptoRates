import Foundation

struct Coin: Decodable {
    let name: String
    let id: Int
    let cmcRank: Int
    let maxSupply: Int?
    let pricingData: PricingData
}

struct PricingData: Decodable {
    let price: Double
    let marketCap: Double
    
    enum CodingKeys: String, CodingKey {
        case USD // // Если наименование свойства в Swift совпадает с наименованием ключа в JSON можно просто указать case без стринг значения
        case price
        case marketCap = "market_supply" // // case соответствует наименованию свойства в swift, стринговое значение соответствует наименованию ключа в json.
    }
    
    init(price:Double, marketCap: Double) {
        self.price = price
        self.marketCap = marketCap
    }
    
    init(from decoder: any Decoder) throws { // // это инициализатор, который декодирует данные, полученные через протокол Decoder. from decoder: Decoder - входной параметр, который будет содержать данные для декодирования. Throws - означает, что инициализатор может выбросить ошибку, если декодирование не удастся
        let container = try decoder.container(keyedBy: CodingKeys.self) // // Создаем главный контейнер для извлечения значений. Данный контейнер создаем из параметра входного decoder, который содержит ключи и значения из enum CodingKeys.
        let usd = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .USD) // // Так как в JSON USD является контейнером содержащим несколько значений marktCap и price, его нужно извлечь из главного контейнера container по ключу USD исходя из ключей CodingKeys.
        price = try usd.decode(Double.self, forKey: .price) // из извлеченного контейнера usd извлекаем значение для price по ключу price
        marketCap = try usd.decode(Double.self, forKey: .marketCap) //  из извлеченного контейнера usd извлекаем значение для marketCap по ключу marketCap.
    }
}

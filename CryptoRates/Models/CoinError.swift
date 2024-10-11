import Foundation

struct CoinError: Decodable {
    let errorMessage: String
    let errorCode: Int
    
    enum CodingKeys: String, CodingKey {
        case status
        case errorMessage = "error_message"
        case errorCode = "error_code"
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let statusContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .status)
        errorMessage = try statusContainer.decode(String.self, forKey: .errorMessage)
        errorCode = try statusContainer.decode(Int.self, forKey: .errorCode)
    }
}

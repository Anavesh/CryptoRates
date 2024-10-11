import Foundation

struct HTTP {
    enum Method: String {
        case get = "GET"
    }
    
    struct Headers {
        struct Key {
            static let apiKey = "X-CMC_PRO_API_KEY"
        }
    }
}

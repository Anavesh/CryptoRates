import Foundation

class CoinService {
    
    static func fetchCoins(with endpoint: Endpoint, completion: @escaping (Result<[Coin], CoinServiceError>) -> Void) {
        guard let request = endpoint.request else { return }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            // Обработка ошибки сети
            if let error = error {
                completion(.failure(.unknown("\(error.localizedDescription)")))
                return
            }
            
            // Проверка статуса ответа сервера
            if let response = response as? HTTPURLResponse, response.statusCode != 200 {
                do {
                    let coinError = try JSONDecoder().decode(CoinError.self, from: data ?? Data())
                    completion(.failure(.serverError(coinError)))
                } catch let error {
                    completion(.failure(.unknown()))
                    print("Decoding server error: \(error.localizedDescription)")
                }
                return
            }
            
            // Проверка наличия данных
            guard let data = data else {
                completion(.failure(.unknown("No data received")))
                return
            }
            
            // Преобразование данных в строку для отладки
            if let jsonString = String(data: data, encoding: .utf8) {
                print("Received JSON: \(jsonString)")
                
                // Проверка наличия ключа "data"
                if jsonString.contains("\"data\"") {
                    print("Data key found in the JSON")
                    
                    do {
                        // Декодирование JSON в CoinArray
                        let decodedResponse = try JSONDecoder().decode(CoinArray.self, from: data)
                        completion(.success(decodedResponse.data))
                    } catch {
                        completion(.failure(.decodingError("Error decoding JSON: \(error.localizedDescription)")))
                        print("Error decoding JSON: \(error)")
                    }
                } else {
                    print("Data key missing in the JSON")
                    completion(.failure(.unknown("Data key missing in the JSON")))
                }
            } else {
                print("Failed to convert data to string.")
                completion(.failure(.unknown("Failed to convert data to string.")))
            }
        }.resume()
    }
}

enum CoinServiceError: Error {
    case serverError(CoinError)
    case unknown(String = "An unknown error occurred")
    case decodingError(String = "Error parsing server response")
}

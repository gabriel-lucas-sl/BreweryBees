import Foundation

public enum HTTP {
    case get
    case post
    
    public func request(url: URL?,
                        header: [String: String] = ["Content-Type": "application/json"],
                        body: [String: Any] = [:],
                        completion: @escaping (Data?, HTTPURLResponse?, String?) -> Void) {
        
        guard let url = url else {
            completion(nil, nil, "Erou! URL Invalida")
            return
        }
        
        switch self {
        case .get:
            
            URLSession.shared.dataTask(with: url) { data, response, error in
                completion(data, response as? HTTPURLResponse, error?.localizedDescription)
            }.resume()
            
        case .post:
            
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = "POST"
            urlRequest.allHTTPHeaderFields = header
            let data = try? JSONSerialization.data(withJSONObject: body, options: .prettyPrinted)
            urlRequest.httpBody = data
            
            URLSession.shared.uploadTask(with: urlRequest, from: data) { data, response, error in
                completion(data, response as? HTTPURLResponse, error?.localizedDescription)
            }.resume()
            
        }
            
    }
}

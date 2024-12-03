//
//  Network.swift
//  TestTest
//
//  Created by MacLex on 02.12.2024.
//

import Foundation

class Network: NetworkRequestProtocol {
    static var shared: Network = .init()
    
    private init() { }
    
    func getPhotos(search: String, page: Int = 1, language: String = "ru", completion: @escaping (Result<UnsplashData, ErrorNetwork>) -> Void) {
        
        let encode = search.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        
        let params = ["page": page, "query": encode, "lang": language, "per_page": 20] as [String : Any]
        
        let headers = ["Authorization": "Client-ID W45Mr4HRA8AO7FfvNpGLpp3UXQg3Ye84X3iY-p70qzI",
                       "Content-Type": "application/json",
                       "Accept-Version": "v1"]
        
        guard let url = setupURL(parameters: params) else { return completion(.failure(.notURL))}
        
        getRequest(url: url, headers: headers, type: UnsplashData.self, completion: completion)
    }
}

protocol NetworkRequestProtocol { }

extension NetworkRequestProtocol {
    func setupURL(parameters: [String : Any]) -> URL? {
        guard var components = URLComponents.init(string: "https://api.unsplash.com") else { return nil }
        
        components.path = "/search/photos"
        
        components.queryItems = parameters.compactMap({ key, value in
            return .init(name: key, value: "\(value)")
        })
        
        return components.url
    }
    
    func getRequest<T>(url: URL,
                       httpMethod: String! = "GET",
                       headers: [String: String]! = [:],
                       body: Data? = nil,
                       type: T.Type,
                       completion: @escaping (Result<T, ErrorNetwork>) -> ())
    where T: Decodable {
        
        var request = URLRequest(url: url, timeoutInterval: 15)
        
        request.httpMethod = httpMethod
        
        for (key,value) in headers {
            request.addValue(value, forHTTPHeaderField: key)
        }
        
        request.httpBody = body
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            guard let response = response as? HTTPURLResponse, let data = data else {
                
                if let error = error {
                    return completion(.failure(.default(error)))
                }
                
                return completion(.failure(.errorString("Not infomation error")))
            }
            
            let code = response.statusCode
            
            print(type.self, "status code:", code)
            
            guard let value = try? JSONDecoder().decode(T.self, from: data) else {
                return completion(.failure(.errorString("Failed to convert model data")))
            }
            
            completion(.success(value))
        }
        
        task.resume()
    }
}


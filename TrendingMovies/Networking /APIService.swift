//
//  APIService.swift
//  TrendingMovies
//
//  Created by Magnus Holm on 05/08/2019.
//  Copyright © 2019 Magnus Holm. All rights reserved.
//

import Foundation

protocol APIServiceType {
//    func request(endpoint: Endpoint, completion: @escaping (Result<[String: Any], NetworkError>) -> ())
//    func buildRequest(for endpoint: Endpoint) -> URLRequest?
    
    func request<T: Decodable>(_ type: T.Type, endpoint: Endpoint, completion: @escaping (Result<T, NetworkError>) -> Void)
}

final class APIService: APIServiceType {
    
    // MARK: Private properties
    
    private let session: URLSession!
    private let transformer: Transformer!
    
    // MARK: - Init
    
    init(session: URLSession = URLSession(configuration: .default), transformer: Transformer = JSONTransformer()) {
        self.session = session
        self.transformer = transformer
    }
    
    // MARK: - Public methods
    
    func request<T: Decodable>(_ type: T.Type, endpoint: Endpoint, completion: @escaping (Result<T, NetworkError>) -> Void) {
        
        guard var urlRequest = buildRequest(for: endpoint) else { return }
        urlRequest.httpMethod = endpoint.method
        
        let task = session.dataTask(with: urlRequest) { (result) in
            switch result {
            case .success(let response, let data):
                guard let statusCode = (response as? HTTPURLResponse)?.statusCode, 200..<299 ~= statusCode else {
                    completion(.failure(.invalidStatusCode))
                    return
                }
                do {
                    let values = try self.transformer.decode(T.self, from: data)
                        completion(.success(values))
                } catch {
                    completion(.failure(.decodeError))
                }
            case .failure(_):
                completion(.failure(.apiError))
            }
        }
        task.resume()
    }
    
    private func buildRequest(for endpoint: Endpoint) -> URLRequest? {
        var components = URLComponents()
        components.scheme = endpoint.scheme
        components.host = endpoint.host
        components.path = endpoint.path
        components.queryItems = endpoint.parameters
        guard let url = components.url else { return nil }
        return URLRequest(url: url)
    }
}

enum NetworkError: String, Error {
    case invalidStatusCode = "bad status code"
    case decodeError = "decode error"
    case apiError = "api error"
}


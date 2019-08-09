//
//  APIService.swift
//  TrendingMovies
//
//  Created by Magnus Holm on 05/08/2019.
//  Copyright © 2019 Magnus Holm. All rights reserved.
//

import Foundation

typealias JSON = [String: Any]

protocol APIServiceType {
    
    /// Sends an API request with URLSession
    ///
    /// - Parameters:
    ///   - endpoint: Endoint with info about request sich as method and parameters
    ///   - completion: Result type, can either complete with JSON or Error
    func request(endpoint: Endpoint, completion: @escaping (Result<JSON, NetworkError>) -> Void)
}

final class APIService: APIServiceType {
    
    // MARK: Private properties
    
    private let session: URLSession!
    
    // MARK: - Init
    
    init(session: URLSession = URLSession(configuration: .default)) {
        self.session = session
    }
    
    // MARK: - Public methods
    
    func request(endpoint: Endpoint, completion: @escaping (Result<JSON, NetworkError>) -> Void) {
        
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
                    guard let values = try JSONSerialization.jsonObject(with: data, options: []) as? JSON else { return }
                    completion(.success(values))
                } catch {
                    completion(.failure(.decodeError))
                }
            case .failure(_):
                completion(.failure(.networkError))
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
    case invalidStatusCode = "Bad status code"
    case decodeError = "Decode error"
    case networkError = "Network error"
}


//
//  NetworkService.swift
//  20230327-KostiantynNevinchanyi-NYCSchools
//
//  Created by Kostiantyn Nevinchanyi on 3/27/23.
//

import Foundation

// MARK: Would be great to provide an interface for the `NetworkService` class
final class NetworkService {
    
    /** The method might be used for any request in the app, because it uses generic response */
    @discardableResult
    public func request<T>(
        endpoint: EndpointInterface,
        timeoutInterval: Double = 10.0
    ) async throws -> T where T: Decodable {
        
        guard let url = endpoint.url else {
            throw NetworkError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let response = response as? HTTPURLResponse else {
                throw NetworkError.noResponse
            }
                      
            try await handleStatusCode(response.statusCode)
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let decodedData = try decoder.decode(T.self, from: data)
                return decodedData
            } catch {
                throw NetworkError.decoding(data: String(decoding: data, as: UTF8.self))
            }

        } catch {
            throw NetworkError.network(error: error)
        }
    }
    
    private func handleStatusCode(_ statusCode: Int) async throws {
        switch statusCode {
        case 200...299:
            return
        default:
            throw NetworkError.unexpectedStatusCode(code: statusCode)
        }
    }
}

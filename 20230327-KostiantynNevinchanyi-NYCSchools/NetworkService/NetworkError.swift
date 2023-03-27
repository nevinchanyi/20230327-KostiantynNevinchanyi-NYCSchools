//
//  NetworkError.swift
//  20230327-KostiantynNevinchanyi-NYCSchools
//
//  Created by Kostiantyn Nevinchanyi on 3/27/23.
//

import Foundation


public enum NetworkError: Error {
    case invalidURL
    case network(error: Error)
    case unexpectedStatusCode(code: Int)
    case noResponse
    case decoding(data: String)
    
    var description: String {
        switch self {
        case .invalidURL:
            return "Invelid url."
        case .network(let error):
            return "Network error: \(String(describing: error))."
        case .unexpectedStatusCode(let code):
            return "Network error: status code - \(code)."
        case .noResponse:
            return "No response."
        case .decoding:
            return "Decoding error."
        }
    }
}

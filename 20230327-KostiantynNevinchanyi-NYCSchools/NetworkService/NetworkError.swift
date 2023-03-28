//
//  NetworkError.swift
//  20230327-KostiantynNevinchanyi-NYCSchools
//
//  Created by Kostiantyn Nevinchanyi on 3/27/23.
//

import SwiftUI

/**
 `NetworkError` represents custom errors, that we want to show them users.
 */
 enum NetworkError: Error {
    case invalidURL
    case network(error: Error)
    case unexpectedStatusCode(code: Int)
    case noResponse
    case decoding(data: String)
}

extension NetworkError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return NSLocalizedString("Invelid url.", comment: "")
        case .network(let error):
            return NSLocalizedString("Network error.\n\(error.localizedDescription)", comment: "")
        case .unexpectedStatusCode(let code):
            return NSLocalizedString("Unexpected status code - \(code)", comment: "")
        case .noResponse:
            return NSLocalizedString("No response.", comment: "")
        case .decoding:
            return NSLocalizedString("Decoding error.", comment: "")
        }
    }
}

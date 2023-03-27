//
//  EndpointInterface.swift
//  20230327-KostiantynNevinchanyi-NYCSchools
//
//  Created by Kostiantyn Nevinchanyi on 3/27/23.
//

import Foundation

protocol EndpointInterface {
    var url: URL? { get }
}

enum Endpoint: EndpointInterface {
    case schools
    case sats
    
    var baseUrl: String { "https://data.cityofnewyork.us" }
    var path: String {
        switch self {
        case .schools: return "/resource/s3k6-pzi2.json"
        case .sats: return "/resource/f9bf-2cp4.json"
        }
    }
    var url: URL? {
        URL(string: baseUrl + path)
    }
}

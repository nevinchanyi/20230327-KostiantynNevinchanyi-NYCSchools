//
//  SchoolModel.swift
//  20230327-KostiantynNevinchanyi-NYCSchools
//
//  Created by Kostiantyn Nevinchanyi on 3/27/23.
//

import Foundation
import CoreLocation


struct SchoolModel: Decodable {
    let dbn: String
    let schoolName: String
    let overviewParagraph: String?
    let academicOpportunities: String?
    let phoneNumber: String?
    let schoolEmail: String?
    let website: String?
    let totalStudents: String?
    let latitude: String?
    let longitude: String?
    
    var sat: SatModel?
}

extension SchoolModel: Identifiable {
    var id: String { dbn }
    var location: CLLocationCoordinate2D? {
        guard let latitude = Double(latitude ?? ""), let longitude = Double(longitude ?? "") else {
            return nil
        }
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    var emailURL: URL? {
        guard let schoolEmail = schoolEmail else { return nil }
        return URL(string: "mailto:" + schoolEmail)
    }
}

extension SchoolModel {
    
    mutating func set(sat: SatModel) {
        self.sat = sat
    }
}

//
//  SchoolDetailViewModel.swift
//  20230327-KostiantynNevinchanyi-NYCSchools
//
//  Created by Kostiantyn Nevinchanyi on 3/27/23.
//

import Foundation
import MapKit

final class SchoolDetailViewModel: ObservableObject {
    
    var school: SchoolModel
    
    init(school: SchoolModel) {
        self.school = school
    }
    
    func openMapApp() {
        guard let coordinates = school.location else { return }
        let regionDistance: CLLocationDistance = 10000
        let regionSpan = MKCoordinateRegion(center: coordinates, latitudinalMeters: regionDistance, longitudinalMeters: regionDistance)
        let options = [
            MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
            MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)
        ]
        let placemark = MKPlacemark(coordinate: coordinates)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = school.schoolName
        mapItem.openInMaps(launchOptions: options)
    }
    
    func openEmailApp(with url: URL) {
        UIApplication.shared.open(url)
    }
}

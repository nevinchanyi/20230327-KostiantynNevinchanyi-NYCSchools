//
//  Mocks.swift
//  20230327-KostiantynNevinchanyi-NYCSchools
//
//  Created by Kostiantyn Nevinchanyi on 3/27/23.
//

import Foundation


struct Mock {
    
    static let dbn = UUID().uuidString
    
    static let school = SchoolModel(
        dbn: dbn,
        schoolName: "School name",
        overviewParagraph: "Overview Paragraph",
        academicOpportunities: "Academic Opportunities",
        phoneNumber: "6172011111",
        schoolEmail: "support@school.com",
        website: "https://school.com",
        totalStudents: "900",
        latitude: "40.73653",
        longitude: "-73.9927")
    
    static let sat = SatModel(
        dbn: dbn,
        numOfSatTestTakers: "123",
        satCriticalReadingAvgScore: "600",
        satMathAvgScore: "159",
        satWritingAvgScore: "512")
}

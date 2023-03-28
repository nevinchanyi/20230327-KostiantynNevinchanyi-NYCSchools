//
//  _0230327_KostiantynNevinchanyi_NYCSchoolsTests.swift
//  20230327-KostiantynNevinchanyi-NYCSchoolsTests
//
//  Created by Kostiantyn Nevinchanyi on 3/27/23.
//

import XCTest
@testable import _0230327_KostiantynNevinchanyi_NYCSchools

final class _0230327_KostiantynNevinchanyi_NYCSchoolsTests: XCTestCase {
    
    var endpoint: Endpoint?
    
    override func setUpWithError() throws {
        
    }

    override func tearDownWithError() throws {
        endpoint = nil
    }
    
    // MARK: Ideally need to test every case, but I haven't enough time
    func testEndpointSchools() throws {
        endpoint = Endpoint.schools
        
        let endpoint2 = Endpoint.schools
        
        let url = URL(string: endpoint2.baseUrl + endpoint2.path)
        XCTAssertEqual(endpoint?.url, endpoint2.url)
    }
    
    // MARK: Would be great to mock the response with interface for the `NetworkService` and test with every available endpoint
    func testNetworkServiceRequest() throws {}
}

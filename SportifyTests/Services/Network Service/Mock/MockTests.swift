//
//  MockTests.swift
//  SportifyTests
//
//  Created by AhmedAbuFoda on 26/05/2024.
//

import XCTest

final class MockTests: XCTestCase {
    var mockObj : MockNetworkService!
    override func setUpWithError() throws {
        mockObj = MockNetworkService(shouldReturnError: false)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testMockFatechLeaguesData(){
        mockObj.fetchLeaguesFromJSON{
            result, error in
            if error != nil {
                XCTFail()
            }else{
                XCTAssertNotNil(result)
            }
        }
    }
    
    func testMockFatechFixtureData(){
        mockObj.fetchFixtureFromJSON{
            result, error in
            if error != nil {
                XCTFail()
            }else{
                XCTAssertNotNil(result)
            }
        }
    }
    
    func testMockFatechTeamData(){
        mockObj.fetchTeamFromJSON{
            result, error in
            if error != nil {
                XCTFail()
            }else{
                XCTAssertNotNil(result)
            }
        }
    }
    
    
}

//
//  NetworkExpectationsTest.swift
//  
//
//  Created by AhmedAbuFoda on 27/05/2024.
//

import XCTest
@testable import Sportify

final class NetworkExpectationsTest: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testFetchLeaguesFromJson(){
        let expextation = expectation(description: "wait for API")
        
        NetworkManager.shared.fetchLeagues(sportType: "football") { result in
            switch result {
            case .success(let response):
                XCTAssertTrue((response.result?.count) != nil)
            case .failure(let error):
                XCTFail("Failed to fetch Leagues with error: \(error.localizedDescription)")
            }
            expextation.fulfill()
        }
        waitForExpectations(timeout: 15)
    }
    
    func testFetchFixturesFromJson(){
        let expextation = expectation(description: "waiting API")
        
        NetworkManager.shared.fetchFixtures(sportType: "football", leagueId: "141", from: "2024-05-26", to:"2024-09-26" ) { result in
            switch result {
            case .success(let response):
                XCTAssertTrue((response.result?.count) != nil)
            case .failure(let error):
                XCTFail("Failed to fetch fixtures with error: \(error.localizedDescription)")
            }
            expextation.fulfill()
        }
        
        waitForExpectations(timeout: 15)
    }
    
    
    func testFetchTeamsFromJson(){
        let expextation = expectation(description: "waiting API")
        
        NetworkManager.shared.fetchTeams(sportType: "football", leagueId: "141") { result in
            switch result {
            case .success(let response):
                XCTAssertTrue((response.result?.count) != nil)
            case .failure(let error):
                XCTFail("Failed to fetch team with error: \(error.localizedDescription)")
            }
            expextation.fulfill()
        }
        
        waitForExpectations(timeout: 15)
    }

}

//
//  LeagueViewModelTest.swift
//  
//
//  Created by AhmedAbuFoda on 27/05/2024.
//

import XCTest
@testable import Sportify

final class LeagueViewModelTest: XCTestCase {
    var viewModel: LeagueViewModel!
        
    override func setUp() {
        super.setUp()
        viewModel = LeagueViewModel()
    }
        
    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }
        
    func testGetLeagues() {
        let expectation = self.expectation(description: "bindResultToLeaguesViewController")
        viewModel.bindResultToViewController = {
            expectation.fulfill()
        }
        viewModel.getLeagues(sportType: "football")
        
        waitForExpectations(timeout: 15) { _ in
            XCTAssertNotNil(self.viewModel.league)
            let count = self.viewModel.league?.count
            XCTAssertGreaterThan(count!, 0)
            XCTAssertEqual(count, 865)
            XCTAssertEqual(self.viewModel.league?.first?.league_name, "UEFA Europa League")
        }
    }
}

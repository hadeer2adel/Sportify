//
//  CachingManager.swift
//  SportifyTests
//
//  Created by Hadeer Adel Ahmed on 27/05/2024.
//

import XCTest
import UIKit
@testable import Sportify

final class CachingManagerTests: XCTestCase {

    private var appDelegate: AppDelegate?
    private var service: CachingProtocol?
    private var league: FavLeagues?

    override func setUpWithError() throws {
        appDelegate = AppDelegate()
        service = CachingManager()
        league = FavLeagues(id: "123", name: "Football League", logo: "league_logo.png", sport: "Football")
        
        service!.deleteAllFavourites(appDelegate: appDelegate!)
    }

    override func tearDownWithError() throws {
        appDelegate = nil
        service = nil
        league = nil
    }
    
    func testInsertToFavourite() {
        // When
        service!.insertToFavourite(appDelegate: appDelegate!, league: league!)
        
        //Then
        let leagues = service!.getFromFavourite(appDelegate: appDelegate!)
        XCTAssertNotNil(leagues)
        
        let leagueId = leagues?.first.map{ $0.id }
        XCTAssertEqual(leagueId!, league!.id!)
    }
    
    func testGetFromFavourite() {
        // Given
        let league2 = FavLeagues(id: "456", name: "Tennis League", logo: "league2_logo.png", sport: "Tennis")
        service!.insertToFavourite(appDelegate: appDelegate!, league: league!)
        service!.insertToFavourite(appDelegate: appDelegate!, league: league2)

        // When
        let leagues = service!.getFromFavourite(appDelegate: appDelegate!)

        // Then
        XCTAssertNotNil(leagues)
        XCTAssertEqual(leagues?.count, 2)
        XCTAssertEqual(leagues?[0].id, "123")
        XCTAssertEqual(leagues?[1].id, "456")
    }
    
    func testDeleteFromFavourite() {
        // Given
        service!.insertToFavourite(appDelegate: appDelegate!, league: league!)

        // When
        service!.deleteFromFavourite(appDelegate: appDelegate!, leagueID: "123")
        
        // Then
        let leagues = service!.getFromFavourite(appDelegate: appDelegate!)
        XCTAssertNotNil(leagues)
        XCTAssertNil(leagues?.first)
    }

    func testIsSportFavorited() {
        // Given
        service!.insertToFavourite(appDelegate: appDelegate!, league: league!)

        // When
        let isFavorited = service!.isSportFavorited(appDelegate: appDelegate!, leagueID: "123")
        let isNotFavorited = service!.isSportFavorited(appDelegate: appDelegate!, leagueID: "456")

        // Then
        XCTAssertTrue(isFavorited)
        XCTAssertFalse(isNotFavorited)
    }
}

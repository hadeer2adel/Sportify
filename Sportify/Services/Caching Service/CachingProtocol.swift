//
//  CachingProtocol.swift
//  Sportify
//
//  Created by Hadeer Adel Ahmed on 22/05/2024.
//

import Foundation

protocol CachingProtocol {
    func insertToFavourite(appDelegate: AppDelegate, league: FavLeagues)
    func getFromFavourite(appDelegate: AppDelegate) -> [FavLeagues]?
    func deleteFromFavourite(appDelegate: AppDelegate, leagueID: String)
    func isSportFavorited(appDelegate: AppDelegate, leagueID: String) -> Bool
    func deleteAllFavourites(appDelegate: AppDelegate)
}

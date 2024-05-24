//
//  CachingProtocol.swift
//  Sportify
//
//  Created by Hadeer Adel Ahmed on 22/05/2024.
//

import Foundation

protocol CachingProtocol {
    func insertToFavourite(league: FavLeagues)
    func getFromFavourite() -> [FavLeagues]?
    func deleteFromFavourite(leagueID: String)
    func isSportFavorited(favLeague : FavLeagues) -> Bool 
}

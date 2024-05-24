//
//  FavoriteViewModel.swift
//  Sportify
//
//  Created by AhmedAbuFoda on 22/05/2024.
//

import Foundation
class FavouriteViewModel{
    
    private var cachingManager: CachingProtocol
    init(cachingManager: CachingProtocol) {
        self.cachingManager = cachingManager
    }
    
    func getFromFavourite() -> [FavLeagues]? {
        return cachingManager.getFromFavourite()
    }
    
    func deleteFromFavourite(leagueID: String) {
        cachingManager.deleteFromFavourite(leagueID: leagueID)
    }
}

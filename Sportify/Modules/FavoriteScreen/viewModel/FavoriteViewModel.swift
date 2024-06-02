//
//  FavoriteViewModel.swift
//  Sportify
//
//  Created by AhmedAbuFoda on 22/05/2024.
//

import Foundation
class FavouriteViewModel{
    
    private var cachingManager: CachingProtocol
    private var appDelegate: AppDelegate
    init(cachingManager: CachingProtocol, appDelegate: AppDelegate) {
        self.cachingManager = cachingManager
        self.appDelegate = appDelegate
    }
    
    func getFromFavourite() -> [FavLeagues]? {
        return cachingManager.getFromFavourite(appDelegate: appDelegate)
    }
    
    func deleteFromFavourite(leagueID: String) {
        cachingManager.deleteFromFavourite(appDelegate: appDelegate, leagueID: leagueID)
    }
}

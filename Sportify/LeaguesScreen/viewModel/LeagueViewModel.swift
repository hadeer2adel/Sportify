//
//  LeagueViewModel.swift
//  Sportify
//
//  Created by AhmedAbuFoda on 20/05/2024.
//

import Foundation
class LeagueViewModel{
    var bindResultToViewController : (()->()) = {}
    var league : [League]?{
        didSet{
            bindResultToViewController()
        }
    }
    
    func getLeagues(sportType: String){
        NetworkManager.shared.fetchLeagues(sportType: sportType) { [weak self] result in
            switch result {
            case .success(let leagueResponse):
                self?.league = leagueResponse.result
            case .failure(let error):
                print("Error fetching leagues: \(error.localizedDescription)")
            }
        }
    }
}

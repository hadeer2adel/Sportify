//
//  LeagueDetails.swift
//  Sportify
//
//  Created by Hadeer Adel Ahmed on 20/05/2024.
//

import Foundation

class LeagueDetailsViewModel{
    
    var bindUpComingEventsToViewController : (()->()) = {}
    var upComingEvents : [Fixture]?{
        didSet{
            bindUpComingEventsToViewController()
        }
    }
    
    var bindLatestResultsToViewController : (()->()) = {}
    var latestResults : [Fixture]?{
        didSet{
            bindLatestResultsToViewController()
        }
    }
    
    var bindTeamsToViewController : (()->()) = {}
    var teams : [Team]?{
        didSet{
            bindTeamsToViewController()
        }
    }
    
    func getUpComingEvents(sportType: String, leagueId: String){
        let dateConverter = DateConverter()
        let from = dateConverter.getCurrentDate()
        let to = dateConverter.getOtherDate(lastYear: false)
        
        NetworkManager.shared.fetchFixtures(sportType: sportType, leagueId: leagueId, from: from, to: to) { [weak self] result in
            switch result {
            case .success(let response):
                self?.upComingEvents = response.result
            case .failure(let error):
                print("Error fetching upComingEvents: \(error.localizedDescription)")
            }
        }
    }
    
    func getLatestResults(sportType: String, leagueId: String){
        let dateConverter = DateConverter()
        let from = dateConverter.getOtherDate(lastYear: true)
        let to = dateConverter.getCurrentDate()
        
        NetworkManager.shared.fetchFixtures(sportType: sportType, leagueId: leagueId, from: from, to: to) { [weak self] result in
            switch result {
            case .success(let response):
                self?.latestResults = response.result
            case .failure(let error):
                print("Error fetching latestResults: \(error.localizedDescription)")
            }
        }
    }

    func getTeams(sportType: String, leagueId: String){
        
        NetworkManager.shared.fetchTeams(sportType: sportType, leagueId: leagueId) { [weak self] result in
            switch result {
            case .success(let response):
                self?.teams = response.result
            case .failure(let error):
                print("Error fetching teams: \(error.localizedDescription)")
            }
        }
    }

}

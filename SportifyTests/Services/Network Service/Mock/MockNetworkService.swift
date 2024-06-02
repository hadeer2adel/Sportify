//
//  MockNetworkService.swift
//  SportifyTests
//
//  Created by AhmedAbuFoda on 26/05/2024.
//

import Foundation
@testable import Sportify

class MockNetworkService{
    var leagueResult = LeagueResponse(success: 1, result: [])
    var fixtureResult = FixtureResponse(result: [])
    var teamResult = TeamResponse(result: [])
    var shouldReturnError: Bool
    
    init(shouldReturnError: Bool) {
        self.shouldReturnError = shouldReturnError
    }
    
    let fakeLeagueJsonObj: [String: Any] = 
    [
        "result": [
            "league_key": "28",
            "league_name": "World Cup",
            "country_key": "8",
            "country_name": "Worldcup",
            "league_logo": "https://apiv2.allsportsapi.com/logo/logo_leagues/28_world-cup.png",
            "country_logo": "https://apiv2.allsportsapi.com/logo/logo_country/8_worldcup.png"
        ]
    ]
    
    let fakeFixtureJsonObj :[String:Any] =
    [
        "result": [
            "event_date": "2024-06-01",
            "event_time": "21:00",
            "event_home_team": "Dortmund",
            "event_away_team": "Real Madrid",
            "event_final_result": "-",
            "home_team_logo": "https://apiv2.allsportsapi.com/logo/92_borussia-dortmund.jpg",
            "away_team_logo": "https://apiv2.allsportsapi.com/logo/76_real-madrid.jpg",
        ]
    ]
    
    let fakeTeamJsonObj :[String : Any] =
    [
        "result": [
            "team_name": "Al Ahly",
            "team_logo": "https://apiv2.allsportsapi.com/logo/585_al-ahly.jpg",
            "players": [
                "player_image": "https://apiv2.allsportsapi.com/logo/players/5634_a-maaloul.jpg",
                "player_name": "A. Maâloul",
                "player_number": "21",
                "player_age": "34",
                ],
            "coaches": [
                "coach_name": "Marcel Koller",
            ]
        ]
    ]
    
    
}

extension MockNetworkService{
    enum responesWithError : Error{
        case responesError
    }

    func fetchLeaguesFromJSON(compiltionHandler : @escaping (LeagueResponse? , Error?)
                   -> Void){
        do{
            let data = try JSONSerialization.data(withJSONObject: fakeLeagueJsonObj)
            leagueResult = try JSONDecoder().decode(LeagueResponse.self, from: data)
        } catch {
            
            print(error.localizedDescription)
        }
        
        if shouldReturnError{
            compiltionHandler(nil , responesWithError.responesError)
            
        }else{
            compiltionHandler(leagueResult, nil)
        }
    }
}

extension MockNetworkService{
    func fetchFixtureFromJSON(compiltionHandler : @escaping (FixtureResponse? , Error?)
                   -> Void){
        do{
            let data = try JSONSerialization.data(withJSONObject: fakeFixtureJsonObj)
            fixtureResult = try JSONDecoder().decode(FixtureResponse.self, from: data)
        } catch {
            
            print(error.localizedDescription)
        }
        
        if shouldReturnError{
            compiltionHandler(nil , responesWithError.responesError)
            
        }else{
            compiltionHandler(fixtureResult, nil)
        }
    }
}

extension MockNetworkService{
    func fetchTeamFromJSON(compiltionHandler : @escaping (TeamResponse? , Error?)
                   -> Void){
        do{
            let data = try JSONSerialization.data(withJSONObject: fakeTeamJsonObj)
            teamResult = try JSONDecoder().decode(TeamResponse.self, from: data)
        } catch {
            
            print(error.localizedDescription)
        }
        
        if shouldReturnError{
            compiltionHandler(nil , responesWithError.responesError)
            
        }else{
            compiltionHandler(teamResult, nil)
        }
    }
}

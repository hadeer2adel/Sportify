//
//  EventResponse.swift
//  Sportify
//
//  Created by Hadeer Adel Ahmed on 20/05/2024.
//

import Foundation

struct Fixture : Codable{
    let event_date: String?
    let event_time: String?
    let event_final_result: String?
    
    // football & basketball teams name
    let event_home_team: String?
    let event_away_team: String?
    
    // football & teams logo
    let home_team_logo: String?
    let away_team_logo: String?
    
    // basketball teams logo
    let event_home_team_logo: String?
    let event_away_team_logo: String?
    
    // tennis teams name
    let event_first_player: String?
    let event_second_player: String?
    // tennis teams logo
    let event_first_player_logo: String?
    let event_second_player_logo: String?
    
    // cricket date
    let event_date_start: String?
    // cricket score
    let event_home_final_result: String?
    let event_away_final_result: String?

}

struct FixtureResponse: Codable {
    let result:[Fixture]?
}

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
    let event_home_team: String?
    let event_away_team: String?
    let event_final_result: String?
    let home_team_logo: String?
    let away_team_logo: String?
}

struct FixtureResponse: Codable {
    let result:[Fixture]?
}

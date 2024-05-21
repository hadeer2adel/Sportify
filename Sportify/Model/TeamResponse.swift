//
//  TeamResponse.swift
//  Sportify
//
//  Created by Hadeer Adel Ahmed on 20/05/2024.
//

import Foundation

struct Coach: Codable{
    let coach_name: String?
}

struct Player: Codable{
    let player_image: String?
    let player_name: String?
    let player_number: String?
    let player_age: String?
}

struct Team: Codable{
    let team_name: String?
    let team_logo: String?
    let players: [Player]?
    let coaches: [Coach]?
}

struct TeamResponse: Codable {
    let result:[Team]?
}

//
//  LeagueResponse.swift
//  Sportify
//
//  Created by AhmedAbuFoda on 20/05/2024.
//

import Foundation

struct League : Codable{
    let league_key: Int?
    let league_name: String?
    let country_key: Int?
    let country_name: String?
    let league_logo: String?
    let country_logo: String?
}


struct LeagueResponse: Codable {
    let success:Int?
    let result:[League]?
}

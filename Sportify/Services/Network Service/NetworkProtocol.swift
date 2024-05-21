//
//  NetworkProtocol.swift
//  Sportify
//
//  Created by AhmedAbuFoda on 20/05/2024.
//

import Foundation
protocol NetworkProtocol {
    func fetchLeagues(sportType:String,completion: @escaping(Result<LeagueResponse,Error>) -> Void)
    
    func fetchFixtures(sportType: String, leagueId: String, from: String, to: String, completion: @escaping(Result<FixtureResponse, Error>) -> Void)
    
    func fetchTeams(sportType: String, leagueId: String, completion: @escaping(Result<TeamResponse, Error>) -> Void) 
}

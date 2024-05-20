//
//  NetworkProtocol.swift
//  Sportify
//
//  Created by AhmedAbuFoda on 20/05/2024.
//

import Foundation
protocol NetworkProtocol {
    func fetchLeagues(sportType:String,completion: @escaping(Result<LeagueResponse,Error>) -> Void)
}

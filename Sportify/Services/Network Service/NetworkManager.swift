//
//  NetworkManager.swift
//  Sportify
//
//  Created by AhmedAbuFoda on 20/05/2024.
//

import Foundation
import Alamofire


class NetworkManager: NetworkProtocol {
    
    let API_KEY = "46498dbb3694c6fba354a474bfedd0f0af2806e9f622550c701ebe18fce9e424"
    
    static let shared : NetworkManager = NetworkManager()
    
    private init() {
        
    }
    
    
    func fetchLeagues(sportType:String,completion: @escaping(Result<LeagueResponse,Error>) -> Void) {
        let url = URL(string: "https://apiv2.allsportsapi.com/\(sportType)/?met=Leagues&APIkey=\(API_KEY)")
        AF.request(url!).validate().response{
            response in
            switch response.result{
            case .success(let data):
                do{
                    let jsonData = try JSONDecoder().decode(LeagueResponse.self, from: data!)
                    completion(.success(jsonData))
                } catch {
                    print(error.localizedDescription)
                    completion(.failure(error))
                }
            case .failure(let error):
                print(error.localizedDescription)
                completion(.failure(error))
            }
            
        }
    }
    
    func fetchFixtures(sportType: String, leagueId: String, from: String, to: String, completion: @escaping(Result<FixtureResponse, Error>) -> Void) {
         let apiRequest = "https://apiv2.allsportsapi.com/\(sportType)/?met=Fixtures&leagueId=\(leagueId)&from=\(from)&to=\(to)&APIkey=\(API_KEY)"
        
        let url = URL(string: apiRequest)
        
        AF.request(url!).validate().response{
            response in
            switch response.result{
            case .success(let data):
                do{
                    let jsonData = try JSONDecoder().decode(FixtureResponse.self, from: data!)
                    completion(.success(jsonData))
                } catch {
                    print(error.localizedDescription)
                    completion(.failure(error))
                }
            case .failure(let error):
                print(error.localizedDescription)
                completion(.failure(error))
            }
            
        }
    }
    
    func fetchTeams(sportType: String, leagueId: String, completion: @escaping(Result<TeamResponse, Error>) -> Void) {
        let apiRequest = "https://apiv2.allsportsapi.com/\(sportType)/?met=Teams&leagueId=\(leagueId)&APIkey=\(API_KEY)"
        
        let url = URL(string: apiRequest)
        
        AF.request(url!).validate().response{
            response in
            switch response.result{
            case .success(let data):
                do{
                    let jsonData = try JSONDecoder().decode(TeamResponse.self, from: data!)
                    completion(.success(jsonData))
                } catch {
                    print(error.localizedDescription)
                    completion(.failure(error))
                }
            case .failure(let error):
                print(error.localizedDescription)
                completion(.failure(error))
            }
            
        }
    }
}

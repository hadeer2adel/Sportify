//
//  CachingManager.swift
//  Sportify
//
//  Created by Hadeer Adel Ahmed on 22/05/2024.
//

import Foundation
import CoreData
import UIKit

class CachingManager: CachingProtocol{
    
    func insertToFavourite(league: FavLeagues) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "FavLeague", in: context)
        let leagues = NSManagedObject(entity: entity!, insertInto: context)
        
        leagues.setValue(league.id, forKey: "id")
        leagues.setValue(league.name, forKey: "name")
        leagues.setValue(league.logo, forKey: "logo")
        leagues.setValue(league.sport, forKey: "sport")
        
        do{
            try context.save()
            print("Save Done")
        } catch let error{
            print(error.localizedDescription)
        }
    }
    
    func getFromFavourite() -> [FavLeagues]? {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        var leagues : [FavLeagues] = []
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "FavLeague")
        
        do {
            print("doo")
            let results = try context.fetch(fetchRequest)
            for result in results {
                let id = result.value(forKey: "id") as? String
                let name = result.value(forKey: "name") as? String
                let logo = result.value(forKey: "logo") as? String
                let sport = result.value(forKey: "sport") as? String
                let league = FavLeagues(id: id, name: name, logo: logo, sport: sport)
                leagues.append(league)
            }
            print(leagues.count)
            return leagues
        } catch let error {
            print("Failed to fetch favorite leagues: \(error.localizedDescription)")
            return nil
        }
    }
    
    
    func deleteFromFavourite(leagueID: String) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let deleteRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FavLeague")
        deleteRequest.predicate = NSPredicate(format: "id == %@", leagueID)
        
        do {
            let results = try context.fetch(deleteRequest)
            for object in results {
                context.delete(object as! NSManagedObject)
            }
            try context.save()
        } catch let error {
            print("Failed to delete favorite league: \(error.localizedDescription)")
        }
    }
    
    func isSportFavorited(favLeague : FavLeagues) -> Bool {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let request: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "FavLeague")
        request.predicate = NSPredicate(format: "id == %@", favLeague.id ?? "no data")
        
        do {
            let count = try context.count(for: request)
            return count > 0
        } catch {
            print("Error checking if sport is favorited: \(error.localizedDescription)")
            return false
        }
    }
}

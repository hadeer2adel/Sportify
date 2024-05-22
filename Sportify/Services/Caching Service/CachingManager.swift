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
        } catch let error{
            print(error.localizedDescription)
        }
    }
}

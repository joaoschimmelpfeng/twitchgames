//
//  GameModel.swift
//  TwitchGames
//
//  Created by João Vitor dos Santos Schimmelpfeng on 31/01/18.
//  Copyright © 2018 João Vitor dos Santos Schimmelpfeng. All rights reserved.
//

import Foundation
import UIKit
import CoreData

struct GameModel {
    var id = 0
    var name = ""
    var imgUrl_high = ""
    var viewers = 0
    var isFavorite = false
    
    static func createModel(dictionary: NSDictionary?) -> GameModel? {
        guard let game = dictionary?["game"] as? NSDictionary,
            let id = game["_id"] as? Int,
            let name = game["name"] as? String,
            let viewers = dictionary?["viewers"] as? Int
            else {
                return nil
        }
        
        guard let imgJson = game["logo"] as? [String:Any],
            let high = imgJson["large"] as? String
            else {
                return nil
        }
        
        var model = GameModel()
        model.id = id
        model.name = name
        model.viewers = viewers
        model.imgUrl_high = high
        
        return model
    }
    
    fileprivate static func getContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    static func saveToCoreData(model: GameModel) {
        //checar duplicados
        let list = retrieveFavorites()
        for i in list where i.id == model.id{
            return
        }
        
        let context = getContext()
        let entity = NSEntityDescription.entity(forEntityName: "GameModelCore", in: context)
        let gameModel = NSManagedObject(entity: entity!, insertInto: context)
        gameModel.setValue(model.name, forKey: "name")
        gameModel.setValue(model.id, forKey: "id")
        gameModel.setValue(model.imgUrl_high, forKey: "imgpath")
        gameModel.setValue(model.viewers, forKey: "viewers")
        
        do {
            try context.save()
        } catch {
            print("Failed saving")
        }
    }
    
    static func retrieveFavorites() -> [GameModel]{
        let context = getContext()
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "GameModelCore")
        request.returnsObjectsAsFaults = false
        var models = [GameModel]()
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                guard let id = data.value(forKey: "id") as? Int,
                    let name = data.value(forKey: "name") as? String,
                    let imgpath = data.value(forKey: "imgpath") as? String,
                    let viewers = data.value(forKey: "viewers") as? Int else {
                        continue
                }
                var gameModel = GameModel()
                gameModel.id = id
                gameModel.name = name
                gameModel.imgUrl_high = imgpath
                gameModel.viewers = viewers
                models.append(gameModel)
            }
            return models
        } catch {
            print(#function, "Erro ao buscar dados.")
            return []
        }
    }
    
    static func getUpdateVersion(of model: GameModel) -> GameModel{
        var newModel = model
        let context = getContext()
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "GameModelCore")
        request.predicate = NSPredicate(format: "id == \(newModel.id)")
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            if result.count > 0 {
                newModel.isFavorite = true
            } else {
                newModel.isFavorite = false
            }
        } catch {
            print(#function, "Erro ao buscar dados.")
            return newModel
        }
        return newModel
    }
    
    static func removeFromCoredata(model: GameModel) {
        let context = getContext()
        do {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "GameModelCore")
            fetchRequest.predicate = NSPredicate(format: "id==\(model.id)")
            let result = try context.fetch(fetchRequest)
            for object in result {
                if let managedObject = object as? NSManagedObject {
                    context.delete(managedObject)
                }
            }
            
            try context.save()
        } catch {
            print(#function,"Erro ao deletar modelo.")
        }
    }
}

//
//  GameModel.swift
//  TwitchGames
//
//  Created by João Vitor dos Santos Schimmelpfeng on 31/01/18.
//  Copyright © 2018 João Vitor dos Santos Schimmelpfeng. All rights reserved.
//

import Foundation

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
}

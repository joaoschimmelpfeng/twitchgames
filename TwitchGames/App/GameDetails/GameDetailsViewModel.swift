//
//  GameDetailsViewModel.swift
//  TwitchGames
//
//  Created by João Vitor dos Santos Schimmelpfeng on 28/01/18.
//  Copyright © 2018 João Vitor dos Santos Schimmelpfeng. All rights reserved.
//

import RxSwift

class GameDetailsViewModel {
    var title = Variable<String>("")
    var imageUrl = Variable<URL?>(nil)
    var visualization = Variable<String>("")
    var favoriteColor = Variable<UIColor>(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0))
    
    var model: GameModel? {
        didSet {
            title.value = model?.name ?? ""
            visualization.value = "Número de visualizações: \(model?.viewers ?? 0)"
            if let imgUrl = URL(string: model?.imgUrl_high ?? "") {
                imageUrl.value = imgUrl
            }
            if model?.isFavorite ?? false {
                favoriteColor.value = .yellow
            } else {
                favoriteColor.value = .gray
            }
        }
    }
    
    func favorite() {
        if model?.isFavorite ?? false {
            model?.isFavorite = false
            GameModel.removeFromCoredata(model: model!)
            favoriteColor.value = UIColor.gray
        } else {
            if let consistentModel = self.model {
                GameModel.saveToCoreData(model: consistentModel)
            }
            favoriteColor.value = UIColor.yellow
            model?.isFavorite = true
        }
    }
}

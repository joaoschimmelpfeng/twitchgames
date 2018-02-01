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
    
    var model: GameModel? {
        didSet {
            title.value = model?.name ?? ""
            visualization.value = "Número de visualizações: \(model?.viewers ?? 0)"
            if let imgUrl = URL(string: model?.imgUrl_high ?? "") {
                imageUrl.value = imgUrl
            }
        }
    }
}

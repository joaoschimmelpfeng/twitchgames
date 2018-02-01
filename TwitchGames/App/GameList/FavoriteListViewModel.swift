//
//  FavoriteListViewModel.swift
//  TwitchGames
//
//  Created by João Vitor dos Santos Schimmelpfeng on 28/01/18.
//  Copyright © 2018 João Vitor dos Santos Schimmelpfeng. All rights reserved.
//

import Foundation
import RxSwift

class FavoriteListViewModel: ListViewModel {
    var modelList: Variable<[GameModel]> = Variable<[GameModel]>([])
    var segueTuple: Variable<(String, GameModel)> =
        Variable<(String, GameModel)>(("",GameModel()))
    var isRefreshing = Variable<Bool>(false)
    var alertTuple = Variable<(String, String)?>(nil)
    
    func loadModels() {
        
    }
    
    func search(keyword: String) {
            fatalError("Favoritos nao possui searchbar.")
    }
    
    func didSelectItem(indexPath: IndexPath?) {
        guard let row = indexPath?.row,
            row < modelList.value.count  else {
                return
        }
        segueTuple.value = ("toGameDetails", modelList.value[row])
    }
}

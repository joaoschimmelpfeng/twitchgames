//
//  GameListViewModel.swift
//  TwitchGames
//
//  Created by João Vitor dos Santos Schimmelpfeng on 27/01/18.
//  Copyright © 2018 João Vitor dos Santos Schimmelpfeng. All rights reserved.
//

import Foundation
import RxSwift

class GameListViewModel: ListViewModel {
    var modelList: Variable<[GameModel]> = Variable<[GameModel]>([])
    var segueTuple = Variable<(String, GameModel)>(("",GameModel()))
    var isRefreshing = Variable<Bool>(false)
    var alertTuple = Variable<(String, String)?>(nil)
    
    let disposeBag = DisposeBag()
    
    var skip = 0
    var keyword = ""
    let limit = 10
    
    func loadModels() {
        //Não carregar mais caso esteja pesquisando por palavra-chave
        if !keyword.isEmpty {
            return
        }
        
        TwichService.getTopGames(skip: skip, limit: limit).subscribe(
        
            onSuccess: {[unowned self] models in
                if self.modelList.value.count <= 0 {
                    self.modelList.value = models
                } else {
                    for i in models {
                        self.modelList.value.append(i)
                    }
                }
                self.skip += self.limit
                self.isRefreshing.value = false
            },
            
            onError: { error in
                self.alertTuple.value = ("ERRO!","Verifique sua conexão com a internet e tente novamente mais tarde")
                self.isRefreshing.value = false
                print("Failed to retrieve customer models.\n"+error.localizedDescription)
                
            }
        
        ).disposed(by: disposeBag)
    }
    
    func search(keyword: String) {
        self.keyword = keyword
        if keyword.isEmpty {
            skip = 0
            modelList.value = []
            loadModels()
            return
        }
        
        modelList.value = modelList.value.filter {
            $0.name.lowercased().contains(keyword.lowercased())
        }
    }
    
    func didSelectItem(indexPath: IndexPath?) {
        guard let row = indexPath?.row,
            row < modelList.value.count  else {
            return
        }
        segueTuple.value = ("toGameDetails", modelList.value[row])
    }
}

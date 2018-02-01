//
//  ListViewModel.swift
//  TwitchGames
//
//  Created by João Vitor dos Santos Schimmelpfeng on 27/01/18.
//  Copyright © 2018 João Vitor dos Santos Schimmelpfeng. All rights reserved.
//

import Foundation
import RxSwift
protocol ListViewModel {
    var modelList:Variable<[GameModel]> { get }
    var segueTuple: Variable<(String, GameModel)> { get }
    var isRefreshing: Variable<Bool> { get }
    var alertTuple: Variable<(String, String)?> { get }
    
    func loadModels()
    func loadFavoritesList()
    func search(keyword: String)
    func didSelectItem(indexPath: IndexPath?)
}

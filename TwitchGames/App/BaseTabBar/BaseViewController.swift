//
//  BaseViewController.swift
//  TwitchGames
//
//  Created by João Vitor dos Santos Schimmelpfeng on 28/01/18.
//  Copyright © 2018 João Vitor dos Santos Schimmelpfeng. All rights reserved.
//

import Foundation
import UIKit

class BaseViewController: UIViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "gameToDetail" {
            if let vc1 =  segue.destination as? TopGameListViewController {
                vc1.isFavoriteList = false
            }
        } else if segue.identifier == "favoriteToDetail" {
            if let vc2 =  segue.destination as? TopGameListViewController {
                vc2.isFavoriteList = true
            }
        }
    }
}

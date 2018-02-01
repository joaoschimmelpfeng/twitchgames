//
//  GameListCell.swift
//  TwitchGames
//
//  Created by João Vitor dos Santos Schimmelpfeng on 27/01/18.
//  Copyright © 2018 João Vitor dos Santos Schimmelpfeng. All rights reserved.
//

import UIKit
import Nuke

class GameListCell: UICollectionViewCell {
    @IBOutlet weak var imageGameCover: UIImageView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    
    var model: GameModel? {
        didSet {
            labelTitle.text = model?.name ?? ""
            if let imgUrl = URL(string: model?.imgUrl_high ?? "") {
                Manager.shared.loadImage(with: imgUrl, into: imageGameCover)
            }
            if model?.isFavorite ?? false {
                favoriteButton.setTitleColor(UIColor.yellow , for: .normal)
            }
        }
    }
    
    @IBAction func favoriteTouchUp(_ sender: Any) {
        favoriteButton.setTitleColor(UIColor.yellow , for: .normal)
    }
    
}
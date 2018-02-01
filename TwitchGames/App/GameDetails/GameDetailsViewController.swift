//
//  GameDetailsViewController.swift
//  TwitchGames
//
//  Created by João Vitor dos Santos Schimmelpfeng on 28/01/18.
//  Copyright © 2018 João Vitor dos Santos Schimmelpfeng. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class GameDetailsViewController: UIViewController {
    @IBOutlet weak var imageGameCover: UIImageView!
    @IBOutlet weak var labelGameTitle: UILabel!
    @IBOutlet weak var labelVisualization: UILabel!
    
    let viewModel = GameDetailsViewModel()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        bindUI()
        
        let rightButtonItem = UIBarButtonItem.init(
            title: "★",
            style: .plain,
            target: self,
            action: #selector(GameDetailsViewController.didSelectFavorites)
        )
        rightButtonItem.tintColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        self.navigationItem.rightBarButtonItem = rightButtonItem
    }
    
    func bindUI() {
        viewModel.title.asDriver()
            .drive(labelGameTitle.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.visualization.asDriver()
            .drive(labelVisualization.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.imageUrl.asDriver()
            .drive(imageGameCover.rx.imageFromWeb)
            .disposed(by: disposeBag)
    }
    
    @objc func didSelectFavorites() {
        
    }
}

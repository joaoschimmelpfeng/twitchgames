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
        
        let rightButtonItem = UIBarButtonItem.init(
            title: "★",
            style: .plain,
            target: self,
            action: #selector(GameDetailsViewController.didSelectFavorites)
        )
        //rightButtonItem.tintColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        rightButtonItem.tintColor = .gray
        let font = UIFont.systemFont(ofSize: 30)
        rightButtonItem.setTitleTextAttributes([NSAttributedStringKey.font: font], for: .normal)
        self.navigationItem.rightBarButtonItem = rightButtonItem
        bindUI()
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
        if let barbutton = self.navigationItem.rightBarButtonItem {
            viewModel.favoriteColor.asDriver()
                .drive(barbutton.rx.color)
                .disposed(by: disposeBag)
        }
    }
    
    @objc func didSelectFavorites() {
        viewModel.favorite()
    }
}

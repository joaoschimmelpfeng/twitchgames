//
//  ViewController.swift
//  TwitchGames
//
//  Created by João Vitor dos Santos Schimmelpfeng on 27/01/18.
//  Copyright © 2018 João Vitor dos Santos Schimmelpfeng. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import CCBottomRefreshControl

class TopGameListViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    let disposeBag = DisposeBag()
    var isFavoriteList: Bool? {
        didSet {
            if isFavoriteList ?? false {
                viewModel = FavoriteListViewModel()
                
            } else {
                viewModel = GameListViewModel()
            }
        }
    }
    
    let refreshControl = UIRefreshControl()
    var viewModel:ListViewModel?
    
    override func viewDidLoad() {
        if isFavoriteList ?? false {
            self.searchBar.removeFromSuperview()
            self.navigationItem.title = "Favoritos"
        } else {
            self.navigationItem.title = "Top Jogos"
            bindSearchBar()
        }
        
        //CollectionView
        let nib = UINib(nibName: "GameListCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "GameListCell")
        collectionView.delegate = self
        collectionView.alwaysBounceVertical = true
        refreshControl.triggerVerticalOffset = 100.0
        refreshControl.addTarget(self, action: #selector(TopGameListViewController.loadMoreModels), for: .valueChanged)
        self.collectionView.bottomRefreshControl = refreshControl
        
        bindSegue()
        bindAlert()
        bindRefreshControl()
        bindCollectionView()
        viewModel?.loadFavoritesList()
        viewModel?.loadModels()
        collectionView.invalidateIntrinsicContentSize()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel?.loadFavoritesList()
    }
    
    func bindSearchBar() {
        searchBar.rx.searchButtonClicked.subscribe { [weak self] _ in
            guard let `self` = self else { return }
            self.viewModel?.search(keyword: self.searchBar.text ?? "" )
            }.disposed(by: disposeBag)
    }
    
    func bindAlert() {
        viewModel?.alertTuple.asDriver()
            .drive(self.rx.showSimplAlert)
            .disposed(by: disposeBag)
    }
    
    func bindRefreshControl() {
        viewModel?.isRefreshing.asDriver()
            .drive(refreshControl.rx.isRefreshing)
            .disposed(by: disposeBag)
    }
    
    func bindSegue() {
        viewModel?.segueTuple.asDriver()
            .drive(self.rx.segueForGame)
            .disposed(by: disposeBag)
    }
    
    func bindCollectionView() {
        viewModel?.modelList.asDriver()
            .drive(collectionView.rx.items(cellIdentifier: "GameListCell", cellType:
                GameListCell.self)) { _, model, cell in
                cell.model = model
            }.disposed(by: disposeBag)
        
        collectionView.rx.itemSelected
            .subscribe { [unowned self] indexPath in
                self.viewModel?.didSelectItem(indexPath: indexPath.element)
            }.disposed(by: disposeBag)
        
    }
    
    @objc func loadMoreModels() {
        viewModel?.loadModels()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let vc =  segue.destination as? GameDetailsViewController,
            let model = sender as? GameModel else{
            return
        }
        vc.viewModel.model = model
    }
}

extension TopGameListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width
        var cellWidth:CGFloat = 0
        if width > 500 {
            cellWidth = (width - 30) / 4
        } else {
            cellWidth = (width - 30) / 2
        }
        
        return CGSize(width: cellWidth, height: cellWidth + 43)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.item == ((viewModel?.modelList.value.count ?? -1) - 1) {
            if !refreshControl.isRefreshing {
                viewModel?.loadModels()
            }
        }
    }
}


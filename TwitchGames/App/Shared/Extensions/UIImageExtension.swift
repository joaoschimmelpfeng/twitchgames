//
//  UIImageExtension.swift
//  TwitchGames
//
//  Created by João Vitor dos Santos Schimmelpfeng on 28/01/18.
//  Copyright © 2018 João Vitor dos Santos Schimmelpfeng. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Nuke

extension Reactive where Base: UIImageView {
    var imageFromWeb: Binder<URL?> {
        return Binder(self.base) { imgView, url in
            guard url != nil else {
                return
            }
            Manager.shared.loadImage(with: url!, into: imgView)
        }
    }
}

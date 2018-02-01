//
//  UiBarButtonItemExtension.swift
//  TwitchGames
//
//  Created by João Vitor dos Santos Schimmelpfeng on 01/02/18.
//  Copyright © 2018 João Vitor dos Santos Schimmelpfeng. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import UIKit

extension Reactive where Base:UIBarButtonItem {
    var color: Binder<UIColor> {
        return Binder(self.base) { button, color in
            button.tintColor = color
        }
    }
}

//
//  ViewControllerExtension.swift
//  TwitchGames
//
//  Created by João Vitor dos Santos Schimmelpfeng on 28/01/18.
//  Copyright © 2018 João Vitor dos Santos Schimmelpfeng. All rights reserved.
//

import RxSwift
import RxCocoa
import UIKit

extension Reactive where Base: UIViewController {
    /*Bind especifico para esse projeto, no mundo real o correto seria fazer este
     bind de forma generica, para reutilizar, como nesse projeto só temos essas duas telas
     faz mais sentido monta-lo pronto para o uso.
     */
    var segueForGame: Binder<(String, GameModel)?> {
        return Binder(self.base) { controller, content in
            guard let (segue, model) = content,
                !segue.isEmpty else {
                return
            }
            controller.performSegue(withIdentifier: segue, sender: model)
        }
    }
    
    public var showSimplAlert: Binder<(String, String)?> {
        return Binder(self.base) { controller, text in
            guard let forcedText = text else {
                return
            }
            let (title, message) = forcedText
            let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            controller.present(alert, animated: true, completion: nil)
        }
    }

}

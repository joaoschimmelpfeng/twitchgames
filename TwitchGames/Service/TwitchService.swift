//
//  TwitchService.swift
//  TwitchGames
//
//  Created by João Vitor dos Santos Schimmelpfeng on 28/01/18.
//  Copyright © 2018 João Vitor dos Santos Schimmelpfeng. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift

enum TwitchError: Error {
    case invalidURL
    case emptyModel
}

class TwichService {
    
    static func getTopGames(skip: Int, limit: Int) -> Single<[GameModel]> {
        return Single<[GameModel]>.create { single in
            guard let url = URL(string: Network.url+"?offset=\(skip)&limit=\(limit)") else {
                return single(.error(TwitchError.invalidURL)) as! Disposable
            }
            
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.setValue(Network.clientID, forHTTPHeaderField: "Client-ID")
            request.timeoutInterval = 10
            
            var modelList = [GameModel]()
            Alamofire.request(request).validate().responseJSON { response in
                if let json = response.result.value as? NSDictionary,
                    let jsonContent = json["top"] as? NSArray{
                    for element in jsonContent {
                        guard let model = GameModel.createModel(dictionary: element as? NSDictionary) else {
                            continue
                        }
                        modelList.append(model)
                    }
                }
                
                if(modelList.count <= 0) {
                    return single(.error(TwitchError.emptyModel))
                } else {
                    return single(.success(modelList))
                }
                
            }
            return Disposables.create { }
        }
    }
}

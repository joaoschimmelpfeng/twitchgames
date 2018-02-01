//
//  Entity+CoreDataProperties.swift
//  
//
//  Created by João Vitor dos Santos Schimmelpfeng on 01/02/18.
//
//

import Foundation
import CoreData


extension GameModelCore {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<GameModelCore> {
        return NSFetchRequest<GameModelCore>(entityName: "GameModelCore")
    }

    @NSManaged public var name: String?
    @NSManaged public var id: Int64
    @NSManaged public var imgpath: String?
    @NSManaged public var viewers: Int64

}

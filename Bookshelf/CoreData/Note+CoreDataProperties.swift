//
//  Note+CoreDataProperties.swift
//  Bookshelf
//
//  Created by 강관구 on 2022/04/09.
//
//

import Foundation
import CoreData

extension Note {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Note> {
        return NSFetchRequest<Note>(entityName: "Note")
    }

    @NSManaged public var content: String?
    @NSManaged public var isbn13: String?

}

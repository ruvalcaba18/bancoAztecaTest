//
//  FavoriteShows+CoreDataProperties.swift
//  grupoSalinasTest
//
//  Created by Jael on 8/14/20.
//  Copyright © 2020 Jael. All rights reserved.
//
//

import Foundation
import CoreData


extension FavoriteShows {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavoriteShows> {
        return NSFetchRequest<FavoriteShows>(entityName: "FavoriteShows")
    }

    @NSManaged public var externals: String?
    @NSManaged public var summary: String?
    @NSManaged public var imagen: String?
    @NSManaged public var name: String?

}

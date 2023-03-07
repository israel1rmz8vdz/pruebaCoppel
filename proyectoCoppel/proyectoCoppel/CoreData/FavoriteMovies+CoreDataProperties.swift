//
//  FavoriteMovies+CoreDataProperties.swift
//  proyectoCoppel
//
//  Created by Israel Macbook on 06/03/23.
//
//

import Foundation
import CoreData
extension FavoriteMovies {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavoriteMovies> {
        return NSFetchRequest<FavoriteMovies>(entityName: "FavoriteMovies")
    }
    @NSManaged public var id: String?
    @NSManaged public var name: String?
    @NSManaged public var voteAverage: Double
    @NSManaged public var image: String?
    @NSManaged public var overview: String?
    @NSManaged public var firstDate: String?
}
extension FavoriteMovies : Identifiable {
}

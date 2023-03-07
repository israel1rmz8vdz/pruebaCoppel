//
//  CoreDataImplementation.swift
//  proyectoCoppel
//
//  Created by Israel Macbook on 06/03/23.
//

import Foundation
import CoreData
final class CoreDataImplementation {
    // Singleton de la implementacion de CoreData
    public static let shared = CoreDataImplementation()
    private init() { }
    // Core data persistent container
    public lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "proyectoCoppel")
        container.loadPersistentStores { storeDescription, error in
            if let error = error as NSError? {
                dump(error)
            }
        }
        return container
    }()
    // Funcion para guardar datos siempre que haya un cambio
    // en el contexto de core data
    public func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                dump(error)
            }
        }
    }
}

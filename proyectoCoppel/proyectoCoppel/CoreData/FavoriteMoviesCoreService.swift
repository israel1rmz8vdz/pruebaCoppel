//
//  FavoriteMoviesCoreService.swift
//  proyectoCoppel
//
//  Created by Israel Macbook on 06/03/23.
//

import Foundation
import CoreData
import UIKit
fileprivate enum CoreDataThrowableError: Error {
    case invalidViewContext
    case invalidResult
    case invalidFetchRequest
}
fileprivate enum CoreDataMoviesEntities: String {
    case favoriteMovie = "FavoriteMovies"
}

final class FavoriteMoviesCoreService {
    // Singleton del servicio de core data para las peliculas
    static let shared = FavoriteMoviesCoreService()
    private init() { }
    // View context del core data traido desde el AppDelegate
    private lazy var viewContext: NSManagedObjectContext = {
        guard let application = UIApplication.shared.delegate as? AppDelegate else { fatalError("Error on get app delegate") }
        let viewContext = application.coreDataManager.persistentContainer.viewContext
        return viewContext
    }()
    // Obtiene todos las peliculas favoritas desde el core data
    func getListMovies(completion: @escaping (Result<[FavoriteMovies], Error>) -> ()) {
        let request: NSFetchRequest<FavoriteMovies> = NSFetchRequest(entityName: CoreDataMoviesEntities.favoriteMovie.rawValue)
        do {
            let result = try viewContext.fetch(request)
            DispatchQueue.main.async {
                completion(.success(result))
            }
        } catch {
            DispatchQueue.main.async {
                completion(.failure(error))
            }
        }
    }
    /// Guarda una pelicula con su entidad requerida en el core data
    func setCapture(movie: (ResultSetTable),completion: @escaping (Result<Void, Error>) -> ()) {
        let newItemId = String(movie.id ?? 0)
        let contextRequest: NSFetchRequest<FavoriteMovies> = NSFetchRequest(entityName: CoreDataMoviesEntities.favoriteMovie.rawValue)
        let query = NSPredicate(format: "%K == %@", "id", newItemId as CVarArg)
        contextRequest.predicate = query
        do {
            let results = try viewContext.fetch(contextRequest)
            if results.isEmpty {
                let captured = FavoriteMovies(context: viewContext)
                captured.id  = newItemId
                captured.name = movie.name
                captured.image = movie.posterPath
                captured.overview = movie.overview
                captured.firstDate = movie.firstAirDate
                captured.voteAverage = movie.voteAverage ?? 0.0
                try viewContext.save()
                DispatchQueue.main.async {
                    completion(.success(()))
                }
            } else {
                DispatchQueue.main.async {
                    let errorTemp = NSError(domain:"", code:1, userInfo:nil)
                    completion(.failure(errorTemp))
                }
            }
        } catch let error as NSError {
            DispatchQueue.main.async {
                completion(.failure(error))
            }
            
        }
    }
    ///Obtiene una pelicula por id
    func getOneMovie(movie id: String, completion: @escaping (Result<FavoriteMovies, Error>) -> ()) {
        do {
             if let result = try getOneById(context: viewContext, id: id) {
                DispatchQueue.main.async {
                    completion(.success(result))
                }
            } else {
                DispatchQueue.main.async {
                    let errorTemp = NSError(domain:"", code:1, userInfo:nil)
                    completion(.failure(errorTemp))
                }
            }
        } catch {
            DispatchQueue.main.async {
                completion(.failure(error))
            }
        }
    }
    ///Elimina una pelicula desde core data
    func deleteMovie(movie id: String, completion: @escaping (Result<Void, Error>) -> ()) {
        do {
            let movie = try getOneById(context: viewContext, id: id)
            if let movieDelete = movie {
                viewContext.delete(movieDelete)
                try viewContext.save()
                DispatchQueue.main.async {
                    completion(.success(()))
                }
            } else {
                DispatchQueue.main.async {
                    let errorTemp = NSError(domain:"", code:1, userInfo:nil)
                    completion(.failure(errorTemp))
                }
            }
        } catch {
            print(error)
            DispatchQueue.main.async {
                completion(.failure(error))
            }
        }
    }
    ///Ayudante para obtener una pelicula con su id
    private func getOneById(context: NSManagedObjectContext ,id: String) throws -> FavoriteMovies? {
        let request: NSFetchRequest<FavoriteMovies> = NSFetchRequest(entityName: CoreDataMoviesEntities.favoriteMovie.rawValue)
        request.fetchLimit = 1
        request.predicate = NSPredicate(format: "id = %@", id)
        do {
            let result = try context.fetch(request)
            if result.isEmpty {
                return nil
            } else {
                return result[0]
            }
        } catch {
            return nil
        }
    }
}

//
//  ProfileProtocol.swift
//  proyectoCoppel
//
//  Created by Israel Macbook on 04/03/23.
//  
//

import Foundation
import UIKit
/// Protocolo que define los métodos y atributos para el view de Profile
protocol ProfileViewProtocol {
    // PRESENTER -> VIEW
    /**
    Función encargada de regresar con la respuesta del servicio
     - Parameter entity: entidad repsuesta el servicio para los datos del perfil.
     */
    func responseSuccessProfile(entity: ResponseGetProfile)
    /// Función que responde cuando el servicio de perfil detecta un error.
    func responseErrorProfile()
    /**
    Función encargada de regresar la entidad de peliculas en lista de favoritos
     - Parameter entity: entidad respuesta del listado de peliculas core data
     */
    func responseGetFavoriteList(entity: [FavoriteMovies])
}
/// Protocolo que define los métodos y atributos para el routing de Profile
protocol ProfileRouterProtocol {
    // PRESENTER -> ROUTING
}
/// Protocolo que define los métodos y atributos para el Presenter de Profile
protocol ProfilePresenterProtocol {
    // VIEW -> PRESENTER
    /// Funcion que manda a llamar el servicio del interactor para perfiles
    func getProfileDataPresenter()
    /// Función encargada de llamar el listado de peliculas favoritos desde core data
    func getFavoriteMoviesPresenter()
}
/// Protocolo que define los métodos y atributos para el Interactor de Profile
protocol ProfileInteractorInputProtocol {
    // PRESENTER -> INTERACTOR
    /// Función que regresa la respuesta despues de obtener la información de perfiles
    func getProfileDataInteractor()
    /// Funcion encarfada de obtener el servicio de session id para obtener la información de perfil
    func getProfileSessionIdInteractor()
    /// Funcion encargada de obtener listado de core data
    func getFavoriteMoviesInteractor()
}
/// Protocolo que define los métodos y atributos para el Interactor de Profile
protocol ProfileInteractorOutputProtocol {
    // INTERACTOR -> PRESENTER
    /// Función respuesta de exito del servicio perfil
    func responseSuccessProfile(entity: ResponseGetProfile)
    /// Función respuesta de error del servicio perfil
    func responseErrorProfile()
    /// Función que regresa listado de peliculas favoritas
    func responseGetFavoriteList(entity: [FavoriteMovies])
}


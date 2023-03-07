//
//  DashboardProtocol.swift
//  proyectoCoppel
//
//  Created by Israel Macbook on 03/03/23.
//  
//

import Foundation
import UIKit
/// Protocolo que define los métodos y atributos para el view de Dashboard
protocol DashboardViewProtocol {
    // PRESENTER -> VIEW
    /**
    Función encargada de regresar exitoso el servicio de listado de peliculas
     - Parameter entity: entidad de repsuesta
     */
    func responseSuccess(entity: ResponseTvShows)
    /**
    Función encargada de regresar error el servicio de listado de peliculas
     - Parameter message: mensaje de error
     */
    func responseError(message: String)
}
/// Protocolo que define los métodos y atributos para el routing de Dashboard
protocol DashboardRouterProtocol {
    // PRESENTER -> ROUTING
    func showProfileRouter()
    func showMovieDetailRouter(entity: ResultSetTable)
}
/// Protocolo que define los métodos y atributos para el Presenter de Dashboard
protocol DashboardPresenterProtocol {
    // VIEW -> PRESENTER
    /// Función encargada de llamar la pantalla de perfil
    func showProfilePresenter()
    /**
    Función encargada de enviar  el servicio de listado de peliculas
     - Parameter urlType: tipo de servicio a consumir
     */
    func getMoviesListPresenter(urlType: typeFilter)
    /**
    Función encargada de enviar a la pantalal de detalle de pelicula
     - Parameter entity: entidad de result para pelicula
     */
    func showMovieDetailPresenter(entity: ResultSetTable)
}
/// Protocolo que define los métodos y atributos para el Interactor de Dashboard
protocol DashboardInteractorInputProtocol {
    // PRESENTER -> INTERACTOR
    /**
    Función encargada de enviar  el servicio de listado de peliculas
     - Parameter urlType: tipo de servicio a consumir
     */
    func getMoviesListInteractor(urlType: typeFilter) 
}
/// Protocolo que define los métodos y atributos para el Interactor de Dashboard
protocol DashboardInteractorOutputProtocol {
    // INTERACTOR -> PRESENTER
    /**
    Función encargada de regresar exitoso el servicio de listado de peliculas
     - Parameter entity: entidad de repsuesta
     */
    func responseSuccess(entity: ResponseTvShows)
    /**
    Función encargada de regresar error el servicio de listado de peliculas
     - Parameter message: mensaje de error
     */
    func responseError(message: String)
}


//
//  MovieDetailProtocol.swift
//  proyectoCoppel
//
//  Created by Israel Macbook on 06/03/23.
//  
//

import Foundation
import UIKit
/// Protocolo que define los métodos y atributos para el view de MovieDetail
protocol MovieDetailViewProtocol {
    // PRESENTER -> VIEW
    /**
    Función encargada de regresar el servicio mediante una urlSession
     - Parameter entity: entidad repsuesta el servicio para los datosde pelicula
     */
    func responseSuccessDetail(entity: ResponseMovieDetail)
    /// Función de error para detalle de pelicula
    func responseErrorDetail(message: String)
    /// Funcion respuesta success de listado de pelicula favorita
    func responseSuccessFavoriteList()
    /// Funcion de error para listado de pelicula favorita
    /// - Parameter message: mensaje de error
    func responseErrorFavoriteList(message: String)
    /**
    Función encargada de regresar bandera si es pelicula agregada a favoritos
     - Parameter flag: bandera que indica si esta en favoritos
     */
    func getDataMovieList(flag: Bool)
    /// Funcion encargada de regresar si la pelicula se elimino exitosamente
    func deleteDataMovie()
    /// Función encargada de regresar si ocurrio algun problema al eliminar una pelicula del listado de favoritos
    func deleteDataMovieError()
    func detailMovieVideo(entity: movieVideoResponse)
}
/// Protocolo que define los métodos y atributos para el routing de MovieDetail
protocol MovieDetailRouterProtocol {
    // PRESENTER -> ROUTING
}
/// Protocolo que define los métodos y atributos para el Presenter de MovieDetail
protocol MovieDetailPresenterProtocol {
    // VIEW -> PRESENTER
    /**
    Función encargada de llamar el presentaer para flujo viper servicio detalle de pelicula
     - Parameter idMovie: id pelicula
     */
    func getMovieDetailPresenter(idMovie: String)
    /**
    Función encargada de guardar pelicula en favoritos core data
     - Parameter data: entidad
     */
    func addMovieFavoriteListPresenter(data: ResultSetTable)
    /**
    Función encargada de regresar si la pelicula esta en favoritos
     - Parameter id: id pelicula
     */
    func getDataMoviePresenter(id: String)
    /**
    Función encargada de eliminar pelicula
     - Parameter id: id de pelicula
     */
    func deleteDataMoviePresenter(id: String)
    func getMovieVideoDetailPresenter(id: String)
}
/// Protocolo que define los métodos y atributos para el Interactor de MovieDetail
protocol MovieDetailInteractorInputProtocol {
    // PRESENTER -> INTERACTOR
    /**
     Función encargada de llamar el presentaer para flujo viper servicio detalle de pelicula
     - Parameter idMovie: id pelicula
     */
    func getMovieDetailInteractor(idMovie: String)
    /**
    Función encargada de guardar pelicula en favoritos core data
     - Parameter data: entidad
     */
    func addMovieFavoriteListInteractor(data: ResultSetTable)
    /**
    Función encargada de regresar si la pelicula esta en favoritos
     - Parameter id: id pelicula
     */
    func getDataMovieInteractor(id: String)
    /**
    Función encargada de eliminar pelicula
     - Parameter id: id de pelicula
     */
    func deleteDataMovieInteractor(id: String)
    func getMovieVideoDetailInteractor(id: String)
}
/// Protocolo que define los métodos y atributos para el Interactor de MovieDetail
protocol MovieDetailInteractorOutputProtocol {
    // INTERACTOR -> PRESENTER
    /**
    Función encargada de regresar exitoso el servicio de detalle de pelicula
     - Parameter entity: entidad de pelicula
     */
    func responseSuccessDetail(entity: ResponseMovieDetail)
    /**
    Función encargada de regresar error el servicio de detalle de pelicula
     - Parameter message: mensaje de error
     */
    func responseErrorDetail(message: String)
    /// Función encargada de regresar lisitado de favoritos
    func responseSuccessFavoriteList()
    /**
    Función encargada de regresar error el lsitado de favoritos
     - Parameter message: mensaje de errpr
     */
    func responseErrorFavoriteList(message: String)
    /**
    Función encargada de regresar exitoso el servicio de detalle de pelicula
     - Parameter entity: id de pelicula
     */
    func getDataMovieList(flag: Bool)
    /**
    Función encargada de regresar exitoso al eliminar pelicula.
     */
    func deleteDataMovie()
    /**
    Función encargada de regresar error al eliminar pelicula.
     */
    func deleteDataMovieError()
    func detailMovieVideo(entity: movieVideoResponse)
}


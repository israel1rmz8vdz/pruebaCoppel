//
//  MovieDetailPresenter.swift
//  proyectoCoppel
//
//  Created by Israel Macbook on 06/03/23.
//  
//

import Foundation

final class MovieDetailPresenter: MovieDetailPresenterProtocol {
    var view: MovieDetailViewProtocol?
    var interactor: MovieDetailInteractorInputProtocol?
    var router: MovieDetailRouterProtocol?
    
    func getMovieDetailPresenter(idMovie: String) {
        interactor?.getMovieDetailInteractor(idMovie: idMovie)
    }
    func addMovieFavoriteListPresenter(data: ResultSetTable) {
        interactor?.addMovieFavoriteListInteractor(data: data)
    }
    func getDataMoviePresenter(id: String) {
        interactor?.getDataMovieInteractor(id: id)
    }
    func deleteDataMoviePresenter(id: String) {
        interactor?.deleteDataMovieInteractor(id: id)
    }
}
extension MovieDetailPresenter: MovieDetailInteractorOutputProtocol {
    func deleteDataMovieError() {
        view?.deleteDataMovieError()
    }
    
    func deleteDataMovie() {
        view?.deleteDataMovie()
    }
    func getDataMovieList(flag: Bool) {
        view?.getDataMovieList(flag: flag)
    }
    func responseSuccessFavoriteList() {
        view?.responseSuccessFavoriteList()
    }
    func responseErrorFavoriteList(message: String) {
        view?.responseErrorFavoriteList(message: message)
    }
    func responseSuccessDetail(entity: ResponseMovieDetail) {
        view?.responseSuccessDetail(entity: entity)
    }
    func responseErrorDetail(message: String) {
        view?.responseErrorDetail(message: message)
    }
    
}

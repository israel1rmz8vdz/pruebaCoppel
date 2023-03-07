//
//  DashboardPresenter.swift
//  proyectoCoppel
//
//  Created by Israel Macbook on 03/03/23.
//  
//

import Foundation

class DashboardPresenter: DashboardPresenterProtocol {
    var view: DashboardViewProtocol?
    var interactor: DashboardInteractorInputProtocol?
    var router: DashboardRouterProtocol?
    func showProfilePresenter() {
        router?.showProfileRouter()
    }
    func showMovieDetailPresenter(entity: ResultSetTable) {
        router?.showMovieDetailRouter(entity: entity)
    }
    func getMoviesListPresenter(urlType: typeFilter) {
        interactor?.getMoviesListInteractor(urlType: urlType)
    }
}
extension DashboardPresenter: DashboardInteractorOutputProtocol {
    func responseSuccess(entity: ResponseTvShows) {
        view?.responseSuccess(entity: entity)
    }
    func responseError(message: String) {
        view?.responseError(message: message)
    }
}

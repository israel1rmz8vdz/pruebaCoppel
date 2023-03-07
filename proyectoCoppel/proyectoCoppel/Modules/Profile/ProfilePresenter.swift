//
//  ProfilePresenter.swift
//  proyectoCoppel
//
//  Created by Israel Macbook on 04/03/23.
//  
//

import Foundation

final class ProfilePresenter: ProfilePresenterProtocol {
    var view: ProfileViewProtocol?
    var interactor: ProfileInteractorInputProtocol?
    var router: ProfileRouterProtocol?
    func getProfileDataPresenter() {
        interactor?.getProfileSessionIdInteractor()
    }
    func getFavoriteMoviesPresenter() {
        interactor?.getFavoriteMoviesInteractor()
    }
}
extension ProfilePresenter: ProfileInteractorOutputProtocol {
    func responseGetFavoriteList(entity: [FavoriteMovies]) {
        view?.responseGetFavoriteList(entity: entity)
    }
    func responseSuccessProfile(entity: ResponseGetProfile) {
        view?.responseSuccessProfile(entity: entity)
    }
    func responseErrorProfile() {
        view?.responseErrorProfile()
    }
}

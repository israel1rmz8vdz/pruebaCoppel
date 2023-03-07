//
//  LoginPresenter.swift
//  proyectoCoppel
//
//  Created by Israel Macbook on 03/03/23.
//  
//

import Foundation

final class LoginPresenter: LoginPresenterProtocol {
    var view: LoginViewProtocol?
    var interactor: LoginInteractorInputProtocol?
    var router: LoginRouterProtocol?
    func showDashboardPresenter() {
        router?.showDashboardRouter()
    }
    func getURLSessionPresenter() {
        interactor?.getURLSessionInteractor()
    }
    func getValidateLoginPresenter(entity: LoginRequest) {
        interactor?.getValidateLoginInteractor(entity: entity)
    }
}
extension LoginPresenter: LoginInteractorOutputProtocol {
    func responseSessionIdSuccess(entity: LoginSessionIdResponse) {
        view?.responseSessionIdSuccess(entity: entity)
    }
    func responseSuccess(entity: LoginResponse) {
        view?.responseSuccess(entity: entity)
    }
    func responseError(message: String) {
        view?.responseError(message: message)
    }
    
}

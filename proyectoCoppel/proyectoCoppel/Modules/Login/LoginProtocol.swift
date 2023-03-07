//
//  LoginProtocol.swift
//  proyectoCoppel
//
//  Created by Israel Macbook on 03/03/23.
//  
//
import Foundation
import UIKit
/// Protocolo que define los métodos y atributos para el view de LoginVC
protocol LoginViewProtocol {
    // PRESENTER -> VIEW
    func responseSuccess(entity: LoginResponse)
    func responseSessionIdSuccess(entity: LoginSessionIdResponse)
    func responseError(message: String)
}
/// Protocolo que define los métodos y atributos para el routing de LoginVC
protocol LoginRouterProtocol {
    // PRESENTER -> ROUTING
    func showDashboardRouter()
}
/// Protocolo que define los métodos y atributos para el Presenter de LoginVC
protocol LoginPresenterProtocol {
    // VIEW -> PRESENTER
    func showDashboardPresenter()
    
    func getURLSessionPresenter()
    
    func getValidateLoginPresenter(entity: LoginRequest)
}
/// Protocolo que define los métodos y atributos para el Interactor de LoginVC
protocol LoginInteractorInputProtocol {
    // PRESENTER -> INTERACTOR
    func getURLSessionInteractor()
    
    func getValidateLoginInteractor(entity: LoginRequest)
}
/// Protocolo que define los métodos y atributos para el Interactor de LoginVC
protocol LoginInteractorOutputProtocol {
    // INTERACTOR -> PRESENTER
    func responseSuccess(entity: LoginResponse)
    func responseSessionIdSuccess(entity: LoginSessionIdResponse)
    func responseError(message: String)
}


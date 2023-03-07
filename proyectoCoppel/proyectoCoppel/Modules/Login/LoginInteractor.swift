//
//  LoginInteractor.swift
//  proyectoCoppel
//
//  Created by Israel Macbook on 03/03/23.
//  
//

import Foundation
import UIKit
class LoginInteractor: LoginInteractorInputProtocol {
    var presenter: LoginInteractorOutputProtocol?
    func getURLSessionInteractor() {
        APIManager.shared.delegate = self
        APIManager.shared.prepareApiRequest(url: "https://api.themoviedb.org/3/authentication/token/new?api_key=eef5a2dbfd75c2d32d624dbeb2d5d4f6", methodApi: .get, entityBody: nil, serviceName: LoginSessionIdResponse.className)
    }
    func getValidateLoginInteractor(entity: LoginRequest) {
        APIManager.shared.delegate = self
        APIManager.shared.prepareApiRequest(url: "https://api.themoviedb.org/3/authentication/token/validate_with_login?api_key=eef5a2dbfd75c2d32d624dbeb2d5d4f6", methodApi: .post, entityBody: entity.toData, serviceName: LoginResponse.className)
        
    }
}
extension LoginInteractor: ApiServiceDelegate {
    func didReceiveError(error: Error?, data: Data?, serviceName: String) {
        switch serviceName {
        case LoginSessionIdResponse.className:
            presenter?.responseError(message: "Service.ErrorGeneric".localized)
        case LoginResponse.className:
            presenter?.responseError(message: "Service.ErrorGeneric".localized)
        default:
            break;
        }
    }
    func didReceiveData(data: Data, serviceName: String) {
        switch serviceName {
        case LoginSessionIdResponse.className:
            if let response = APIManager.shared.decode(LoginSessionIdResponse.self, from: data) {
                presenter?.responseSessionIdSuccess(entity: response)
            } else {
                presenter?.responseError(message: "Service.ErrorGeneric".localized)
            }
        case LoginResponse.className:
            if let response = APIManager.shared.decode(LoginResponse.self, from: data) {
                presenter?.responseSuccess(entity: response)
            } else {
                presenter?.responseError(message: "Service.ErrorGeneric".localized)
            }
        default:
            break;
        }
    }
}

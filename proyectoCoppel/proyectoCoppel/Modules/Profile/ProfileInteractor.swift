//
//  ProfileInteractor.swift
//  proyectoCoppel
//
//  Created by Israel Macbook on 04/03/23.
//  
//

import Foundation

final class ProfileInteractor: ProfileInteractorInputProtocol {
    var presenter: ProfileInteractorOutputProtocol?
    func getProfileSessionIdInteractor() {
        if CoppelUserDefaults.getSessionKey().isEmpty {
            APIManager.shared.delegate = self
            let url: String = "https://api.themoviedb.org/3/authentication/session/new?api_key=eef5a2dbfd75c2d32d624dbeb2d5d4f6"
            let entityRequest: SessionIdRequest = SessionIdRequest(sessionId: CoppelUserDefaults.getTokenKey())
            APIManager.shared.prepareApiRequest(url: url, methodApi: .post, entityBody: entityRequest.toData, serviceName: ResponseSessionId.className)
        } else {
            getProfileDataInteractor()
        }
    }
    func getProfileDataInteractor() {
        APIManager.shared.delegate = self
        let url: String = "https://api.themoviedb.org/3/account?api_key=eef5a2dbfd75c2d32d624dbeb2d5d4f6&session_id={SessionID}".replacingOccurrences(of: "{SessionID}", with: CoppelUserDefaults.getSessionKey())
        APIManager.shared.prepareApiRequest(url: url, methodApi: .get, entityBody: nil, serviceName: ResponseGetProfile.className)
    }
    func getFavoriteMoviesInteractor() {
        FavoriteMoviesCoreService.shared.getListMovies { result in
            switch result {
            case .success(let favoriteList):
                print(favoriteList)
                self.presenter?.responseGetFavoriteList(entity: favoriteList)
                break
            case .failure(_):
                break
            }
        }
    }
}
extension ProfileInteractor: ApiServiceDelegate {
    func didReceiveError(error: Error?, data: Data?, serviceName: String) {
        switch serviceName {
        case ResponseGetProfile.className:
            presenter?.responseErrorProfile()
        case ResponseSessionId.className:
            presenter?.responseErrorProfile()
        default: break
        }
    }
    func didReceiveData(data: Data, serviceName: String) {
        switch serviceName {
        case ResponseGetProfile.className:
            if let response = APIManager.shared.decode(ResponseGetProfile.self, from: data) {
                presenter?.responseSuccessProfile(entity: response)
            } else {
                presenter?.responseErrorProfile()
            }
        case ResponseSessionId.className:
            if let response = APIManager.shared.decode(ResponseSessionId.self, from: data) {
                if let token = response.requestToken {
                    CoppelUserDefaults.setSessionKey(value: token)
                    getProfileDataInteractor()
                } else {
                    presenter?.responseErrorProfile()
                }
            } else {
                presenter?.responseErrorProfile()
            }
        default:
            break;
        }
    }
}

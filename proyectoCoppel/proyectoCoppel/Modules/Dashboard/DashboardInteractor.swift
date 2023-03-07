//
//  DashboardInteractor.swift
//  proyectoCoppel
//
//  Created by Israel Macbook on 03/03/23.
//  
//

import Foundation
class DashboardInteractor: DashboardInteractorInputProtocol {
    var presenter: DashboardInteractorOutputProtocol?
    func getMoviesListInteractor(urlType: typeFilter) {
        APIManager.shared.delegate = self
        var url: String = ""
        switch urlType {
        case .popular:
            url = "https://api.themoviedb.org/3/tv/popular"
        case .top:
            url = "https://api.themoviedb.org/3/tv/top_rated"
        case .onTV:
            url = "https://api.themoviedb.org/3/tv/on_the_air"
        case .today:
            url = "https://api.themoviedb.org/3/tv/airing_today"
        }
        url += "?api_key=eef5a2dbfd75c2d32d624dbeb2d5d4f6&language=en-US&page=1"
        APIManager.shared.prepareApiRequest(url: url, methodApi: .get, entityBody: nil, serviceName: ResponseTvShows.className)
    }
}
extension DashboardInteractor: ApiServiceDelegate {
    func didReceiveError(error: Error?, data: Data?, serviceName: String) {
        presenter?.responseError(message: "Service.ErrorGeneric".localized)
    }
    func didReceiveData(data: Data, serviceName: String) {
        switch serviceName {
        case ResponseTvShows.className:
            if let response = APIManager.shared.decode(ResponseTvShows.self, from: data) {
                presenter?.responseSuccess(entity: response)
            } else {
                presenter?.responseError(message: "Service.ErrorGeneric".localized)
            }
        default:
            break;
        }
    }
}

//
//  MovieDetailInteractor.swift
//  proyectoCoppel
//
//  Created by Israel Macbook on 06/03/23.
//  
//

import Foundation

final class MovieDetailInteractor: MovieDetailInteractorInputProtocol {
    var presenter: MovieDetailInteractorOutputProtocol?
    func getMovieDetailInteractor(idMovie: String) {
        APIManager.shared.delegate = self
        let url: String = baseUrl.base + baseUrl.movieDetail.replacingOccurrences(of: "{idMovie}", with: idMovie)
        APIManager.shared.prepareApiRequest(url: url, methodApi: .get, entityBody: nil, serviceName: ResponseMovieDetail.className)
    }
    func getMovieVideoDetailInteractor(id: String) {
        APIManager.shared.delegate = self
        let url: String = baseUrl.base + baseUrl.movieVideo.replacingOccurrences(of: "{idMovie}", with: id)
        APIManager.shared.prepareApiRequest(url: url, methodApi: .get, entityBody: nil, serviceName: movieVideoResponse.className)
    }
    func addMovieFavoriteListInteractor(data: ResultSetTable) {
        FavoriteMoviesCoreService.shared.setCapture(movie:data, completion: { result in
            switch result {
            case .success(_):
                self.presenter?.responseSuccessFavoriteList()
            case .failure(let error):
                self.presenter?.responseErrorFavoriteList(message: error.localizedDescription)
            }
        })
    }
    func getDataMovieInteractor(id: String) {
        FavoriteMoviesCoreService.shared.getOneMovie(movie: id, completion: { result in
            switch result {
            case .success(_):
                self.presenter?.getDataMovieList(flag: true)
            case .failure(_):
                self.presenter?.getDataMovieList(flag: false)
            }
        })
    }
    func deleteDataMovieInteractor(id: String) {
        FavoriteMoviesCoreService.shared.deleteMovie(movie: id, completion: { result in
            switch result {
            case .success(_):
                self.presenter?.deleteDataMovie()
            case .failure(_):
                self.presenter?.deleteDataMovieError()
                
            }
        })
    }
}
extension MovieDetailInteractor: ApiServiceDelegate {
    func didReceiveError(error: Error?, data: Data?, serviceName: String) {
        presenter?.responseErrorDetail(message: "Service.ErrorGeneric".localized)
    }
    func didReceiveData(data: Data, serviceName: String) {
        switch serviceName {
        case ResponseMovieDetail.className:
            if let response = APIManager.shared.decode(ResponseMovieDetail.self, from: data) {
                presenter?.responseSuccessDetail(entity: response)
            } else {
                presenter?.responseErrorDetail(message: "Service.ErrorGeneric".localized)
            }
        case movieVideoResponse.className:
            if let response = APIManager.shared.decode(movieVideoResponse.self, from: data) {
                presenter?.detailMovieVideo(entity: response)
            } else {
                presenter?.responseErrorDetail(message: "Service.ErrorGeneric".localized)
            }
        default:
            break;
        }
    }
}

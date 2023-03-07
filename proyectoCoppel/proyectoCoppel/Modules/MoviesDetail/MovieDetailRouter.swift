//
//  MovieDetailRouter.swift
//  proyectoCoppel
//
//  Created by Israel Macbook on 06/03/23.
//  
//

import Foundation
import UIKit

final class MovieDetailRouter {
    public var view: MovieDetailVC
    private var presenter: MovieDetailPresenter
    private var interactor: MovieDetailInteractor
    init() {
        self.view = MovieDetailVC()
        self.presenter = MovieDetailPresenter()
        self.interactor = MovieDetailInteractor()
        view.presenter = self.presenter
        presenter.view = self.view
        presenter.interactor = self.interactor
        presenter.router = self
        interactor.presenter = self.presenter
    }
    convenience init(entity: ResultSetTable) {
        self.init()
        view.dataMovie = entity
    }
}
extension MovieDetailRouter: MovieDetailRouterProtocol {
}


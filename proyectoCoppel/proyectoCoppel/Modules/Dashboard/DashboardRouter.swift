//
//  DashboardRouter.swift
//  proyectoCoppel
//
//  Created by Israel Macbook on 03/03/23.
//  
//

import Foundation
import UIKit

class DashboardRouter: DashboardRouterProtocol {
    public var view: DashboardVC
    private var presenter: DashboardPresenter
    private var interactor: DashboardInteractor
    init() {
        self.view = DashboardVC()
        self.presenter = DashboardPresenter()
        self.interactor = DashboardInteractor()
        view.presenter = self.presenter
        presenter.view = self.view
        presenter.interactor = self.interactor
        presenter.router = self
        interactor.presenter = self.presenter
    }
    func showProfileRouter() {
        let viewProfile: ProfileRouter = ProfileRouter()
        viewProfile.view.modalPresentationStyle = .automatic
        self.view.navigationController?.present(viewProfile.view, animated: true, completion: nil)
    }
    func showMovieDetailRouter(entity: ResultSetTable) {
        let viewDetail: MovieDetailRouter = MovieDetailRouter(entity: entity)
        self.view.navigationController?.pushViewController(viewDetail.view, animated: true)
    }
}


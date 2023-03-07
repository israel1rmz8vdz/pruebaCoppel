//
//  LoginRouter.swift
//  proyectoCoppel
//
//  Created by Israel Macbook on 03/03/23.
//  
//

import Foundation
import UIKit

class LoginRouter: LoginRouterProtocol {
    public var view: LoginVC
    private var presenter: LoginPresenter
    private var interactor: LoginInteractor
    private var window: UIWindow?
    init() {
        self.view = LoginVC()
        self.presenter = LoginPresenter()
        self.interactor = LoginInteractor()
        view.presenter = self.presenter
        presenter.view = self.view
        presenter.interactor = self.interactor
        presenter.router = self
        interactor.presenter = self.presenter
    }
    func showDashboardRouter() {
        let viewDashboard: DashboardRouter = DashboardRouter()
        self.view.navigationController?.pushViewController(viewDashboard.view, animated: true)
    }
}

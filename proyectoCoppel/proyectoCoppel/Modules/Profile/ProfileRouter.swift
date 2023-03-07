//
//  ProfileRouter.swift
//  proyectoCoppel
//
//  Created by Israel Macbook on 04/03/23.
//  
//

import Foundation
import UIKit

final class ProfileRouter {
    public var view: ProfileVC
    private var presenter: ProfilePresenter
    private var interactor: ProfileInteractor
    init() {
        self.view = ProfileVC()
        self.presenter = ProfilePresenter()
        self.interactor = ProfileInteractor()
        view.presenter = self.presenter
        presenter.view = self.view
        presenter.interactor = self.interactor
        presenter.router = self
        interactor.presenter = self.presenter
    }
}
extension ProfileRouter: ProfileRouterProtocol {
}


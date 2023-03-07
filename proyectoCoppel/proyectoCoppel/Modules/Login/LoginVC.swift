//
//  LoginVC.swift
//  proyectoCoppel
//
//  Created by Israel Macbook on 03/03/23.
//  
//

import Foundation
import UIKit

final class LoginVC: BaseViewController {
    @IBOutlet fileprivate weak var txtUser: UITextField!
    @IBOutlet fileprivate weak var txtPassword: UITextField!
    @IBOutlet fileprivate weak var lblMessageError: UILabel!
    var presenter: LoginPresenterProtocol?
    var sessionID: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.showProgressLoader()
        setStyle()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        presenter?.getURLSessionPresenter()
    }
    /// Función encargada de agregar estilo a la pantalla
    func setStyle() {
        self.setGradientBackground()
        txtUser.delegate = self
        txtPassword.delegate = self
    }
    @IBAction func btnLogIn(_ sender: UIButton) {
        self.dismissKeyboard()
        let entity = LoginRequest(userName: txtUser.text ?? "", password: txtPassword.text ?? "", sessionId: sessionID)
        self.view.showProgressLoader()
        presenter?.getValidateLoginPresenter(entity: entity)
    }
}
///Protocolo para recibir datos de presenter.
extension LoginVC: LoginViewProtocol {
    func responseSessionIdSuccess(entity: LoginSessionIdResponse) {
        sessionID = (entity.requestToken ?? "")
        self.view.removeProgressLoader()
    }
    func responseSuccess(entity: LoginResponse) {
        self.view.removeProgressLoader()
        if entity.success {
            CoppelUserDefaults.setTokenKey(value: entity.requestToken ?? "")
            presenter?.showDashboardPresenter()
            lblMessageError.isHidden = true
        } else {
            lblMessageError.isHidden = false
        }
    }
    func responseError(message: String) {
        let alert = UIAlertController(title: "", message: "Service.ErrorGeneric".localized, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Continue", style: .default, handler: { _ in }))
        present(alert, animated: true, completion: nil)
        self.view.removeProgressLoader()
    }
}
extension LoginVC: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        viewToShow = textField
        return true
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        resignFirstResponder(textField)
        return true
    }
    func resignFirstResponder(_ textField: UITextField) {
        switch textField {
        case txtUser:
            txtPassword.becomeFirstResponder()
        case txtPassword:
            dissmissKeyBoard()
        default:
            break
        }
    }
}

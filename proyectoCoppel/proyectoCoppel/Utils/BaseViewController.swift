//
//  BaseViewController.swift
//  proyectoCoppel
//
//  Created by Israel Macbook on 04/03/23.
//

import Foundation
import UIKit
class BaseViewController: UIViewController {
     /// **UIView** que se desea ser visible cuando se muestra el teclado.
     var viewToShow: UIView!
     /// Bandera para establecer si el teclado contiene toolbar.
     var viewToSuscribeContainsToolbar = true
     /// Bandera que dice si el teclado está visible.
     var isShowingKeyboard = false
     /// Objeto que almacena el título del navigation bar.
     var titleNavBar = ""
     /// Variable que determina cuanto se debe de mover la vista.
     var delta: CGFloat = 0.0
     /// Variable para guardar la posición original de la vista.
     var originCenter: CGPoint?
    override func viewDidLoad() {
        super.viewDidLoad()
        setTap()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        if let title = self.title, !title.isEmpty {
            titleNavBar = title
        }
        self.title = titleNavBar
        self.navigationController?.navigationBar.barTintColor = UIColor(named: "navBar") ?? UIColor.darkGray
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        if #available(iOS 13.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = UIColor(named: "navBar") ?? UIColor.darkGray
            appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
            self.navigationController?.navigationBar.standardAppearance = appearance;
        } else {
            // Fallback on earlier versions
        }
        if #available(iOS 13.0, *) {
            self.navigationController?.navigationBar.scrollEdgeAppearance = self.navigationController?.navigationBar.standardAppearance
        } else {
            // Fallback on earlier versions
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        originCenter = self.view.center
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.title = ""
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    /// Funcion para aplicar el gradiente de background
    func setGradientBackground() {
        let colorTop =  UIColor(named: "PrincipalTop")?.cgColor ?? UIColor.blue.cgColor
        let colorBottom = UIColor(named: "PrincipalBottom")?.cgColor ?? UIColor.white.cgColor
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 0.6]
        gradientLayer.frame = self.view.bounds
        self.view.layer.insertSublayer(gradientLayer, at:0)
    }
    /// Función que oculta el teclado al hacer tap dentro de la vista.
    func setTap() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        self.view.addGestureRecognizer(tap)
    }
    /// Función objetivo para ocultar teclado
    @objc func dismissKeyboard() {
        self.view.endEditing(true)
    }
    /// Función que regresa la navegación a la vista raíz.
    @objc func popAllView() {
        self.navigationController?.popToRootViewController(animated: true)
    }
    /// Función que regresa la navegación al inicio de cierta operación.
    @objc func popInitialOperation() {
        if let initialVC = self.navigationController?.viewControllers[1] {
            self.navigationController?.popToViewController((initialVC), animated: true)
        }
    }
    /// Función que regresa la navegación una pantalla atrás.
    @IBAction func back() {
        _ = self.navigationController?.popViewController(animated: true)
    }
    /// Función que oculta la vista actual cuando fue mostrado mediante un present modally.
    @IBAction func dismissViewController() {
        self.dismiss(animated: true, completion: nil)
    }
    /// Método para ocultar el teclado.
    func dissmissKeyBoard() {
        self.view.endEditing(true)
    }
    /**
     Método para mostrar el teclado.
     - Parameter notification: Objeto tipo **NSNotification** con la información de la notificación.
     */
    @objc func keyboardWillShow(notification: NSNotification) {
        if viewToShow == nil {
            return
        }
        let userInfo = notification.userInfo
        let kbSize = userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect
        if let viewBounds = self.viewToShow?.bounds {
            let relativeFrame = self.viewToShow?.convert(viewBounds, to: self.view)
            if let originY = relativeFrame?.origin.y, let sizeHeight = relativeFrame?.size.height, let kbHeight = kbSize?.height {
                let pivote = originY + sizeHeight
                let keyboardSize = viewToSuscribeContainsToolbar ? kbHeight + 70 : kbHeight
                if (self.view.bounds.size.height - keyboardSize) < pivote {
                    UIView.animate(withDuration: 0.3, animations: {
                        let auxDelta = self.delta
                        if let height = self.view?.bounds.size.height, let centerY = self.view?.center.y, let centerX = self.view?.center.x {
                            self.delta = ((height - keyboardSize)-pivote)
                            if self.isShowingKeyboard {
                                self.view?.center = CGPoint.init(x: centerX, y: centerY + (self.delta-auxDelta))
                            } else {
                                self.view?.center = CGPoint.init(x: centerX, y: centerY + self.delta)
                            }
                            self.isShowingKeyboard = true
                        }
                    })
                } else {
                    self.delta = 0
                    /// si el delta es 0, la vista debe volver a su posición original
                    if let center = originCenter, self.view.center != center {
                        self.view.center = center
                    }
                }
            }
        }
    }
    /**
    Método para ocultar el teclado.
       - Parameter notification: Objeto tipo **NSNotification** con la información de la notificación.
    */
    @objc func keyboardWillHide(notification: NSNotification) {
        if viewToShow == nil {
            return
        }
        if delta != 0 {
            UIView.animate(withDuration: 0.3, animations: {
                if let width = self.view?.bounds.size.width, let centerY = self.view?.center.y {
                    self.view?.center = CGPoint.init(x: width/2.0, y: centerY - self.delta)
                    self.isShowingKeyboard = false
                }
            })
        }
        /// si el delta es 0, la vista debe volver a su posición original
        if let center = originCenter, self.view.center != center {
            self.view.center = center
        }
        delta = 0
    }
}
extension UIView {
    func roundCorners(cornerRadii: CGFloat, corners: UIRectCorner) {
        clipsToBounds = true
        layer.cornerRadius = cornerRadii
        layer.maskedCorners = CACornerMask(rawValue: corners.rawValue)
    }
    /// Función encargada de mostrar el progress view
    func showProgressLoader() {
        let blurLoader = ProgressIIndicator(frame: frame)
        self.addSubview(blurLoader)
    }
    /// Función encargada de remover el progress view
    func removeProgressLoader() {
        if let blurLoader = subviews.first(where: { $0 is ProgressIIndicator }) {
            blurLoader.removeFromSuperview()
        }
    }
}
extension UIImageView {
    /**
     Función encargada de bajar la imagen mediante una url para su visualizacion de manera asincrona
     */
    func loadFromUrl(url: String){
        guard let url = URL(string: url) else { return }
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async { [weak self] in
                self?.image = UIImage(data: data)
            }
        }
        task.resume()
    }
}
extension UIView {
    /// Función que regresa el ancho y alto de la vista.
    /// - Returns: regresa una variable de tipo CGSize con el alto y el ancho
    func getSizeView() -> CGSize {
        let width: CGFloat = (self.frame.size.width - 42) / 2
        let height: CGFloat = width * 1.6
        return CGSize(width: width, height: height)
    }
    /// Función que regresa el ancho y alto de la vista.
    /// - Returns: regresa una variable de tipo CGSize con el alto y el ancho
    func getSizeViewHorizontal() -> CGSize {
        let width: CGFloat = (self.frame.size.width - 42) / 2.4
        let height: CGFloat = width * 1.6
        return CGSize(width: width, height: height)
    }
    /// Función que regresa el ancho y alto de la vista.
    /// - Returns: regresa una variable de tipo CGSize con el alto y el ancho
    func getSizeViewHorizontalVideo() -> CGSize {
        let width: CGFloat = (self.frame.size.width - 42) / 1.4
        let height: CGFloat = width * 1.6
        return CGSize(width: width, height: height)
    }
}

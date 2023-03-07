//
//  DashboardVC.swift
//  proyectoCoppel
//
//  Created by Israel Macbook on 03/03/23.
//  
//

import Foundation
import UIKit

final class DashboardVC: BaseViewController {
    @IBOutlet fileprivate weak var sgmOptions: UISegmentedControl!
    @IBOutlet fileprivate weak var collectionViewMovies: UICollectionView!
    var presenter: DashboardPresenterProtocol?
    var dataArray: [ResultSetTable]?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "DashboardVC.title".localized
        configCollectionView()
        setStyle()
        self.view.showProgressLoader()
        presenter?.getMoviesListPresenter(urlType: .popular)
    }
    /// Función encargada de cofigurar el collection view
    private func configCollectionView() {
        collectionViewMovies.delegate = self
        collectionViewMovies.dataSource = self
        collectionViewMovies.register(UINib(nibName: "collectionCellView", bundle: Bundle.main), forCellWithReuseIdentifier: "collectionCellView")
    }
    /// funcion encargada de dar estilo a la pantalla
    func setStyle() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action:
        #selector(DashboardVC.dismissKeyboard))
        view.addGestureRecognizer(tap)
        tap.cancelsTouchesInView = false
        self.navigationController?.navigationBar.isHidden = false
        self.navigationItem.setHidesBackButton(true, animated: true)
        self.navigationItem.rightBarButtonItem =  UIBarButtonItem(image: UIImage(systemName: "list.bullet"), style: .plain, target: self, action:  #selector(configurationTap))
        sgmOptions.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for:
          .normal)
    }
    /// Función para llamar alerta de opciones
    @objc func configurationTap() {
        ///
        let alert = UIAlertController(title: "", message: "DashboardVC.alert".localized, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "DashboardVC.btnProfile".localized, style: .default, handler: { _ in
            self.presenter?.showProfilePresenter()
        }))
        alert.addAction(UIAlertAction(title: "DashboardVC.btnLogOut".localized, style: .destructive, handler: { _ in
            let defaults = UserDefaults.standard
            let dictionary = defaults.dictionaryRepresentation()
            dictionary.keys.forEach { key in
                defaults.removeObject(forKey: key)
            }
            self.popAllView()
        }))
        alert.addAction(UIAlertAction(title: "DashboardVC.btnCancel".localized, style: .cancel, handler: { _ in }))
        present(alert, animated: true, completion: nil)
    }
    @IBAction func btnSegmentTap(_ sender: UISegmentedControl) {
        self.view.showProgressLoader()
        switch sender.selectedSegmentIndex {
        case 0:
            presenter?.getMoviesListPresenter(urlType: .popular)
        case 1:
            presenter?.getMoviesListPresenter(urlType: .top)
        case 2:
            presenter?.getMoviesListPresenter(urlType: .onTV)
        case 3:
            presenter?.getMoviesListPresenter(urlType: .today)
        default:
            self.view.removeProgressLoader()
            break
        }
    }
    
}
///Protocolo para recibir datos de presenter.
extension DashboardVC: DashboardViewProtocol {
    func responseSuccess(entity: ResponseTvShows) {
        dataArray = entity.resultSet
        collectionViewMovies.reloadData()
        self.view.removeProgressLoader()
    }
    
    func responseError(message: String) {
        let alert = UIAlertController(title: "", message: "Service.ErrorGeneric".localized, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Continue", style: .default, handler: { _ in }))
        present(alert, animated: true, completion: nil)
        self.view.removeProgressLoader()
    }
}
/// Extensión de la clase donde se configura el collection
extension DashboardVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return view.getSizeView()
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArray?.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell : collectionCellView = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCellView", for: indexPath) as? collectionCellView {
            if let dataCollection = dataArray?[indexPath.row] {
                cell.setCollectionData(entity: dataCollection)
                return cell
            }
        }
        return UICollectionViewCell()
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let dataCollection = dataArray?[indexPath.row] {
            presenter?.showMovieDetailPresenter(entity: dataCollection)
        }
    }
}

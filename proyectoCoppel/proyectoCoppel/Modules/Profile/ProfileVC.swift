//
//  ProfileVC.swift
//  proyectoCoppel
//
//  Created by Israel Macbook on 04/03/23.
//  
//

import Foundation
import UIKit

final class ProfileVC: BaseViewController {
    @IBOutlet fileprivate weak var lblTitle: UILabel!
    @IBOutlet fileprivate weak var imgProfile: UIImageView!
    @IBOutlet fileprivate weak var lblUser: UILabel!
    @IBOutlet fileprivate weak var lblFavorite: UILabel!
    @IBOutlet fileprivate weak var collectionViewFavortes: UICollectionView!
    var presenter: ProfilePresenterProtocol?
    var dataArray: [FavoriteMovies]?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.showProgressLoader()
        presenter?.getProfileDataPresenter()
        presenter?.getFavoriteMoviesPresenter()
        configCollectionView()
        setStyles()
    }
    private func configCollectionView() {
        collectionViewFavortes.delegate = self
        collectionViewFavortes.dataSource = self
        collectionViewFavortes.register(UINib(nibName: "collectionCellView", bundle: Bundle.main), forCellWithReuseIdentifier: "collectionCellView")
    }
    private func setStyles() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action:
        #selector(ProfileVC.dismissKeyboard))
        view.addGestureRecognizer(tap)
        tap.cancelsTouchesInView = false
        imgProfile.layer.cornerRadius = (imgProfile.frame.size.width) / 2
        imgProfile.clipsToBounds = true
    }
}
///Protocolo para recibir datos de presenter.
extension ProfileVC: ProfileViewProtocol {
    func responseGetFavoriteList(entity: [FavoriteMovies]) {
        dataArray = entity
        collectionViewFavortes.reloadData()
    }
    func responseSuccessProfile(entity: ResponseGetProfile) {
        if let image = entity.avatar?.tmdbData?.avatarPath, !image.isEmpty {
            imgProfile.loadFromUrl(url: baseUrl.image + image)
        }
        lblUser.text = "ProfileVC.userName".localized + (entity.username ?? "") + "\n" + "ProfileVC.user".localized + (entity.name ?? "")
        self.view.removeProgressLoader()
    }
    func responseErrorProfile() {
        let alert = UIAlertController(title: "", message: "Service.ErrorGeneric".localized, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Continue", style: .default, handler: { _ in }))
        present(alert, animated: true, completion: nil)
        self.view.removeProgressLoader()
    }
    
}
/// Extensión de la clase donde se configura el collection
extension ProfileVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return view.getSizeViewHorizontal()
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArray?.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell : collectionCellView = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCellView", for: indexPath) as? collectionCellView {
            if let dataCollection = dataArray?[indexPath.row] {
                cell.setCollectionDataFavorite(entity: dataCollection)
                return cell
            }
        }
        return UICollectionViewCell()
    }
}

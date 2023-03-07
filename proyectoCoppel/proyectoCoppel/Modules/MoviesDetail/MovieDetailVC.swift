//
//  MovieDetailVC.swift
//  proyectoCoppel
//
//  Created by Israel Macbook on 06/03/23.
//  
//

import Foundation
import UIKit

final class MovieDetailVC: BaseViewController {
    var presenter: MovieDetailPresenterProtocol?
    var dataMovie: ResultSetTable = ResultSetTable.init()
    @IBOutlet fileprivate weak var imgFace: UIImageView!
    @IBOutlet fileprivate weak var lblTitle: UILabel!
    @IBOutlet fileprivate weak var lblBody: UILabel!
    @IBOutlet fileprivate weak var collectionViewCompanies: UICollectionView!
    @IBOutlet weak var collectionVideo: UICollectionView!
    var dataCompanies: [ProductionCompanies]?
    var favorite: Bool = false
    var urlArray: [ResultVideo]?
    override func viewDidLoad() {
        super.viewDidLoad()
        if let idDetail = dataMovie.id {
            self.view.showProgressLoader()
            presenter?.getMovieDetailPresenter(idMovie: String(idDetail))
        }
        setStyle()
    }
    func setStyle() {
        self.setGradientBackground()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action:
        #selector(MovieDetailVC.dismissKeyboard))
        view.addGestureRecognizer(tap)
        tap.cancelsTouchesInView = false
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "star.fill"), style: .plain, target: self, action: #selector(configurationTap))
        configureCollection()
    }
    fileprivate func configureCollection() {
        let nib2 = UINib(nibName: "productionCompaniesViewCell", bundle: nil)
        self.collectionViewCompanies.register(nib2, forCellWithReuseIdentifier: "productionCompaniesViewCell")
        let nib = UINib(nibName: "videoCollectionViewCell", bundle: nil)
        self.collectionVideo.register(nib, forCellWithReuseIdentifier: "videoCollectionViewCell")
        
        collectionViewCompanies.delegate = self
        collectionViewCompanies.dataSource = self
        collectionVideo.delegate = self
        collectionVideo.dataSource = self
        collectionViewCompanies.reloadData()
        collectionVideo.reloadData()
        
    }
    /// Función para llamar alerta de opciones
    @objc func configurationTap() {
        if favorite {
            guard let idMovie = dataMovie.id else {return}
            presenter?.deleteDataMoviePresenter(id: String(idMovie))
        } else {
            presenter?.addMovieFavoriteListPresenter(data: dataMovie)
        }
    }
    func callVideoDetail() {
        guard let idMovie = dataMovie.id else {return}
        self.view.showProgressLoader()
        presenter?.getMovieVideoDetailPresenter(id: String(idMovie))
    }
}
///Protocolo para recibir datos de presenter.
extension MovieDetailVC: MovieDetailViewProtocol {
    func detailMovieVideo(entity: movieVideoResponse) {
        urlArray = entity.results
        collectionVideo.reloadData()
        self.view.removeProgressLoader()
    }
    
    func deleteDataMovieError() {
        print("Error")
    }
    
    func deleteDataMovie() {
        favorite = false
        let alert = UIAlertController(title: "MovieVC.DeleteMovie".localized, message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Continue", style: .default, handler: { _ in
            self.favorite = true
            self.navigationItem.rightBarButtonItem?.tintColor = UIColor.white
        }))
        present(alert, animated: true, completion: nil)
    }
    func getDataMovieList(flag: Bool) {
        favorite = flag
        if favorite {
            self.navigationItem.rightBarButtonItem?.tintColor = UIColor.yellow
        }
    }
    func responseSuccessFavoriteList() {
        ///
        let alert = UIAlertController(title: "MovieVC.AddFavorite".localized, message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Continue", style: .default, handler: { _ in
            self.favorite = true
            self.navigationItem.rightBarButtonItem?.tintColor = UIColor.yellow
        }))
        present(alert, animated: true, completion: nil)
    }
    func responseErrorFavoriteList(message: String) {
        let alert = UIAlertController(title: "MovieVC.AddedLaterFavorite".localized, message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Continue", style: .default, handler: { _ in
            self.navigationItem.rightBarButtonItem?.tintColor = UIColor.white
        }))
        present(alert, animated: true, completion: nil)
    }
    func responseSuccessDetail(entity: ResponseMovieDetail) {
        self.title = entity.name
        lblTitle.text = "MovieDetail.raiting".localized + (String(format: "%.2f", entity.voteAverage ?? 0.0))
        if let imagePath = entity.backdropPath, !imagePath.isEmpty{
            imgFace.loadFromUrl(url: baseUrl.image + imagePath)
        }
        lblBody.text = entity.overview
        dataCompanies = entity.productionCompanies
        collectionViewCompanies.reloadData()
        if let idMovie = entity.id {
            self.presenter?.getDataMoviePresenter(id: String(idMovie))
        }
        self.view.removeProgressLoader()
        self.callVideoDetail()
    }
    
    func responseErrorDetail(message: String) {
        self.view.removeProgressLoader()
        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Continue", style: .default, handler: { _ in }))
        present(alert, animated: true, completion: nil)
    }
    
}
/// Extensión de la clase donde se configura el collection
extension MovieDetailVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == collectionVideo {
            return view.getSizeViewHorizontalVideo()
        } else {
            return CGSize(width: 100.0, height: 80.0)
        }
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == collectionVideo {
            return urlArray?.count ?? 0
        } else {
            return dataCompanies?.count ?? 0
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == collectionViewCompanies {
            if let cell: productionCompaniesViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "productionCompaniesViewCell", for: indexPath) as? productionCompaniesViewCell {
                if let dataCollection = dataCompanies?[indexPath.row] {
                    cell.setData(data: dataCollection)
                    return cell
                }
            }
        } else {
            if let cell: videoCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "videoCollectionViewCell", for: indexPath) as? videoCollectionViewCell {
                if let keyVideo = urlArray?[indexPath.row].key {
                    cell.addPlayer(url: keyVideo)
                }
                return cell
           }
        }
        return UICollectionViewCell()
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}

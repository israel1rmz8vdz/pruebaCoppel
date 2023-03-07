//
//  collectionCellView.swift
//  proyectoCoppel
//
//  Created by Israel Macbook on 03/03/23.
//

import UIKit

class collectionCellView: UICollectionViewCell {
    @IBOutlet fileprivate weak var viewContent: UIView!
    @IBOutlet fileprivate weak var imgMovie: UIImageView!
    @IBOutlet fileprivate weak var lblTitle: UILabel!
    @IBOutlet fileprivate weak var lblDate: UILabel!
    @IBOutlet fileprivate weak var lblRaiting: UILabel!
    @IBOutlet fileprivate weak var lblDescription: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        viewContent.roundCorners(cornerRadii: self.frame.width/8, corners: [.allCorners])
    }
    func setCollectionData(entity: ResultSetTable) {
        imgMovie.loadFromUrl(url: baseUrl.image + (entity.posterPath ?? ""))
        lblTitle.text = entity.name
        lblDate.text = entity.firstAirDate
        lblRaiting.text = "\(entity.voteAverage ?? 0.0)"
        lblDescription.text = entity.overview
    }
    func setCollectionDataFavorite(entity: FavoriteMovies) {
        imgMovie.loadFromUrl(url: baseUrl.image + (entity.image ?? ""))
        lblTitle.text = entity.name
        lblDate.text = entity.firstDate
        lblRaiting.text = "\(entity.voteAverage)"
        lblDescription.text = entity.overview
    }
}
